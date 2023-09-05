
import 'package:flutter/material.dart';

class TaskListTiles extends StatelessWidget {

  final String title;
  final  Color;
  const TaskListTiles({
    super.key, required this.title, this.Color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text("Here is the Title",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16
        ),),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("title will be here"),
            Text("Date"),
            Row(
              children: [
                Chip(label:Text("$title"),backgroundColor: Color,),
                Spacer(),
                IconButton(onPressed:(){},
                  icon: Icon( Icons.edit,),color: Colors.green,),
                IconButton(onPressed:(){},
                  icon: Icon(Icons.delete),color: Colors.redAccent,),

              ],
            )
          ],
        )

    );
  }
}

