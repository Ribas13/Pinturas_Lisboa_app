// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../job.dart';

class AddJobScreen extends StatefulWidget {
  @override
  _AddJobScreenState createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  final _formKey = GlobalKey<FormState>();
  String _jobTitle = '';
  String _jobAddress = '';
  String _selectedJobType = 'Apartment';
  int _numberOfRooms = 0;
  int _bathrooms = 0;
  int _kitchens = 0;
  int _livingRooms = 0;
  int _hallways = 0;
  int _balconies = 0;
  int _garages = 0;
  int _otherRooms = 0;
  String _typeOfPaint = '';
  String _typeOfFinish = '';
  String _previousColor = '';
  String _newColor = '';
  String _colorReference = '';
  bool _furnished = false;
  String _notes = '';
  


  final List<String> _jobTypes = ['Apartment', 'House', 'Commercial'];

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final Job newJob = Job(title: _jobTitle, address: _jobAddress, type: _selectedJobType, rooms: _numberOfRooms, bathrooms: _bathrooms, kitchens: _kitchens, livingRooms: _livingRooms, hallways: _hallways, balconies: _balconies, garages: _garages, otherRooms: _otherRooms, typeOfPaint: _typeOfPaint, typeOfFinish: _typeOfFinish, previousColor: _previousColor, newColor: _newColor, colorReference: _colorReference, furnished: _furnished, notes: _notes);
      // ignore: use_build_context_synchronously
      Navigator.pop(context, newJob);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Job'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Job Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a job title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _jobTitle = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Address'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _jobAddress = value!;
                  },
                ),
                DropdownButtonFormField(
                  value: _selectedJobType,
                  decoration: const InputDecoration(labelText: 'Job Type'),
                  items: _jobTypes.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedJobType = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a job type';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Rooms'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the number of rooms';
                    }
                    final int? rooms = int.tryParse(value);
                    if (rooms == null || rooms < 0) {
                      return 'Please enter a valid number of rooms';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _numberOfRooms = int.parse(value!);
                    });
                  }
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Bathrooms'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the number of bathrooms';
                    }
                    final int? bathrooms = int.tryParse(value);
                    if (bathrooms == null || bathrooms < 0) {
                      return 'Please enter a valid number of bathrooms';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _bathrooms = int.parse(value!);
                    });
                  }
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Kitchens'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the number of kitchens';
                    }
                    final int? kitchens = int.tryParse(value);
                    if (kitchens == null || kitchens < 0) {
                      return 'Please enter a valid number of kitchens';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _kitchens = int.parse(value!);
                    });
                  }
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Living Rooms'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the number of living rooms';
                    }
                    final int? livingRooms = int.tryParse(value);
                    if (livingRooms == null || livingRooms < 0) {
                      return 'Please enter a valid number of living rooms';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _livingRooms = int.parse(value!);
                    });
                  }
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Hallways'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the number of hallways';
                    }
                    final int? hallways = int.tryParse(value);
                    if (hallways == null || hallways < 0) {
                      return 'Please enter a valid number of hallways';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _hallways = int.parse(value!);
                    });
                  }
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Balconies'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the number of balconies';
                    }
                    final int? balconies = int.tryParse(value);
                    if (balconies == null || balconies < 0) {
                      return 'Please enter a valid number of balconies';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _balconies = int.parse(value!);
                    });
                  }
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Garages'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the number of garages';
                    }
                    final int? garages = int.tryParse(value);
                    if (garages == null || garages < 0) {
                      return 'Please enter a valid number of garages';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _garages = int.parse(value!);
                    });
                  }
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Other Rooms'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the number of other rooms';
                    }
                    final int? otherRooms = int.tryParse(value);
                    if (otherRooms == null || otherRooms < 0) {
                      return 'Please enter a valid number of other rooms';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _otherRooms = int.parse(value!);
                    });
                  }
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Type of Paint'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the type of paint';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _typeOfPaint = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Type of Finish'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the type of finish';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _typeOfFinish = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Previous Color'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the previous color';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _previousColor = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'New Color'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the new color';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _newColor = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Color Reference'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the color reference';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _colorReference = value!;
                  },
                ),
                DropdownButtonFormField<bool>(
                  decoration: const InputDecoration(labelText: 'Furnished'),
                  value: _furnished,
                  items: const [
                    DropdownMenuItem(value: true, child: Text('Yes')),
                    DropdownMenuItem(value: false, child: Text('No')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _furnished = value!;
                    });
                  }
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Notes'),
                  maxLines: 3,
                  onSaved: (value) {
                    setState(() {
                      _notes = value!;
                    });
                  }
                ),
                ElevatedButton(
                  // onPressed: _submitForm,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _submitForm();
                    }
                  },
                  child: const Text('Add Job'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}