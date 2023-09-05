import 'package:dynamic_task_manager/ui/screens/add_new_task.dart';
import 'package:dynamic_task_manager/widgets/SummaryCard.dart';
import 'package:dynamic_task_manager/widgets/task_list_tiles.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_bar.dart';

class CancelTaskScreen extends StatelessWidget {
  const CancelTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const appBar(),
            Padding(
              padding: const EdgeInsets.all(8.0),
            ),
            Expanded(
                child: ListView.separated(
                  itemCount: 20,
                  itemBuilder: (context,index){
                    return TaskListTiles(title: "Cancelled",Color: Colors.red);
                  }, separatorBuilder: (BuildContext context, int index) {
                  return Divider(height: 4);
                },
                )),

          ],
        ),
      ),

    );
  }
}

