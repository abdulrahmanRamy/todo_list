import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    if(listProvider.tasksList.isEmpty) {
      listProvider.getAllTasksFromFireStore();
    }
    return Column(
      children: [
        EasyDateTimeLine(
          locale: 'en',
          initialDate: listProvider.selectDate,
          headerProps: const EasyHeaderProps(
            monthPickerType: MonthPickerType.dropDown,
            dateFormatter: DateFormatter.fullDateDMY(),
          ),
          onDateChange: (selectedDate) {
            //`selectedDate` the new date selected.
            listProvider.changeSelectDate(selectedDate);
          },
          activeColor: const Color(0xff3168ff),
          dayProps: const EasyDayProps(
            todayHighlightStyle: TodayHighlightStyle.withBorder,
            todayHighlightColor: Color(0xff85a5ff),
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













