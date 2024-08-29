import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/firebase_function.dart';
import 'package:todo_list/provider/app_provider.dart';
import 'package:todo_list/provider/list_provider.dart';
import '../home/app_colors.dart';
import '../model/task.dart';
import '../provider/auth_user_Provider.dart';
import 'edit_task_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskListItem extends StatefulWidget {
  Task task;
  TaskListItem({required this.task, super.key});

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var listProvider = Provider.of<ListProvider>(context);
    var authProvider = Provider.of<AuthUserProvider>(context);
    var provider = Provider.of<AppProvider>(context);
    return Container(
      margin: const EdgeInsets.all(12),
      child:
          // Slidable(
          //   key: key,
          //   // The start action pane is the one at the left or the top side.
          //   startActionPane: ActionPane(
          //     extentRatio: 0.5,
          //     // A motion is a widget used to control how the pane animates.
          //     motion: const DrawerMotion(),
          //
          //     // A pane can dismiss the Slidable.
          //     dismissible: DismissiblePane(onDismissed: () {}),
          //
          //     // All actions are defined in the children parameter.
          //     children:  [
          //       // A SlidableAction can have an icon and/or a label.
          //       SlidableAction(
          //         borderRadius: BorderRadius.circular(15),
          //         onPressed: (context){
          //           // delete
          //           FirebaseFunction.deleteTaskFromFireStore(task).timeout(
          //               Duration(seconds: 1),
          //           onTimeout: (){
          //                 print('tasked deleted successfully');
          //                 listProvider.getAllTasksFromFireStore();
          //
          //           });
          //         },
          //         backgroundColor: AppColors.redColor,
          //         foregroundColor: AppColors.whiteColor,
          //         icon: Icons.delete,
          //         label: 'Delete',
          //       ),
          //       SlidableAction(
          //         borderRadius: BorderRadius.circular(15),
          //         onPressed: (context){
          //           // edit
          //         },
          //         backgroundColor: AppColors.primaryColor,
          //         foregroundColor: AppColors.whiteColor,
          //         icon: Icons.edit,
          //         label: 'Share',
          //       ),
          //     ],
          //   ),
          Slidable(
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                // delete
                FirebaseFunction.deleteTaskFromFireStore(widget.task, authProvider.currentUser!.id!).
                then((value) {
                  print('tasked deleted successfully');
                  listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
                } )
                    .timeout(Duration(seconds: 1), onTimeout: () {
                  print('tasked deleted successfully');
                  listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
                });
              },
              icon: Icons.delete,
              backgroundColor: Colors.red,
              label: AppLocalizations.of(context)!.delete,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            SlidableAction(
              onPressed: (_) {
                Navigator.pushNamed(context, EditTaskScreen.routeName, arguments: widget.task);
              },
              icon: Icons.edit,
              backgroundColor: Colors.blue,
              label: AppLocalizations.of(context)!.edit,
              borderRadius: BorderRadius.all(Radius.circular(15))
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : Colors.white,
              borderRadius: BorderRadius.circular(22)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(12),
                color: widget.task.isDone ? AppColors.greenColor :AppColors.primaryColor,
                height: height * 0.1,
                width: 4,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.title,
                      // copyWith to edit
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: widget.task.isDone ? AppColors.greenColor :AppColors.primaryColor,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      widget.task.description,
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  var authProvider = Provider.of<AuthUserProvider>(context, listen: false);
                  FirebaseFunction.editIsDone(widget.task, authProvider.currentUser?.id ??"");
                  widget.task.isDone = !widget.task.isDone;
                  setState(() {

                  });
                },
                child: widget.task.isDone ? Text(AppLocalizations.of(context)!.done,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.greenColor),): Container(
                  padding: EdgeInsets.symmetric(
                    vertical: height * 0.01,
                    horizontal: width * 0.05,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.primaryColor,
                  ),
                  child: Icon(
                    Icons.check,
                    size: 35,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
