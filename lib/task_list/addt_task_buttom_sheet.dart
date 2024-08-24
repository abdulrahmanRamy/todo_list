import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/firebase_function.dart';
import 'package:todo_list/model/task.dart';
import '../provider/list_provider.dart';

class AddtTaskButtomSheet extends StatefulWidget {

   const AddtTaskButtomSheet({super.key});

  @override
  State<AddtTaskButtomSheet> createState() => _AddtTaskButtomSheetState();
}

class _AddtTaskButtomSheetState extends State<AddtTaskButtomSheet> {
  var formKey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  String title = '';
  String description = '';
  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
    return Container(
      margin: const EdgeInsets.all(12),
      child: Column(
        children: [
          Text('Add new Task',
          style: Theme.of(context).textTheme.titleMedium,
          ),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  validator: (text){
                    if(text == null || text.isEmpty){
                      return 'Please enter task title';
                    }
                    return null;
                  },
                  onChanged: (text){
                    title = text;
                  },
                  decoration: const InputDecoration(
                    hintText: ('Enter Task Title'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (text) {
                    if(text == null || text.isEmpty){
                      return 'Please enter task desc';
                    }
                    return null;
                  },
                  onChanged: (text){
                    description = text;
                  },
                  decoration: const InputDecoration(
                    hintText: ('Enter Task Description'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Select Date',
                  style: Theme.of(context).textTheme.bodyLarge,),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      showCalendar();
                    },
                    child: Text('${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,),
                  ),
                ),
                ElevatedButton(
                    onPressed: (){
                      addTask();
                    },
                    child: Text('Add',
                      style: Theme.of(context).textTheme.titleLarge,),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }

  void addTask() {
    //use formKey to use form
    //validate check all textFiled
    if(formKey.currentState?.validate() == true){
      // add task
      Task task = Task(
          title: title,
          description: description,
          dateTime: selectedDate,
      );
       FirebaseFunction.addTaskToFirebase(task).timeout(Duration(seconds: 1),
      onTimeout: (){
        print('task added successfully');
        listProvider.getAllTasksFromFireStore();
        Navigator.pop(context);
      });
    }
  }

  void showCalendar() async{
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365))
    );
    selectedDate = chosenDate ?? selectedDate;
    setState(() {

    });
  }
}
