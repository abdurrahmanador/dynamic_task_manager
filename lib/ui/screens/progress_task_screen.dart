import 'package:dynamic_task_manager/data/models/network_response.dart';
import 'package:dynamic_task_manager/data/models/summary_count_model.dart';
import 'package:dynamic_task_manager/data/models/task_status_model.dart';
import 'package:dynamic_task_manager/data/services/network_caller.dart';
import 'package:dynamic_task_manager/data/utills/urls.dart';
import 'package:dynamic_task_manager/ui/screens/add_new_task.dart';
import 'package:dynamic_task_manager/ui/screens/update_task_status_sheet.dart';
import 'package:dynamic_task_manager/widgets/SummaryCard.dart';
import 'package:dynamic_task_manager/widgets/task_list_tiles.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_bar.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({Key? key}) : super(key: key);

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _getProgressTasksInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  Future<void> getInProgressTasks() async {
    _getProgressTasksInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.inProgressTasks);
    if (response.isSuccessfull) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('In progress tasks get failed')));
      }
    }
    _getProgressTasksInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.deleteTask(taskId));
    if (response.isSuccessfull) {
      _taskListModel.data!.removeWhere((element) => element.sId == taskId);
      if (mounted) {
        setState(() {});
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Deletion of task has been failed')));
      }
    }
  }
  Future<void> getNewTasks() async {
    _getProgressTasksInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.inProgressTasks);
    if (response.isSuccessfull) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Summary data get failed')));
      }
    }
    _getProgressTasksInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getInProgressTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const appBar(),
            Expanded(
              child: _getProgressTasksInProgress
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ListView.separated(
                        itemCount: _taskListModel.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return TaskListTiles(
                            data: _taskListModel.data![index],
                            onDeleteTap: () {                        deleteTask(_taskListModel.data![index].sId!);
                            deleteTask(_taskListModel.data![index].sId!);

                            },
                            onEditTap: () {
                              showStatusUpdateBottomSheet(_taskListModel.data![index]);
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            height: 4,
                          );
                        },
                      ),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  void showStatusUpdateBottomSheet(TaskData task) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return UpdateTaskStatusSheet(task: task, onUpdate: () {
          getNewTasks();
        });
      },
    );
  }
}

// class ProgressTaskScreen extends StatefulWidget {
//   const ProgressTaskScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
// }
//
// class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
//   bool _taskStatusCount = false;
//   TaskListModel _taskListModel = TaskListModel();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       getInProgressTasks();
//     });
//   }
//
//   Future<void> getInProgressTasks() async {
//     _taskStatusCount = true;
//     if (mounted) {
//       setState(() {});
//     }
//     final NetworkResponse response=await NetworkCaller().getRequest(Urls.inProgressTasks);
//     if(response.isSuccessfull){
//       _taskListModel=TaskListModel.fromJson(response.body!);
//     }else{
//       if(mounted){
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('get Progress task data failed')));
//       }
//     }
//     _taskStatusCount=false;
//     if(mounted){
//       setState(() {
//
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             const appBar(),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//             ),
//             Expanded(
//                 child: RefreshIndicator(
//                   onRefresh: ()async{
//                     getInProgressTasks();
//                   },
//                   child: _taskStatusCount?const Center(
//                     child: CircularProgressIndicator(),
//                   ):ListView.separated(
//                     itemCount: _taskListModel.data?.length ?? 0,
//                     itemBuilder: (context, index) {
//                       return TaskListTiles(data:
//                       _taskListModel.data![index],
//                       onDeleteTap:(){},
//                       onEditTap:(){});
//                     }, separatorBuilder: (BuildContext context, int index) {
//                     return Divider(height: 4);
//                   },
//                   ),
//                 )),
//
//           ],
//         ),
//       ),
//
//     );
//   }
// }
//
