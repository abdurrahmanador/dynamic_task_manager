import 'package:dynamic_task_manager/data/models/network_response.dart';
import 'package:dynamic_task_manager/data/services/network_caller.dart';
import 'package:dynamic_task_manager/data/utills/urls.dart';
import 'package:dynamic_task_manager/ui/screens/auth/set_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../widgets/screen_background.dart';
import 'login_screen.dart';

class otpVerificationScreen extends StatefulWidget {
  final String email;
  const otpVerificationScreen({super.key, required this.email});

  @override
  State<otpVerificationScreen> createState() => _otpVerificationScreenState();
}

class _otpVerificationScreenState extends State<otpVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  bool _isOTPVerified = false;

  Future<void> OTPVerification() async {
    _isOTPVerified = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response = await NetworkCaller()
        .getRequest(Urls.recoverVerifyOTP(widget.email, _otpTEController.text));
    _isOTPVerified = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccessfull) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SetPasswordScreen(email: widget.email, otp:_otpTEController.text),
        ),
      );
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
                  "OTP Verification.",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 20),
                PinCodeTextField(
                  controller: _otpTEController,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    activeColor: Colors.white,
                    selectedColor: Colors.white,
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    inactiveColor: Colors.red,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.white,
                  enableActiveFill: true,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (value) {
                    print(value);
                    setState(() {});
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                  appContext: context,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _isOTPVerified==false,
                    replacement: Center(child:CircularProgressIndicator()),
                    child: ElevatedButton(
                        onPressed: () {
                         OTPVerification();
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
                            builder: (context) => const login_screen()));
                  },
                  child: Text("Back to login page...",
                      style: TextStyle(color: Colors.grey)),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
