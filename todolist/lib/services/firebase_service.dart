import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/constants/firebase.dart';
import 'package:todolist/models/todo_item.dart';

///Firebase Service serves as a direct API between the app and the firestore database.
///The service moves data to and from the provider model when the provider requests it.

class FirebaseServices {
  //Singleton class.
  static final FirebaseServices _instance = FirebaseServices._();

  FirebaseServices._();

  factory FirebaseServices() {
    return _instance;
  }

  final CollectionReference todoListColRef = FirebaseFirestore.instance.collection(
      todoListColPath); //collection ref where todoItems are stored in firestore.

  String get getNewId =>
      todoListColRef.doc().id; //getter to get unique id for todoItem.

  ///function loads todoList from firebase when provide requests it and converts them into TodoItem objects.
  ///This is then communicated to the provider model.
  Future<List<TodoItem>> loadTodoList() async {
    final List<TodoItem> todoList = [];
    List<QueryDocumentSnapshot<Object?>> querySnapshot = (await todoListColRef
            .orderBy(
              dateField,
            )
            .get())
        .docs;
    for (QueryDocumentSnapshot queryDocSnap in querySnapshot) {
      final Map<String, dynamic> data =
          queryDocSnap.data() as Map<String, dynamic>;
      todoList.add(TodoItem.fromFirestore(queryDocSnap.id, data));
    }
    return todoList;
  }

  ///function saves current state of todoList. It takes in the current todoList and a list of deleted todoIds.
  Future<void> saveTodoList(
      List<TodoItem> todoList, List<String> deletedTodoIds) async {
    for (String id in deletedTodoIds) {
      //each id is deleted if it is in firestore.
      await todoListColRef.doc(id).delete();
    }
    deletedTodoIds
        .clear(); //clear deletedTodoIds so delete attempt is not made again.
    for (TodoItem todoItem in todoList) {
      if (todoItem.edited) {
        //only todoItems that have been edited/added are written to firestore.
        await todoListColRef.doc(todoItem.id).set(todoItem.toFirestore());
        todoItem.edited =
            false; //ensure todoEdit is false so it is not written again.
      }
    }
  }
}
