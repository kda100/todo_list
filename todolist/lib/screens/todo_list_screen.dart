import 'package:flutter/material.dart';
import 'package:todolist/constants/strings.dart';
import 'package:todolist/models/todo_item_action.dart';
import 'package:todolist/providers/todo_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:todolist/screens/todo_item_screen.dart';

import '../models/firebase_status.dart';
import '../widgets/todo_list_tile_widget.dart';

///main todoList screen that presents to the user all the todoItems.
///Its gives the user the ability to add new items, edit items, delete them and save the current state
///of the todolist.

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TodoListProvider todoListProvider =
        Provider.of<TodoListProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
        actions: [
          IconButton(
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const TodoItemScreen(
                        todoItemAction: TodoItemAction.add),
                  ),
                );
              },
              icon: const Icon(Icons.add)),
          IconButton(
            onPressed: () async {
              final FirestoreResponse firestoreResponse =
                  await todoListProvider.saveTodoList();
              String message = errorMessage;
              if (firestoreResponse == FirestoreResponse.success) {
                message = "Todo List successfully saved";
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Consumer<TodoListProvider>(
        builder: (context, todoListProvider, _) => ListView.builder(
          itemCount: todoListProvider.getTodoItemsNum,
          itemBuilder: (context, index) => TodoListTile(
            todoListProvider.getTodoViewModel(index: index),
          ),
          physics: const BouncingScrollPhysics(),
        ),
      ),
    );
  }
}
