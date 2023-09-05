import 'package:dynamic_task_manager/data/models/auth_utility.dart';
import 'package:dynamic_task_manager/ui/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';

class appBar extends StatefulWidget {
  const appBar({
    super.key,
  });

  @override
  State<appBar> createState() => _appBarState();
}

class _appBarState extends State<appBar> {

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      tileColor: Colors.green,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(AuthUtility.userInfo.data?.photo ?? ''),
        onBackgroundImageError: (_,__){
          const Icon(Icons.image);
        },
        radius: 15,
      ),
      title: Text(
        '${AuthUtility.userInfo.data?.firstName ?? ''}${AuthUtility.userInfo.data?.lastName ?? ''}',
        style: TextStyle(fontSize: 14, color: Colors.white),
      ),
      subtitle: Text(
        AuthUtility.userInfo.data?.email ?? 'unknown',
        style: TextStyle(fontSize: 12, color: Colors.white),
      ),
      trailing: IconButton(
        icon: Icon(Icons.logout),
        onPressed: () async {
          await AuthUtility.clearUserInfo();
          if (mounted) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => login_screen()),
                (route) => false);
          }
        },
      ),
    );
  }
}
