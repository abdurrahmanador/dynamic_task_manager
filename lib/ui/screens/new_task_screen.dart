import 'package:dynamic_task_manager/ui/screens/add_new_task.dart';
import 'package:dynamic_task_manager/widgets/SummaryCard.dart';
import 'package:dynamic_task_manager/widgets/app_bar.dart';
import 'package:dynamic_task_manager/widgets/task_list_tiles.dart';
import 'package:flutter/material.dart';

class NewTaskScreen extends StatelessWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return  Scaffold(
     body: SafeArea(
       child: Column(
         children: [
           const appBar(),
           const Padding(
             padding: EdgeInsets.all(8.0),
             child: Row(
               children: [
                 Expanded(
                   child: SummaryCard(
                     number: 1256,
                     title: "New",
                   ),
                 ),
                 Expanded(
                   child: SummaryCard(
                     number: 1256,
                     title: "Completed",
                   ),
                 ),
                 Expanded(
                   child: SummaryCard(
                     number: 1256,
                     title: "Progress",
                   ),
                 ),
                 Expanded(
                   child: SummaryCard(
                     number: 1256,
                     title: "Cancelled",
                   ),
                 ),
               ],
             ),
           ),
           Expanded(
               child: ListView.separated(
                 itemCount: 20,
                 itemBuilder: (context,index){
                   return const TaskListTiles(title: "New",Color: Colors.green);
             }, separatorBuilder: (BuildContext context, int index) {
                   return const Divider(height: 4);
               },
           )),

         ],
       ),
     ),
     floatingActionButton: FloatingActionButton(onPressed: (){
       Navigator.push(context,MaterialPageRoute(builder: (context)=>AddNewTask()));
     },child: Icon(Icons.add),),
   );
  }
}

