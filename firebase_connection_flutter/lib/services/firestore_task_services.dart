import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_connection_flutter/models/task.dart';

class FirestoreTaskService {
  final CollectionReference tasksCollection = FirebaseFirestore.instance
      .collection('tasks');

  Future<void> addTask(String title, String uid) async {
    await tasksCollection.add({
      "uid": uid,
      "title": title,
      "completed": false,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteTask(String taskId) async {
    await tasksCollection.doc(taskId).delete();
  }

  Future<void> toggleTask(String taskId, bool isCompleted) async {
    await tasksCollection.doc(taskId).update({"completed": !isCompleted});
  }

  Stream<List<Task>> getTasksStream(String uid) {
    return FirebaseFirestore.instance
        .collection("tasks")
        .where("uid", isEqualTo: uid)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Task.fromFirestore(doc)).toList(),
        );
  }
}
