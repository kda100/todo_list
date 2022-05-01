import 'package:todolist/models/todo_item.dart';

///This TodoItem Model is exposed to the view objects in the app.
class TodoItemViewModel {
  final int index;
  final TodoItem _todoItem;

  TodoItemViewModel({
    required this.index,
    required TodoItem todoItem,
  }) : _todoItem = todoItem;

  String get id => _todoItem.id;
  String get title => _todoItem.title;
  String get description => _todoItem.description;
  DateTime get date => _todoItem.date;
}
