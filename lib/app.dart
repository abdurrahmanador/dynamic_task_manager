import 'package:dynamic_task_manager/ui/screens/splashScreen.dart';
import 'package:flutter/material.dart';

class TaskManagerApp extends StatefulWidget {
  static GlobalKey<ScaffoldState> globalKey=GlobalKey<ScaffoldState>();
   TaskManagerApp({super.key});

  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: TaskManagerApp.globalKey,
      debugShowCheckedModeBanner: false,
      title: "Task Manager",

      theme: ThemeData(
        primarySwatch: Colors.green,
          inputDecorationTheme: InputDecorationTheme(
            fillColor: Colors.white,
            filled: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
            border: OutlineInputBorder(borderSide: BorderSide.none)
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 8),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
              ),
              fixedSize: Size.fromWidth(double.infinity)
            )
          ),
          textTheme: TextTheme(
            titleLarge: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black
            )
          ),
          brightness: Brightness.light
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark
      ),
      themeMode: ThemeMode.light,
      home: SpashScreen()
    );
  }
}
