import 'package:dynamic_task_manager/data/models/auth_utility.dart';
import 'package:dynamic_task_manager/data/models/login_model.dart';
import 'package:dynamic_task_manager/data/models/network_response.dart';
import 'package:dynamic_task_manager/data/services/network_caller.dart';
import 'package:dynamic_task_manager/data/utills/urls.dart';
import 'package:dynamic_task_manager/ui/screens/bottom_nav_base_screen.dart';
import 'package:dynamic_task_manager/ui/screens/auth/sign_up_screen.dart';
import 'package:dynamic_task_manager/widgets/screen_background.dart';
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
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _islogin = false;

  Future<void> login() async {
    Map<String, dynamic> requestBody = {
      "email": _emailETController.text.trim(),
      "password": _passwordETController.text,
    };
    // _islogin = true;
    // setState(() {});

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.login, requestBody);

    _islogin = false;
    if(mounted) {
      setState(() {});
    }
    if (response.isSuccessfull) {
      _passwordETController.clear();
      _emailETController.clear();

      LoginModel model = LoginModel.fromJson(response.body!);
      await AuthUtility.saveUserInfo(model);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Loggedin Succcessfully!")));
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const BaseBottomNavBar()));
      } else {
        _islogin = false;
        setState(() {});
        if (mounted) {
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 64,
                  ),
                  Text(
                    'Get Started With',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: _emailETController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextField(
                    controller: _passwordETController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _islogin == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                          onPressed: () {
                            login();
                          },
                          child: const Icon(Icons.arrow_forward_ios)),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const EmailVerificationScreen()));
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, letterSpacing: 0.5),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpScreen()));
                          },
                          child: const Text('Sign up')),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ));
  }
}