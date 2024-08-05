import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../job.dart';
import 'package:url_launcher/url_launcher.dart';
import '../client.dart';
import '../Tasks/task_page.dart';

class JobDetailsPage extends StatefulWidget {
  final Job job;

  // ignore: use_super_parameters
  const JobDetailsPage({Key? key, required this.job}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _JobDetailsPageState createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {

  late String mapImageUrl;

  @override
  void initState() {
    super.initState();
    mapImageUrl = getMapImageUrl(widget.job.address);
    print("--------------------\n\n");
    print('Map image URL:');
    print(mapImageUrl);
    print("--------------------\n\n");
  }

  String getMapImageUrl(String address) {
    const apiKey = 'AIzaSyDjM1EkO5FE32oZj0DHJ05t8IubVH0UA3Y';
    final encodedAddress = Uri.encodeComponent(address);
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$encodedAddress&zoom=15&size=300x150&key=$apiKey';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          textAlign: TextAlign.center,
          widget.job.title,
          style: const TextStyle(color: Color.fromARGB(255, 25, 76, 134), fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 25, 76, 134)),
      ),
      body: ListView(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 16),
                Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(52, 25, 76, 134),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // ignore: prefer_const_constructors
                    child: Text(
                      "Next Task: Covering",
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 25, 76, 134),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Center(
                  child: Container(
                    width: 300,
                    height: 150,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [Color.fromARGB(52, 25, 76, 134).withOpacity(0.5), Colors.transparent],
                        center: Alignment.center,
                        radius: 10.0,
                      ),
                      color: const Color.fromARGB(52, 25, 76, 134),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white,
                          ),
                          child: Stack(
                            children: [
                              Image.network(
                                mapImageUrl,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                        : null,
                                      ),
                                    );
                                  }
                                },
                                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                  return const Text('Failed to load map image');
                                }
                              ),
                              const Center(
                                child: Icon(
                                  Icons.location_on,
                                  color:  Color.fromARGB(255, 25, 76, 134),
                                  size: 24.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              String googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(widget.job.address)}";
              Uri url = Uri.parse(googleMapsUrl);
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                throw 'Could not open the map';
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.directions, color: Color.fromARGB(255, 25, 76, 134)),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.job.address,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Color.fromARGB(255, 25, 76, 134),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.grey[300],
                      valueColor: const AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 25, 76, 134)),
                      value: widget.job.progress,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '${(widget.job.progress * 100).toStringAsFixed(0)}%',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TaskPage()),
                );
              }, //TODO implement tasks in the job class
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tasks',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 25, 76, 134),
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.arrow_right,
                    color: Color.fromARGB(255, 25, 76, 134),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                  secondary: const Color.fromARGB(255, 25, 76, 134),
                ),
              ),
              child: showClientInfo(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                  secondary: const Color.fromARGB(255, 25, 76, 134),
                ),
              ),
              child: showJobDetails(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, //TODO implement edit job
        child: const Icon(Icons.edit, color: Colors.white,),
        backgroundColor: const Color.fromARGB(255, 25, 76, 134),
      ),
    );
  }

  ExpansionTile showClientInfo(BuildContext context) {
    return ExpansionTile(
              title: const Text('Client Info', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 25, 76, 134))),
              children: <Widget>[
                if (widget.job.client != null)
                ...[
                  if (widget.job.client!.name != '')
                  ListTile(
                    title: const Text('Name'),
                    subtitle: Text(widget.job.client!.name),
                  ),
                  if (widget.job.client!.phone != '')
                  ListTile(
                    title: const Text('Phone'),
                    subtitle: Text(widget.job.client!.phone),
                  ),
                  if (widget.job.client!.email != '')
                  ListTile(
                    title: const Text('Email'),
                    subtitle: Text(widget.job.client!.email),
                  ),
                  if (widget.job.client!.notes != '')
                  ListTile(
                    title: const Text('Notes'),
                    subtitle: Text(widget.job.client!.notes),
                  ),
                ]
                else
                  const ListTile(
                    title: Text('No client info available'),
                  ),
                ListTile(
                  title: TextButton(
                    onPressed: () => _editClientInfo(context, widget.job),
                    child: const Text('Edit'),
                  ),
                ),
              ],
            );
  }

  ExpansionTile showJobDetails() {
    return ExpansionTile(
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Job Details',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 25, 76, 134),
                    ),
                  ),
                ],
              ),
              children: <Widget>[
                if (widget.job.rooms >= 1)
                  ListTile(
                    title: const Text('Rooms'),
                    subtitle: Text(widget.job.rooms.toString()),
                  ),
                if (widget.job.bathrooms >= 1)
                  ListTile(
                    title: const Text('Bathrooms'),
                    subtitle: Text(widget.job.bathrooms.toString()),
                  ),
                if (widget.job.kitchens >= 1)
                  ListTile(
                    title: const Text('Kitchens'),
                    subtitle: Text(widget.job.kitchens.toString()),
                  ),
                if (widget.job.livingRooms >= 1)
                  ListTile(
                    title: const Text('Living Rooms'),
                    subtitle: Text(widget.job.livingRooms.toString()),
                  ),
                if (widget.job.hallways >= 1)
                  ListTile(
                    title: const Text('Hallways'),
                    subtitle: Text(widget.job.hallways.toString()),
                  ),
                if (widget.job.balconies >= 1)
                  ListTile(
                    title: const Text('Balconies'),
                    subtitle: Text(widget.job.balconies.toString()),
                  ),
                if (widget.job.garages >= 1)
                  ListTile(
                    title: const Text('Garages'),
                    subtitle: Text(widget.job.garages.toString()),
                  ),
                if (widget.job.otherRooms >= 1)
                  ListTile(
                    title: const Text('Other Rooms'),
                    subtitle: Text(widget.job.otherRooms.toString()),
                  ),
                ListTile(
                  title: const Text('Type of Paint'),
                  subtitle: Text(widget.job.typeOfPaint),
                ),
                ListTile(
                  title: const Text('Type of Finish'),
                  subtitle: Text(widget.job.typeOfFinish),
                ),
                ListTile(
                  title: const Text('Previous Color'),
                  subtitle: Text(widget.job.previousColor),
                ),
                ListTile(
                  title: const Text('New Color'),
                  subtitle: Text(widget.job.newColor),
                ),
                ListTile(
                  title: const Text('Color Reference'),
                  subtitle: Text(widget.job.colorReference),
                ),
                ListTile(
                  title: const Text('Furnished'),
                  subtitle: Text(widget.job.furnished ? 'Yes' : 'No'),
                ),
                ListTile(
                  title: const Text('Notes'),
                  subtitle: Text(widget.job.notes),
                ),
              ],
            );
  }

  void _editClientInfo(BuildContext context, Job job) async {
    Client tempClient = Client(name: '', phone: '', email: '', notes: '');
    final formKey = GlobalKey<FormState>();
    return showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    const Text('Edit Client Info', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 25, 76, 134))),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                        hintText: job.client!.name,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      onChanged: (value) {
                        setState(() {
                          tempClient.name = value;
                        });
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        hintText: job.client!.phone,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      onChanged: (value) {
                        setState(() {
                          tempClient.phone = value;
                        });
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: job.client!.email,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      onChanged: (value) {
                        setState(() {
                          tempClient.email = value;
                        });
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Notes',
                        hintText: job.client!.notes,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      onChanged: (value) {
                        setState(() {
                          tempClient.notes = value;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 25, 76, 134))
                        ),
                        onPressed: () {
                          setState(() {
                            job.assignClient(tempClient);
                            //update the job on the box
                            var box = Hive.box('jobs');

                            for (var key in box.keys) {
                              final jobData = box.get(key);
                              if (jobData != null && jobData['title'] == job.title) {
                                box.put(key, job.toMap());
                              }
                              // print("\n\n----\nJob key");
                              // print(jobData);
                            }
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}