import 'dart:convert';
import 'dart:developer';
import 'package:dynamic_task_manager/app.dart';
import 'package:dynamic_task_manager/ui/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:dynamic_task_manager/data/models/network_response.dart';
import 'package:http/http.dart';

import '../models/auth_utility.dart';

class NetworkCaller{

  Future<NetworkResponse> getRequest(String url)async {
    try{
      Response response = await get(Uri.parse(url),headers: {'Content-Type':"application/json",
        'token': AuthUtility.userInfo.token.toString()});
      if (response.statusCode == 200) {
        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));
      } else {
        return NetworkResponse(false, response.statusCode, null);
      }
    }catch(e){
      log(e.toString());
    }
    return NetworkResponse(false,-1,null);
  }

  Future<NetworkResponse> postRequest(String url,Map<String,dynamic> body)async{
    try{
      Response response=await post(Uri.parse(url),
          headers: {'Content-Type':"application/json",'token': AuthUtility.userInfo.token.toString()},

          body: jsonEncode(body));
      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));


      }else if(response.statusCode == 401){
        Navigator.pushAndRemoveUntil(TaskManagerApp.globalKey.currentState!.context,MaterialPageRoute(builder: (context)=>login_screen()), (route) => false);
  }         else
      {
        return NetworkResponse(false, response.statusCode, null);
      }
    }catch(e){
      log(e.toString());
    }
    return NetworkResponse(false,-1,null);

  }

}