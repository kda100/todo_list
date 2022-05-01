import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/constants/strings.dart';
import 'package:todolist/helpers/date_time_helper.dart';
import 'package:todolist/models/todo_item_action.dart';
import 'package:todolist/providers/todo_list_provider.dart';
import 'package:todolist/widgets/date_form_field.dart';

import '../models/todo_item_view_model.dart';
import '../widgets/custom_input_text_form_field.dart';

/// TodoItemScreen that contains a form that gives the user the ability to edit or add new todoItems.

class TodoItemScreen extends StatefulWidget {
  final TodoItemAction todoItemAction; //edit/add todoItem
  final TodoItemViewModel? todoItemViewModel;

  const TodoItemScreen(
      {Key? key, this.todoItemViewModel, required this.todoItemAction})
      : super(key: key);

  @override
  State<TodoItemScreen> createState() => _TodoItemScreenState();
}

class _TodoItemScreenState extends State<TodoItemScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _dateTextEditingController =
      TextEditingController();
  late TodoListProvider todoListProvider;
  late String title;
  late String description;
  late DateTime date;

  @override
  void initState() {
    todoListProvider = Provider.of<TodoListProvider>(context, listen: false);
    title = widget.todoItemViewModel?.title ?? "";
    description = widget.todoItemViewModel?.description ?? "";
    date = widget.todoItemViewModel?.date ?? DateTimeHelper.today();
    _dateTextEditingController.text =
        DateTimeHelper.formatDateTimeToString(date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${TodoItemActionConverter.encode(widget.todoItemAction)} Todo Item"),
      ),
      body: Form(
        //controls user inputs for todoItem.
        key: _formKey,
        child: SingleChildScrollView(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CustomInputTextFormField(
                    onSaved: (value) {
                      title = value!;
                    },
                    valueKeyString: titleFormFieldName,
                    labelText: titleFormFieldName,
                    initialValue: title,
                    maxLength: 30,
                  ),
                  CustomInputTextFormField(
                    onSaved: (value) {
                      description = value!;
                    },
                    labelText: descriptionFormFieldName,
                    valueKeyString: descriptionFormFieldName,
                    initialValue: description,
                    maxLength: 100,
                  ),
                  DateFormField(
                      onSaved: (value) {
                        date = DateTimeHelper.formatStringToDateTime(value!)!;
                      },
                      textEditingController: _dateTextEditingController),
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        if (widget.todoItemAction == TodoItemAction.add) {
                          todoListProvider.addTodoItem(
                              title: title,
                              description: description,
                              date: date);
                        } else if (widget.todoItemAction ==
                            TodoItemAction.edit) {
                          todoListProvider.updateTodoItem(
                              index: widget.todoItemViewModel!.index,
                              newTitle: title,
                              newDescription: description,
                              newDate: date);
                        }
                        Navigator.pop(context, true);
                      }
                    },
                    child: Text(
                      TodoItemActionConverter.encode(
                          widget.todoItemAction), //edit or add.
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
