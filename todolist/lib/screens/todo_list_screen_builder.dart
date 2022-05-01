import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/screens/placeholder_screen.dart';
import 'package:todolist/screens/todo_list_screen.dart';

import '../constants/strings.dart';
import '../models/firebase_status.dart';
import '../providers/todo_list_provider.dart';

///Contains a future builder to build the correct screens during when the app
///is downloading todoItems from firebase.

class TodoListScreenBuilder extends StatefulWidget {
  const TodoListScreenBuilder({Key? key}) : super(key: key);

  @override
  State<TodoListScreenBuilder> createState() => _TodoListScreenBuilderState();
}

class _TodoListScreenBuilderState extends State<TodoListScreenBuilder> {
  late Future<FirestoreResponse> initTodoList;

  @override
  void initState() {
    initTodoList =
        Provider.of<TodoListProvider>(context, listen: false).initTodoList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirestoreResponse>(
      future: initTodoList, //initialise todoList.
      builder: (context, snap) {
        if (!snap.hasData) {
          return const PlaceholderScreen(
            placeholder: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          final FirestoreResponse firestoreResponse = snap.data!;
          if (firestoreResponse == FirestoreResponse.error) {
            return const PlaceholderScreen(
              placeholder: Center(
                child: Text(errorMessage),
              ),
            );
          }
          return const TodoListScreen();
        }
      },
    );
  }
}
