import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/task.dart';

class FirebaseFunction {
  // create collection and know type
  static CollectionReference<Task> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            // to know is stored
            fromFirestore: (snapShot, options) =>
                Task.fromFireStore(snapShot.data()!),
            toFirestore: (task, options) => task.toFireStore());
  }



  // add task to firebase
  static Future<void> addTaskToFirebase(Task task) {
    var taskCollection = getTaskCollection(); // collection
    DocumentReference<Task> taskDocRef = taskCollection.doc(); // document
    task.id = taskDocRef.id; // auto id
    return taskDocRef.set(task);
  }

  static Future<void> deleteTaskFromFireStore(Task task)async{
    print(task.id);
     await getTaskCollection().doc(task.id).delete();
  }
}
