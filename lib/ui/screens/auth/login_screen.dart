import 'package:dynamic_task_manager/data/models/login_model.dart';
import 'package:dynamic_task_manager/data/models/network_response.dart';
import 'package:dynamic_task_manager/data/services/network_caller.dart';
import 'package:dynamic_task_manager/data/utills/urls.dart';
import 'package:dynamic_task_manager/ui/screens/bottom_nav_base_screen.dart';
import 'package:dynamic_task_manager/ui/screens/auth/sign_up_screen.dart';
import 'package:dynamic_task_manager/widgets/screen_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'email_verification_screen.dart';

class login_screen extends StatefulWidget {
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  final TextEditingController _emailETController = TextEditingController();
  final TextEditingController _passwordETController = TextEditingController();

  bool _islogin = false;

  Future<void> login() async {
    _islogin = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": _emailETController.text.trim(),
      "password": _passwordETController.text,
    };
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.login, requestBody);

    _islogin = false;

    setState(() {});

    if (response.isSuccessfull)
    {
      LoginModel model=LoginModel.fromJson(response.body!);
      _passwordETController.clear();
      _emailETController.clear();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Loggedin Succcessfully!")));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                const BaseBottomNavBar()));
      } else {
        _islogin = false;
        setState(() {});
        if(mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Try Again!")));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Get Started With...",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailETController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: "Email"),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Please provide Email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _passwordETController,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Password",
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.visibility),
                      )),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Please Enter Password";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _islogin==false,
                    replacement: const Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(
                        onPressed: () {
                          login();
                        },
                        child: Icon(Icons.arrow_forward)),
                  ),
                ),
                Center(
                    child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const emailVerificationScreen()));
                  },
                  child: Text("Forgot your password?",
                      style: TextStyle(color: Colors.grey)),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have account",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, letterSpacing: 0.5),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                        child: Text("Signup here...")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
