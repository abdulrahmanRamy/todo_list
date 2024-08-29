import 'dart:ui';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/provider/app_provider.dart';
import 'package:todo_list/provider/auth_user_Provider.dart';
import 'package:todo_list/provider/list_provider.dart';
import 'package:todo_list/task_list/task_list_item.dart';

class TaskListTap extends StatefulWidget {

   const TaskListTap({super.key});

  @override
  State<TaskListTap> createState() => _TaskListTapState();
}

class _TaskListTapState extends State<TaskListTap> {

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var authProvider = Provider.of<AuthUserProvider>(context);
    var provider = Provider.of<AppProvider>(context);
    if(listProvider.tasksList.isEmpty) {
      listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
    }
    return Column(
      children: [
        EasyDateTimeLine(
          locale: 'en',
          initialDate: listProvider.selectDate,
          headerProps: const EasyHeaderProps(
            monthPickerType: MonthPickerType.switcher,
            dateFormatter: DateFormatter.fullDateDMY(),
          ),
          onDateChange: (selectedDate) {
            //`selectedDate` the new date selected.
            listProvider.changeSelectDate(selectedDate, authProvider.currentUser!.id!);
          },
          activeColor: const Color(0xff3168ff),
          dayProps: const EasyDayProps(
            dayStructure: DayStructure.dayStrDayNum,
            inactiveDayStyle: DayStyle(decoration:BoxDecoration(color: Colors.white,),
            ),
            borderColor: Colors.white,
            todayHighlightStyle: TodayHighlightStyle.withBorder,
            todayHighlightColor: Color(0xff85a5ff),
            height: 110,
            width: 70,
            // activeDayStyle: DayStyle(dayStrStyle: TextStyle(color: Colors.white),dayNumStyle: TextStyle(color: Colors.white)),
            // disabledDayStyle: DayStyle(dayNumStyle:TextStyle(color: Colors.white),dayStrStyle: TextStyle(color: Colors.white)),
            // todayStyle: DayStyle(dayNumStyle:TextStyle(color: Colors.white),dayStrStyle: TextStyle(color: Colors.white) ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index){
            return  TaskListItem(task : listProvider.tasksList[index],);
          },
          itemCount:listProvider.tasksList.length ,),
        )
      ],
    );
  }


}













