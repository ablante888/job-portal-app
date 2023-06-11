import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './skills.dart';
import './experience.dart';
//import 'package:date_field/date_field.dart';
import '../jobSeekerModel/job_seeker_profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './datepicker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../user_account/utils.dart';

class EducationForm extends StatefulWidget {
  //const EducationForm({Key? key}) : super(key: key);
  static const routeName = '/EducationForm';

  @override
  State<EducationForm> createState() => _EducationFormState();
}

class _EducationFormState extends State<EducationForm> {
  final _formKey = GlobalKey<FormState>();
  String getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }

  Future saveEducationInfo(Education educationinfo) async {
    final personal_info_doc_ref = FirebaseFirestore.instance
        .collection('job-seeker')
        .doc(getCurrentUserUid());
    final json = educationinfo.toJson();
    // final <Map<Map>> tt = {'education', json};
    await personal_info_doc_ref
        .collection('jobseeker-profile')
        .doc('profile')
        .set({'education': json}, SetOptions(merge: true));
  }

  final collageNameController = TextEditingController();
  final CGPAController = TextEditingController();

  List<String> higherEducation = ['Bacheler', 'masters', 'Phd'];
  List<String> fieldOfStudy = [
    'computer science',
    'software engineering',
    'Information Technology',
    'Chemical engineering',
    'Economics'
  ];
  String Cgpa = '';
  String? institution;
  var eduLevelChoosed;
  var fieldOfStudyChoosed;
  String startDateSelected = DateTime.now().toString();
  String endDateSelected = DateTime.now().toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Educaton'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 40, bottom: 10, right: 15, left: 15),
            child: Form(
              key: _formKey,
              child: Column(
                //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    decoration: BoxDecoration(
                        // border: Border.all(
                        //     color: Colors.blue, style: BorderStyle.solid)
                        // color: Color.fromARGB(255, 39, 176, 39),
                        ),
                    child: Text(
                      'Educational background',
                      style: TextStyle(
                          fontSize: 30,
                          // fontWeight: FontWeight.bold,
                          fontFamily: 'Anton',
                          //  color: Colors.black38
                          color: Colors.blue),
                    ),
                  ),
                  Text('Highest Education Level'),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          filled: true,
                          fillColor: Colors.blue,
                          hintText: 'Select an option',
                          hintStyle: TextStyle(color: Colors.white),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        validator: ((value) {
                          if (value == null) {
                            return 'please select an option';
                          }
                        }),
                        value: eduLevelChoosed,
                        items: higherEducation.map((item) {
                          return DropdownMenuItem(
                            child: Text(item),
                            value: item,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            eduLevelChoosed = value.toString();
                          });
                        }),
                  ),
                  Text('college/University name *'),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: TextFormField(
                      controller: collageNameController,
                      decoration: InputDecoration(
                        labelText: 'Institution',
                        labelStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Please enter Your name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        institution = value;
                      },
                    ),
                  ),
                  Text('Field of study'),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          filled: true,
                          fillColor: Colors.blue,
                          hintText: 'Select an option',
                          hintStyle: TextStyle(color: Colors.white),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        validator: ((value) {
                          if (value == null) {
                            return 'please select an option';
                          }
                        }),
                        value: fieldOfStudyChoosed,
                        items: fieldOfStudy.map((item) {
                          return DropdownMenuItem(
                            child: Text(item),
                            value: item,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            fieldOfStudyChoosed = value.toString();
                          });
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: DateFormField(
                      label: 'Start Date',
                      initialDate: DateTime.now(),
                      onDateSelected: (date) {
                        // do something with the selected date
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: DateFormField(
                      label: 'end Date',
                      initialDate: DateTime.now(),
                      onDateSelected: (date) {
                        // do something with the selected date
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(child: Text('Cumulative GPA')),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: TextFormField(
                      controller: CGPAController,
                      decoration: InputDecoration(
                        labelText: 'CGPA',
                        labelStyle: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Please enter Your name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        if (value != null) Cgpa = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                        try {
                          final educationInfo = Education(
                              GPA: Cgpa,
                              levelOfEducation: eduLevelChoosed,
                              institution: collageNameController.text,
                              fieldOfStudy: fieldOfStudyChoosed,
                              startDate: startDateSelected,
                              endDate: endDateSelected);
                          print(
                              ' the educational info is ${educationInfo.GPA}');
                          //saveEducationInfo(educationInfo);
                          EducationProvider provider = EducationProvider();
                          provider.education = educationInfo;
                          Utils.showSnackBar('sucessfully saved', Colors.green);
                        } on FirebaseException catch (e) {
                          Utils.showSnackBar(e.message, Colors.red);
                        }
                      }

                      Navigator.pushNamed(context, Experience.routeName);
                    },
                    icon: Icon(Icons.forward),
                    label: Text('Save and Continue'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      // primary: Colors.blue[900],
                      padding: EdgeInsets.all(10.0),
                      elevation: 10.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
