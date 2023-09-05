import 'package:dynamic_task_manager/data/models/auth_utility.dart';
import 'package:dynamic_task_manager/ui/screens/auth/login_screen.dart';
import 'package:dynamic_task_manager/ui/screens/bottom_nav_base_screen.dart';
import 'package:dynamic_task_manager/ui/utills/assetUtills.dart';
import 'package:dynamic_task_manager/widgets/screen_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SpashScreen extends StatefulWidget {
  const SpashScreen({super.key});

  @override
  State<SpashScreen> createState() => _SpashScreenState();
}

class _SpashScreenState extends State<SpashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NavigationToLogin();

  }

  void NavigationToLogin() {

    Future
       .delayed(Duration(seconds: 3))
       .then((_) async {
      final isLogin=await AuthUtility.checkUserLoggedInfo();
      if(mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => isLogin? BaseBottomNavBar():login_screen()),
            (route) => false);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenBackground(
          child: Center(
            child: SvgPicture.asset(
              AssetUtills.logoJPG,
              fit: BoxFit.scaleDown,
              height: 90,

            ),


        )
    )
    );
  }
}
