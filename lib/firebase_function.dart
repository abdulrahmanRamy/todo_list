import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/model/my_user.dart';
import 'model/task.dart';

class FirebaseFunction {
  // create collection and know type
  static CollectionReference<Task> getTaskCollection(String uId) {
    return  getUsersCollection().doc(uId)
        .collection(Task.collectionName)
        .withConverter<Task>(
            // to know is stored
            fromFirestore: (snapShot, options) => Task.fromFireStore(snapShot.data()!),
            toFirestore: (task, options) => task.toFireStore()
    );
  }

  // add task to firebase
  static Future<void> addTaskToFirebase(Task task, String uId) {
    var taskCollection = getTaskCollection(uId,); // collection
    DocumentReference<Task> taskDocRef = taskCollection.doc(); // document
    task.id = taskDocRef.id; // auto id
    return taskDocRef.set(task);
  }

  static Future<void> deleteTaskFromFireStore(Task task, String uId)async{
    print(task.id);
     await getTaskCollection(uId).doc(task.id).delete();
  }

  static Future<void> editIsDone(Task task, String uId) {
    return getTaskCollection(uId).doc(task.id).update({'isDone' : !task.isDone});

  }

  static Future<void> editTask(Task task, String uId) {
    return getTaskCollection(uId).doc(task.id).update(task.toFireStore());
  }

  // static Future<void> updateTask(Task task) async{
  //   try{
  //     await getTaskCollection
  //   }
  //
  // }

  static CollectionReference<MyUser> getUsersCollection(){
    return FirebaseFirestore.instance.collection(MyUser.collectionName).
    withConverter<MyUser>(
        fromFirestore: (snapshot, options) => MyUser.fromFireStore(snapshot.data()),
        toFirestore: (myUser, options) => myUser.toFireStore()
    );


  }

  static Future<void> addUserToFireStore(MyUser myUser){
    return getUsersCollection().doc(myUser.id).set(myUser);
    
  }

  static Future<MyUser?> readUserFromFireStore(String uId)async{
    var querySnapshot = await getUsersCollection().doc(uId).get();
    return querySnapshot.data();
  }




}
