// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pinturaslisboa_flutter/search_screen.dart';
import 'splash_screen.dart';
import 'JobCreation/add_job_screen.dart';
import 'job.dart';
import 'JobDetails/job_details_page.dart';
// ignore: unused_import
import 'package:geocoding/geocoding.dart';
import 'package:hive_flutter/hive_flutter.dart';

//gmaps API key AIzaSyDjM1EkO5FE32oZj0DHJ05t8IubVH0UA3Y


void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('jobs');
  var tasks_db = await Hive.openBox('tasks');
  bool hasContent = box.isNotEmpty;
  // ignore: unused_local_variable
  bool hasTasks = tasks_db.isNotEmpty;
  runApp(MyApp(hasContent: hasContent));
}

class MyApp extends StatefulWidget {
  final bool hasContent;
  // ignore: use_key_in_widget_constructors
  const MyApp({Key? key, required this.hasContent}) : super(key: key);

  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pinturas Lisboa',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


//vertical list that can be scrolled
//each item will have a box with a google maps preview on the left side, a title, street address, type of work and a progress bar
//the progress bar will be a horizontal rectangle with a percentage of completion on the end


class _MyHomePageState extends State<MyHomePage> {

  bool _hasContent = false;
  List<Job> jobs = [];
  int _selectedIndex = 0;
  bool _showAppBar = true;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    // Timer(Duration(seconds: 5), () {
    //   setState(() {
    //     _showAppBar = false;
    //     print("\n\n-------\nHiding AppBar\n\n-------\n");
    //   });
    // });
    _checkBoxContentAndLoadJobs();
    
  }

  Future<void> _checkBoxContentAndLoadJobs() async {
    var box = await Hive.openBox('jobs');
    bool hasContent = box.isNotEmpty;
    if (hasContent) {
      // box.deleteAll(box.keys);
      print("\n\n-------\nBox has content\n\n");
      print("\n----------\nBox Size: " + box.length.toString() + "\n----------\n");
      _loadJobs(box);
    } else {
      print("\n\n-------\nBox is empty\n\n-------\n");
    }
    setState(() {
      _hasContent = hasContent;
    });
  }

    Future<void> _loadJobs(Box box) async {
      final List<Job> loadedJobs = [];
      for (var key in box.keys) {
        final jobData = box.get(key);
        if (jobData != null && jobData is Map) {
          try {
            final jobMap = Map<String, dynamic>.from(jobData);
            print("Adding a job");
            loadedJobs.add(Job.fromMap(jobMap));
          } catch (e) {
            print("Error casting jobData to Map<String, dynamic>");
          }
        }
      }
      setState(() {
        jobs = loadedJobs;
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: _showAppBar ? buildAppBar() : null,
      appBar: buildAppBar(),
      backgroundColor: const Color.fromARGB(240, 255, 255, 255),
      body: populateJobList(jobs),
      floatingActionButton: new_job_button(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: bottom_bar_screens(),
    );
  }

  BottomAppBar bottom_bar_screens() {
    return BottomAppBar(
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildBottomNavigationItem(Icons.home_rounded, "Home", 0),
          _buildBottomNavigationItem(Icons.calendar_month, "Calendar", 1),
          _buildBottomNavigationItem(Icons.inventory, "Inventory", 2),
          _buildBottomNavigationItem(Icons.notifications, "Notifications", 3),
          const SizedBox(width: 5),
        ],
      ),
    );
  }

  FloatingActionButton new_job_button(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: const Color.fromARGB(255, 12, 96, 165),
      elevation: 1,
      onPressed: () async {
        HapticFeedback.vibrate();
        final Job newJob = await Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => AddJobScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              var begin = const Offset(0.0, 1.0);
              var end = Offset.zero;
              var curve = Curves.easeInOut;
              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 300),
          ),
        );
        if (newJob != null) {
            setState(() {
              var box = Hive.box('jobs');
              box.put( jobs.length, newJob.toMap());
              jobs.add(newJob);
          });
        }
      },
      child: const Icon(Icons.add, color: Colors.white,),
    );
  }

  Widget _buildBottomNavigationItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, color: _selectedIndex == index ? const Color.fromARGB(255, 12, 96, 165) : Colors.grey),
          
        ],
      ),
    );
  }

  AppBar buildAppBar() {
      return AppBar(
        elevation: 3,
        backgroundColor: const Color.fromARGB(255, 12, 96, 165),
        flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 15, top: 30),
                  child: Image.asset('assets/pinturas_lisboa.png', width: 100),
                )
              ],
            );
          }
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              print("\n\n-------\nsettings pressed\n\n-------\n");
            },
          )
        ],
      );
    }

    Widget populateJobList(List<Job> jobs) {
      //bool search_built_flag = false;
      return ListView.builder(
        itemCount: jobs.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            //search_built_flag = true;
            return GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => SearchScreen(),
                  ),
                );
              },
              child: Card(
                color: Colors.white,
                margin: const EdgeInsets.all(10),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey[800]),
                        SizedBox(width: 10),
                        Text(
                          'Search jobs...(not functional)',
                          style: TextStyle(color: Colors.grey[800], fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            final job = jobs[index - 1];
            return Dismissible(
              key: Key(jobs[index - 1].address),
              direction: DismissDirection.endToStart,
              background: Container(
                color: const Color.fromARGB(255, 12, 96, 165),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20.0),
                child: const Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.white,
                ),
              ),
              confirmDismiss: (direction) async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Confirm"),
                      content: const Text("Are you sure you want to delete this?"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text("CANCEL"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text("DELETE"),
                        ),
                      ],
                    );
                  },
                );
                return confirm ?? false;
              },
              onDismissed: (direction) {
                setState(() {
                  jobs.removeAt(index);
                  var box = Hive.box('jobs');
                  box.deleteAt(index);
                  print("\n\n-------\nDeleted job at index $index\n\n-------\n");
                  print(box.values);
                });
              },
              child: _buildJobCard(context, job), // Add the required 'child' argument
            );
          }
        },
      );
    }

  Widget _buildJobCard(BuildContext context, Job job) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(10),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          title: Text(
            job.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 12, 96, 165)),
            ),
          subtitle: Text('${job.address}\n'),
          trailing: SizedBox(
            width: 100,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: job.progress,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 12, 96, 165)),
                  ),
                ),
                const SizedBox(width: 5),
                Text('${(job.progress * 100).toStringAsFixed(0)}%'),
              ],
            ),
          ),
          onTap: () {
            // HapticFeedback.vibrate();
            // _showJobDetails(context, job);
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => JobDetailsPage(job: job),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  var begin = const Offset(0.0, 1.0);
                  var end = Offset.zero;
                  var curve = Curves.easeInOut;
                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 300),
              ),
            );
          }
        ),
      ),
    );
  }

  void _showJobDetails(BuildContext context, Job job) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(100),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(job.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
              Text(job.address),
              Text(job.type),
            ],
          )
        );
      },
    );
  }
}


  

  