import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import './skills.dart';
//import 'package:date_field/date_field.dart';
import '../jobSeekerModel/job_seeker_profile_model.dart';
import './datepicker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../user_account/utils.dart';

class Experience extends StatefulWidget {
  const Experience({Key? key}) : super(key: key);
  static const routeName = '/Experience';

  @override
  State<Experience> createState() => _ExperienceState();
}

class _ExperienceState extends State<Experience> {
  String getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }

  Future saveExperienceInfo(ExperienceModel experienceInfo) async {
    final personal_info_doc_ref = FirebaseFirestore.instance
        .collection('job-seeker')
        .doc(getCurrentUserUid());
    final json = experienceInfo.toJson();
    await personal_info_doc_ref
        .collection('jobseeker-profile')
        .doc('profile')
        .set({
      'experiences': {'experience': json}
    }, SetOptions(merge: true));
  }

  final _formKey = GlobalKey<FormState>();
  final jobTitleController = TextEditingController();
  final companyController = TextEditingController();
  final cityController = TextEditingController();
  final regionController = TextEditingController();
  late DateTime startDateController;
  late DateTime endDateController;
  String jobTitle = '';
  String company = '';
  String region = '';
  String city = '';
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  void startDateSelected(DateTime selectedDate) {
    startDate = selectedDate;
  }

  void endDateSelected(DateTime selectedDate) {
    endDate = selectedDate;
  }

  List State = ['Amhara', 'AA', 'Hareri', 'Somali'];
  var stateSelected;
  //List towns = ['Ethiopia', 'america', 'england', 'Germany'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Experience'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  ' Prior work experience',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.blue),
                ),
                Text(' job title'),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: TextFormField(
                    controller: jobTitleController,
                    decoration: InputDecoration(
                      labelText: 'job title',
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
                        return 'Please enter the job title';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) jobTitle = value;
                    },
                  ),
                ),
                Text('Company Name'),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: TextFormField(
                    controller: companyController,
                    decoration: InputDecoration(
                      labelText: 'company name',
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
                        return 'Please enter Your company name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) company = value;
                    },
                  ),
                ),
                Text('Region'),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: TextFormField(
                    controller: regionController,
                    decoration: InputDecoration(
                      labelText: 'Region',
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
                        return 'Please enter Your region name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) region = value;
                    },
                  ),
                ),
                Text('City'),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: TextFormField(
                    controller: cityController,
                    decoration: InputDecoration(
                      labelText: 'city',
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
                        return 'Please enter Your city name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value != null) city = value;
                    },
                  ),
                ),
                Text('Date'),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: DateFormField(
                    label: 'Start Date',
                    initialDate: DateTime.now(),
                    onDateSelected: (date) {
                      startDate = date;
                      // do something with the selected date
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: DateFormField(
                    label: 'End Date',
                    initialDate: DateTime.now(),
                    onDateSelected: (date) {
                      endDate = date;
                      // do something with the selected date
                    },
                  ),
                ),
                //  Text('projects worked on'),
                ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
                      try {
                        final experienceInfo = ExperienceModel(
                            title: jobTitle,
                            company: company,
                            startDate: startDate,
                            endDate: endDate,
                            city: city,
                            region: region);
                        print(experienceInfo.city);
                        print(experienceInfo.company);
                        print(experienceInfo.region);
                        print(experienceInfo.startDate);
                        ExperienceProvider provider = ExperienceProvider();
                        provider.experience = experienceInfo;
                        final getData = provider.experience;
                        print(getData.city);

                        // saveExperienceInfo(experienceInfo);
                        Utils.showSnackBar('sucessfully saved', Colors.green);
                      } catch (e) {
                        Utils.showSnackBar(e.toString(), Colors.red);
                      }
                    }

                    Navigator.pushNamed(context, SkillSet.routeName);
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
    );
  }
}
