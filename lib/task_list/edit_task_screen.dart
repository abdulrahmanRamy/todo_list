import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/dialog_utils.dart';
import 'package:todo_list/home/app_colors.dart';
import '../auth/login/login_screen.dart';
import '../firebase_function.dart';
import '../model/task.dart';
import '../provider/app_provider.dart';
import '../provider/auth_user_Provider.dart';
import '../provider/list_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditTaskScreen extends StatefulWidget {
  static const String routeName = 'EditTaskScreen';
   EditTaskScreen({super.key});
  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}
class _EditTaskScreenState extends State<EditTaskScreen> {
  var formKey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  String title = '';
  String description = '';
  late ListProvider listProvider;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  Task? task;
  @override
  Widget build(BuildContext context) {
    if(task == null)
      {
        task = ModalRoute.of(context)!.settings.arguments as Task;
        titleController.text = task!.title ?? "";
        descController.text = task!.description ?? "";
        selectedDate = task!.dateTime ?? DateTime.now();
      }

    var listProvider = Provider.of<ListProvider>(context);
    var authProvider = Provider.of<AuthUserProvider>(context);
    var screenSize = MediaQuery.of(context).size;
    var provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
          actions: [
            IconButton(onPressed: (){
              listProvider.tasksList = [];
              authProvider.currentUser = null;
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            }, icon: Icon(Icons.logout))
          ],
        title: Text(AppLocalizations.of(context)!.todo_list,
            style: Theme.of(context).textTheme.titleLarge,)
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: screenSize.height*0.13,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: screenSize.height*0.07),
                    padding: EdgeInsets.symmetric(vertical: screenSize.height*0.05,
                    horizontal: screenSize.height*0.02,),
                    width: screenSize.width*0.8,
                    height: screenSize.height*0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Colors.white,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(child:
                        Text(AppLocalizations.of(context)!.edit_task,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.blackColor,))),
                        SizedBox(
                          height: screenSize.height*0.02,
                        ),
                        TextFormField(
                          controller: titleController,
                          // initialValue: task.title,
                          validator: (text){
                            if(text == null || text.isEmpty){
                              return 'Please enter task title';
                            }
                            return null;
                          },
                          // onChanged: (text){
                          //   title = text;
                          // },
                          decoration:  InputDecoration(
                            hintText: AppLocalizations.of(context)!.enter_task_title,
                            fillColor: Colors.grey.shade300,
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide.none),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: descController,
                          validator: (text) {
                            if(text == null || text.isEmpty){
                              return 'Please enter task desc';
                            }
                            return null;
                          },
                          // onChanged: (text){
                          //   description = text;
                          // },
                          decoration:  InputDecoration(
                            hintText: AppLocalizations.of(context)!.enter_task_description,
                            fillColor: Colors.grey.shade300,
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide.none),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(AppLocalizations.of(context)!.select_date,
                            style: Theme.of(context).textTheme.bodyMedium,),
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
                            editTask();
                          },
                          child: Text(AppLocalizations.of(context)!.save_changes,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.whiteColor),),
                        ),
                      ],
                                        ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }



  void showCalendar() async{
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365))
    );
    selectedDate = chosenDate ?? selectedDate;
    setState(() {});
  }

  void editTask() {
    //use formKey to use form
    //validate check all textFiled
    if (formKey.currentState?.validate() == true) {
      task!.title = titleController.text;
      task!.description = descController.text;
      task!.dateTime = selectedDate;
      var authProvider = Provider.of<AuthUserProvider>(context, listen: false);
      DialogUtils.showLoading(context: context, message: 'Waiting...');
      FirebaseFunction.editTask(task!, authProvider.currentUser!.id ?? "")
          .then((value) {
        DialogUtils.hideLoading(context);
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.task_edit_successfully,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    }else{
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.task_edit_successfully,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
      }
}
