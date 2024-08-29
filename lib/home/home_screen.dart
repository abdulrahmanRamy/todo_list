import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/auth/login/login_screen.dart';
import 'package:todo_list/provider/app_provider.dart';
import 'package:todo_list/provider/list_provider.dart';
import '../provider/auth_user_Provider.dart';
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
    var listProvider = Provider.of<ListProvider>(context);
    var authProvider = Provider.of<AuthUserProvider>(context);
    // var provider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 150,
        elevation: 0,
        title: Text('ToDO List ${authProvider.currentUser!.name!}',
        style: Theme.of(context).textTheme.titleLarge,),
        actions: [
          IconButton(onPressed: (){
            listProvider.tasksList = [];
            authProvider.currentUser = null;
            Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
          }, icon: Icon(Icons.logout))
        ],

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
          : SettingScreen())
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
