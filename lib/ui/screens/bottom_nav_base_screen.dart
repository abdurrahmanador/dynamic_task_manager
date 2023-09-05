import 'package:dynamic_task_manager/ui/screens/cancel_task_screen.dart';
import 'package:dynamic_task_manager/ui/screens/completed_task_screen.dart';
import 'package:dynamic_task_manager/ui/screens/new_task_screen.dart';
import 'package:dynamic_task_manager/ui/screens/progress_task_screen.dart';
import 'package:flutter/material.dart';

class BaseBottomNavBar extends StatefulWidget {
  const BaseBottomNavBar({super.key});

  @override
  State<BaseBottomNavBar> createState() => _BaseBottomNavBarState();
}

class _BaseBottomNavBarState extends State<BaseBottomNavBar> {

  int _selectedScreenIndex=0;

  final List<Widget> _screens=[
    NewTaskScreen(),
    ProgressTaskScreen(),
    CancelTaskScreen(),
    CompletedTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _screens[_selectedScreenIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreenIndex,
      unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.green,
        unselectedLabelStyle: TextStyle(
          color:Colors.grey,
        ),
        showUnselectedLabels: true,
        onTap: (int index){
        _selectedScreenIndex=index;
        if(mounted){
          setState(() {
          });
        }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit_outlined),label:"New"),
          BottomNavigationBarItem(icon: Icon(Icons.account_tree),label:"In Progress"),
          BottomNavigationBarItem(icon: Icon(Icons.cancel_outlined),label:"Cancel"),
          BottomNavigationBarItem(icon: Icon(Icons.done_all),label:"Completed")
        ],
      ),
    );
  }
}
