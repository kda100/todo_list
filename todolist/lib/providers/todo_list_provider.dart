import 'package:flutter/material.dart';
import 'package:todolist/models/firebase_status.dart';
import 'package:todolist/models/todo_item.dart';
import 'package:todolist/models/todo_item_view_model.dart';
import 'package:todolist/services/firebase_service.dart';

///Provider is used to act as a communicator between the firebase backend and view objects.
///It also stores and manages the TodoItems in the TodoList.

class TodoListProvider with ChangeNotifier {
  final FirebaseServices _firebaseServices = FirebaseServices();
  final List<String> _deletedTodoIds =
      []; //ids of TodoItems to be deleted from firebase.
  List<TodoItem> _todoList = []; //stores TodoItems.

  int get getTodoItemsNum => _todoList.length;

  ///Used to get TodoItemViewModel for the view object.
  TodoItemViewModel getTodoViewModel({required int index}) {
    return TodoItemViewModel(index: index, todoItem: _todoList[index]);
  }

  ///function initialises the todoList by downloading the data from firestore.
  Future<FirestoreResponse> initTodoList() async {
    try {
      _todoList = await _firebaseServices.loadTodoList();
      return FirestoreResponse.success;
    } catch (e) {
      return FirestoreResponse.error;
    }
  }

  ///function used to save the current state of the todoList onto firestore, by communication with firebase service.
  Future<FirestoreResponse> saveTodoList() async {
    try {
      await _firebaseServices.saveTodoList(_todoList, _deletedTodoIds);
      return FirestoreResponse.success;
    } catch (e) {
      return FirestoreResponse.error;
    }
  }

  ///function used to sort todoList so the items are orders in descending times.
  void _sortTodoList() {
    _todoList.sort(
      (a, b) => a.date.millisecondsSinceEpoch
          .compareTo(b.date.millisecondsSinceEpoch),
    );
  }

  ///function adds a new item to the todoList.
  void addTodoItem(
      {required String title,
      required String description,
      required DateTime date}) {
    final String id = _firebaseServices.getNewId;
    _todoList.add(
      TodoItem(
        id: id,
        title: title,
        description: description,
        date: date,
      ),
    );
    _sortTodoList(); //sort needed after addition to maintain the order.
    notifyListeners();
  }

  ///removes item from todoList using the items index in the list.
  void deleteTodoItem({required int index}) {
    _deletedTodoIds.add(_todoList[index].id);
    _todoList.removeAt(index);
  }

  ///function used to update TodoItem in todoList.
  void updateTodoItem({
    required int index,
    required String newTitle,
    required String newDescription,
    required DateTime newDate,
  }) {
    final TodoItem todoItem = _todoList[index];
    final bool isSameMoment = todoItem.date.isAtSameMomentAs(newDate);
    if (todoItem.title != newTitle ||
        todoItem.description != newDescription ||
        !isSameMoment) {
      //checks if any of the date has changed before changing todoitem.
      _todoList[index] = todoItem.copyWith(
        newTitle: newTitle,
        newDescription: newDescription,
        newDate: newDate,
      );
      if (!isSameMoment) {
        _sortTodoList(); //sort to maintain order of list
      }
      notifyListeners();
    }
  }
}
