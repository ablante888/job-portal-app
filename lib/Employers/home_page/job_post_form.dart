import 'package:flutter/material.dart';
//import 'package:flutter_tags/flutter_tags.dart';

class JobPostingForm extends StatefulWidget {
  @override
  _JobPostingFormState createState() => _JobPostingFormState();
}

class _JobPostingFormState extends State<JobPostingForm> {
  final _formKey = GlobalKey<FormState>();
  List jobCtegory = ['Technology', 'Agriculture', 'blabal'];
  List employmentType = ['Partime', 'Full time'];
  List experienceLevel = [
    'Fresh',
    '2 years',
    '3 years',
    '5 years',
  ];
  List educationLevel = ['bachelor', 'MSC', 'PHD'];
  String? jobCategorySelected;
  String? jobDescreption;
  String? employmentTypeSelected;
  String? experienceLevelSelected;
  String? educatonLelSeleceted;
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post a Job'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Job Title'),
                TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Job Title',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a job title';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Job Category'),
                DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      filled: true,
                      fillColor: Colors.blue[100],
                      hintText: 'Select an option',
                      hintStyle: TextStyle(color: Colors.white),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    validator: (value) {
                      if (value == null) return 'please select an option';
                    },
                    items: jobCtegory
                        .map((item) => DropdownMenuItem(
                              child: Text(item),
                              value: item,
                            ))
                        .toList(),
                    value: jobCategorySelected,
                    onChanged: (value) {
                      setState(() {
                        jobCategorySelected = value.toString();
                      });
                    }),
                SizedBox(height: 16),
                Text('Job Descreption'),
                TextFormField(
                  onSaved: (newValue) {
                    if (newValue != null) jobDescreption = newValue;
                  },
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Job Descreption',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text('Salary Range'),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Salary Range',
                    labelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a salary range';
                    }
                    final regex = RegExp(r'^\d+(\.\d{1,2})?$');
                    if (!regex.hasMatch(value)) {
                      return 'Please enter a valid salary range';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Text('Employment Type'),
                SizedBox(height: 16),
                DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      filled: true,
                      fillColor: Colors.blue[100],
                      hintText: 'Select an option',
                      hintStyle: TextStyle(color: Colors.white),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    validator: (value) {
                      if (value == null) return 'please select an option';
                    },
                    items: employmentType
                        .map((item) => DropdownMenuItem(
                              child: Text(item),
                              value: item,
                            ))
                        .toList(),
                    value: employmentTypeSelected,
                    onChanged: (value) {
                      setState(() {
                        employmentTypeSelected = value.toString();
                      });
                    }),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Location',
                    labelStyle: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 1.5,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1.5,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1.5,
                      ),
                    ),
                    errorStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a location';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Text('Experience Level'),
                DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      filled: true,
                      fillColor: Colors.blue[100],
                      hintText: 'Select an option',
                      hintStyle: TextStyle(color: Colors.white),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    validator: (value) {
                      if (value == null) return 'please select an option';
                    },
                    items: experienceLevel
                        .map((item) => DropdownMenuItem(
                              child: Text(item),
                              value: item,
                            ))
                        .toList(),
                    value: experienceLevelSelected,
                    onChanged: (value) {
                      setState(() {
                        experienceLevelSelected = value.toString();
                      });
                    }),
                SizedBox(
                  height: 16,
                ),
                SizedBox(height: 16),
                Text('Education Level'),
                DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      filled: true,
                      fillColor: Colors.blue[100],
                      hintText: 'Select an option',
                      hintStyle: TextStyle(color: Colors.white),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    validator: (value) {
                      if (value == null) return 'please select an option';
                    },
                    items: educationLevel
                        .map((item) => DropdownMenuItem(
                              child: Text(item),
                              value: item,
                            ))
                        .toList(),
                    value: educatonLelSeleceted,
                    onChanged: (value) {
                      setState(() {
                        educatonLelSeleceted = value.toString();
                      });
                    }),
                Text('Application Deadline'),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Application Deadline',
                    hintText: 'Select Deadline',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () {
                        _selectDate(context);
                      },
                    ),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (_selectedDate == null) {
                      return 'Please select the application deadline';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    // Save the selected date here
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                // RaisedButton(
                //   child: Text('Post Job'),
                //   onPressed: () {
                //     if (_formKey.currentState!.validate()) {
                //       // TODO: Save job posting data
                //     }
                //   },
                // ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: Save job posting data
                    }
                  },
                  child: Text('Post a new Job'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class JobPosting {
//   String id;
//   String title;
//   String company;
//   String location;
//   String industry;
//   String description;
//   double salary;
//   DateTime deadline;
//   List<String> requirements;

//   JobPosting({
//     required this.id,
//     required this.title,
//     required this.company,
//     required this.location,
//     required this.industry,
//     required this.description,
//     required this.salary,
//     required this.deadline,
//     required this.requirements,
//   });
// }
