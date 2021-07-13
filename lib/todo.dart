import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  Todo(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    this.documentReference = doc.reference;

    this.title = data['title'];

    final Timestamp timestamp = data['createdAt'];
    this.createdAt = timestamp.toDate();
  }

  late String title;
  late DateTime createdAt;
  bool isDone = false;
  late DocumentReference documentReference;
}
