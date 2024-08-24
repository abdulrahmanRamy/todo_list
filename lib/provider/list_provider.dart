import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../firebase_function.dart';
import '../model/task.dart';

class ListProvider extends ChangeNotifier {
  // data

  List<Task> tasksList =[];
  DateTime selectDate = DateTime.now();

  void getAllTasksFromFireStore()async{
    // get all tasks
    //collection => documents => data
    QuerySnapshot<Task> querySnapshot = await FirebaseFunction.getTaskCollection().get();   // get -> return obj to collection

    //List<QueryDocumentSnapshot<T>> => List<Task>  ----->  use map
    tasksList = querySnapshot.docs.map((doc){
      return doc.data();
    }).toList();
    // filter all tasks => select date
      tasksList= tasksList.where((task) {
        if (selectDate.day == task.dateTime.day &&
            selectDate.month == task.dateTime.month &&
            selectDate.year == task.dateTime.year) {
          return true;
        }
        return false;
      }).toList();

      // sorting
      tasksList.sort((Task task1, Task task2){
        return task1.dateTime.compareTo(task2.dateTime);
    });


    notifyListeners();
  }
  void changeSelectDate(DateTime newSelectDate){
    selectDate = newSelectDate;
    getAllTasksFromFireStore();
  }

}
