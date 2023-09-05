import 'package:dynamic_task_manager/data/models/network_response.dart';
import 'package:dynamic_task_manager/data/services/network_caller.dart';
import 'package:dynamic_task_manager/data/utills/urls.dart';
import 'package:dynamic_task_manager/ui/screens/new_task_screen.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/screen_background.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {

  TextEditingController _titleETController=TextEditingController();
  TextEditingController _descriptionETController=TextEditingController();
  bool isTaskProgress=false;

  Future<void> addNewTask()async{
    isTaskProgress=true;
    if(mounted) {
      setState(() {});
    }
    Map<String,dynamic> requestBody=
      {
        "title":_titleETController.text.trim(),
        "description":_titleETController.text.trim(),
        "status":"New"
      };
    final NetworkResponse response=
        await NetworkCaller().postRequest(Urls.createTask, requestBody);
    isTaskProgress=false;
    setState(() {
    });
    if(response.isSuccessfull){
      _titleETController.clear();
      _descriptionETController.clear();

      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added Successfully")));
      }
      else{
        isTaskProgress=false;
        setState(() {
        });
        if(mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Failed To Add Task")));
        }
      }
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenBackground(
          child: Column(
            children: [
              appBar(),
              Text("Add New Task",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),),
              SizedBox(height: 25,),
              TextFormField(
                controller: _titleETController,
                decoration: InputDecoration(
                  hintText: "title"
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: _descriptionETController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Description"
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Visibility(
                  visible: isTaskProgress==false,
                  replacement: Center(child: CircularProgressIndicator(),),
                  child: ElevatedButton(
                      onPressed: () {
                        addNewTask();}, child: Icon(Icons.arrow_forward)),
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }
}
