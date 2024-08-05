import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  var tasks = [
    {
      'name': 'Covering',
      'icon': Icons.handyman,
    },
    {
      'name': 'Filler',
      'icon': Icons.handyman,
    },
    {
      'name': 'Sanding',
      'icon': Icons.handyman,
    },
    {
      'name': 'Primer',
      'icon': Icons.format_paint,
    },
    {
      'name': 'First coat',
      'icon': Icons.format_paint,
    },
    {
      'name': 'Final coat',
      'icon': Icons.format_paint,
    },
    {
      'name': 'Finishing',
      'icon': Icons.brush,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            //iterate the tasks list and create a taskBlock for each task
            for (var task in tasks) taskBlock(task),
          ],
        ),
      ),
    );
  }

  Padding taskBlock(Map task) {
    var taskName = task['name'];
    var taskIcon = task['icon'];
    return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                height: 150, // Set a fixed height for the rectangles
                color: const Color.fromARGB(52, 25, 76, 134),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: OverflowBox(
                        maxWidth: 300,
                        maxHeight: 300,
                        child: Icon(taskIcon, color: Color.fromARGB(52, 25, 76, 134), size: 300),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          taskName,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 25, 76, 134),
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}