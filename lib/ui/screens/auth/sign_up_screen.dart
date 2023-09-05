import 'package:dynamic_task_manager/data/models/network_response.dart';
import 'package:dynamic_task_manager/data/services/network_caller.dart';
import 'package:dynamic_task_manager/data/utills/urls.dart';
import 'package:dynamic_task_manager/widgets/screen_background.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameTEController=TextEditingController();
  final TextEditingController _emailTEController=TextEditingController();
  final TextEditingController _lastNameTEController=TextEditingController();
  final TextEditingController _mobileTEController=TextEditingController();
  final TextEditingController _passwordTEController=TextEditingController();

  final GlobalKey<FormState> _formkey=GlobalKey<FormState>();

  bool _isSignupProgress=false;

  Future<void> userSignUp() async{

    Map<String,dynamic> requestBody={
      "email":_emailTEController.text.trim(),
      "firstName":_firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile":_mobileTEController.text,
      "password":_passwordTEController.text,
      "photo":""

    };
    final NetworkResponse response=await NetworkCaller().postRequest(Urls.registration, requestBody);
    _isSignupProgress=false;
    setState(() {

    });
    if(response.isSuccessfull){
      _emailTEController.clear();
      _firstNameTEController.clear();
      _lastNameTEController.clear();
      _mobileTEController.clear();
      _passwordTEController.clear();


      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Registration Successfull")));
      }
      else{
        _isSignupProgress=false;
        setState(() {

        });
        if(mounted){
          ScaffoldMessenger.of(context)
              .showSnackBar(
              const SnackBar(content: Text("Registration Failed"))
          );
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 64,),
                  Text(
                    "Join With Us...",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _firstNameTEController,
                    decoration: InputDecoration(hintText: "First Name"),
                    validator: (String? value){
                      if(value!.isEmpty){
                        return "Please Enter Your First Name";
                      }
                      return null;
                    }
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _lastNameTEController,
                    decoration: InputDecoration(hintText: "Last Name"),
                      validator: (String? value){
                        if(value!.isEmpty){
                          return "Please Enter Your Last Name";
                        }
                        return null;
                      }
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: "Email"),
                      validator: (String? value){
                        if(value!.isEmpty??true ){
                          return "Please Enter Your Email";
                        }
                        return null;
                      }
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _mobileTEController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: "Phone Number"),
                      validator: (String? value){
                        if((value!.isEmpty ??true)||value.length<11){
                          return "Please Enter your Number";
                        }
                        return null;
                      }
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: IconButton(onPressed: (){
                        },icon: Icon(Icons.visibility),)
                    ),
                      validator: (String? value){
                        if((value!.isEmpty ??true)||value.length<=6){
                          return "Please Enter a password";
                        }
                        return null;
                      }
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _isSignupProgress==false,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                          onPressed: () {
                            if(!_formkey.currentState!.validate()){
                              return;
                            }
                            else{
                            userSignUp();}
                          }, child: Icon(Icons.arrow_forward)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Have an account?",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, letterSpacing: 0.5),
                      ),
                      TextButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>login_screen()));
                      }, child: Text("Signin here...")),
                    ],
                  ),
                ],
              ),
            ),
          ),

        ),
      ),
    );
  }
}
