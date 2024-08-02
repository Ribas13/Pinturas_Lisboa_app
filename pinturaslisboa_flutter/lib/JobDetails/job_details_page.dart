import 'package:flutter/material.dart';
import '../job.dart';
import 'package:url_launcher/url_launcher.dart';
import '../client.dart';

class JobDetailsPage extends StatefulWidget {
  final Job job;

  // ignore: use_super_parameters
  const JobDetailsPage({Key? key, required this.job}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _JobDetailsPageState createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {

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
          Center(
            child: Container(
              padding: const EdgeInsets.all(80.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(52, 25, 76, 134),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Maps preview will go here',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 25, 76, 134)),
                textAlign: TextAlign.center,
              ),
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
              onTap: () {}, //TODO implement tasks in the job class
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
              child: ExpansionTile(
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
              child: ExpansionTile(
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
                  ListTile(
                    title: const Text('Type'),
                    subtitle: Text(widget.job.type),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
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