import 'package:dynamic_task_manager/widgets/screen_background.dart';
import 'package:flutter/material.dart';

import 'otp_verification_screen.dart';

class emailVerificationScreen extends StatelessWidget {
  const emailVerificationScreen({super.key});

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
                Text("Email Verification",
                style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height:20),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: "Enter Your Email."),
                ),
                SizedBox(height: 26,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)
                      => const otpVerificationScreen()));
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
