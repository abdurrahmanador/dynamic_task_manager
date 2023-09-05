import 'package:dynamic_task_manager/ui/screens/auth/login_screen.dart';
import 'package:dynamic_task_manager/widgets/screen_background.dart';
import 'package:flutter/material.dart';

class SetPasswordScreen extends StatelessWidget {
  const SetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Set Password",
                      style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height:20),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Password"),
                  ),
                  SizedBox(height:20),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Confirm Password"),
                  ),
                  SizedBox(height: 26,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)
                        => const login_screen()));
                      },child: Icon(Icons.arrow_forward),
                    ),
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}
