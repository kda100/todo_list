import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/constants/firebase.dart';

///model for each TodoItem in todolist.

class TodoItem {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  bool edited;

  TodoItem({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.edited = true,
  });

  TodoItem.fromFirestore(
      this.id, Map<String, dynamic> data) //constructor from firestore object.
      : title = data[titleField],
        description = data[descriptionField],
        date = data[dateField].toDate(),
        edited = false;

  Map<String, dynamic> toFirestore() => {
        //converts class to map for firestore to store.
        titleField: title,
        descriptionField: description,
        dateField: Timestamp.fromDate(date),
      };

  TodoItem copyWith({
    String? newTitle,
    String? newDescription,
    DateTime? newDate,
  }) {
    //function used to copy this class.
    return TodoItem(
      id: id,
      title: newTitle ?? title,
      description: newDescription ?? description,
      date: newDate ?? date,
    );
  }
}
