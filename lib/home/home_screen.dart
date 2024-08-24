import 'package:flutter/material.dart';
import '../settings/settings_tap.dart';
import '../task_list/addt_task_buttom_sheet.dart';
import '../task_list/task_list_tap.dart';
import 'app_colors.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 150,
        elevation: 0,
        title: Text('To DO List',
        style: Theme.of(context).textTheme.titleLarge,),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index){
            selectedIndex = index;
            setState(() {

            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list),label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: '')
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          AddTaskButtomSheet();
        },
        child: Icon(Icons.add,
        size: 35,),
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.primaryColor,
            width: double.infinity,
            height: 100,
          ),
          Expanded(child:
          selectedIndex == 0 ? const TaskListTap()
          : SettingsTap())
        ],
      ),
    );
  }
  void AddTaskButtomSheet(){
    showModalBottomSheet(
        context: context,
        builder: (context) => AddtTaskButtomSheet());
  }
  // List<Widget> tabs = [TaskListTap(),SettingsTap()];
}
