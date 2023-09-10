import 'package:dynamic_task_manager/ui/screens/add_new_task.dart';
import 'package:dynamic_task_manager/ui/screens/update_task_status_sheet.dart';
import 'package:dynamic_task_manager/widgets/SummaryCard.dart';
import 'package:dynamic_task_manager/widgets/task_list_tiles.dart';
import 'package:flutter/material.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_status_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utills/urls.dart';
import '../../widgets/app_bar.dart';



class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({Key? key}) : super(key: key);

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompletedTasks = false;
  TaskListModel _taskListModel = TaskListModel();

  Future<void> getInProgressTasks() async {
    _getCompletedTasks = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.completedTasks);
    if (response.isSuccessfull) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Completed tasks get failed')));
      }
    }
    _getCompletedTasks = false;
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
    _getCompletedTasks = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.completedTasks);
    if (response.isSuccessfull) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Summary data get failed')));
      }
    }
    _getCompletedTasks = false;
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
              child: _getCompletedTasks
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

// class CompletedTaskScreen extends StatelessWidget {
//   const CompletedTaskScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             const appBar(),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//             ),
//             Expanded(
//                 child: ListView.separated(
//                   itemCount: 20,
//                   itemBuilder: (context,index){
//                     return;                  }, separatorBuilder: (BuildContext context, int index) {
//                   return Divider(height: 4);
//                 },
//                 )),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
//
