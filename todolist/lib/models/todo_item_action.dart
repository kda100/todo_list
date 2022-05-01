import 'package:todolist/helpers/enum_helper.dart';

///enum to control action to be performed on TodoItem.
enum TodoItemAction {
  add,
  edit,
}

class TodoItemActionConverter {
  static final EnumValues<TodoItemAction> _todoItemActions =
      EnumValues<TodoItemAction>({
    "Add": TodoItemAction.add,
    "Edit": TodoItemAction.edit,
  });

  ///gets the string equivalent of enum.
  static String encode(TodoItemAction todoItemAction) =>
      _todoItemActions.getTypeToValueMap[todoItemAction]!;
}
