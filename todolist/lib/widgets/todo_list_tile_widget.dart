import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/helpers/date_time_helper.dart';
import 'package:todolist/models/todo_item_action.dart';
import 'package:todolist/models/todo_item_view_model.dart';
import 'package:todolist/providers/todo_list_provider.dart';
import '../screens/todo_item_screen.dart';

///TodoListTile widget contains the data of the todoItem; description, title and date.
/// The user can swipe the item to remove it from their todoList.

class TodoListTile extends StatelessWidget {
  final TodoItemViewModel todoItemViewModel;

  const TodoListTile(this.todoItemViewModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TodoListProvider todoListProvider =
        Provider.of<TodoListProvider>(context, listen: false);
    return Dismissible(
      //deletes todoItem
      key: Key(
        todoItemViewModel.id, //key for dismissing item.
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        todoListProvider.deleteTodoItem(index: todoItemViewModel.index);
      },
      background: Container(
          child: const Icon(Icons.delete, color: Colors.red, size: 28),
          padding: const EdgeInsets.all(18),
          alignment: Alignment.centerRight),
      child: Card(
        elevation: 5,
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text(todoItemViewModel.title, //todoItem title.
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(todoItemViewModel.description), //todoItem description.
              const SizedBox(
                height: 5,
              ),
              Text(
                DateTimeHelper.formatDateTimeToString(//date of todoItem
                    todoItemViewModel.date),
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey),
              )
            ],
          ),
          contentPadding: const EdgeInsets.all(8),
          // horizontalTitleGap: 10,
          trailing: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TodoItemScreen(
                    //edit todoItem.
                    todoItemAction: TodoItemAction.edit,
                    todoItemViewModel: todoItemViewModel,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ),
      ),
    );
  }
}
