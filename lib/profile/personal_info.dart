//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './education.dart';
import '../models/job_seeker_profile_model.dart';
import '../models/job_seeker_profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../user_account/utils.dart';

class personal_info extends StatefulWidget {
  const personal_info({Key? key}) : super(key: key);
  static const routeName = '/personal_info';
  @override
  State<personal_info> createState() => _personal_infoState();
}

class _personal_infoState extends State<personal_info> {
  final _formKey = GlobalKey<FormState>();

// Get the current user's UID
  String getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }

  Future savePesonalInfo(PersonalInfo personalinfo) async {
    final personal_info_doc_ref = FirebaseFirestore.instance
        .collection('job-seeker')
        .doc(getCurrentUserUid());
    personalinfo.id = personal_info_doc_ref.id;
    final json = personalinfo.toJeson();
    await personal_info_doc_ref
        .collection('profile')
        .doc('personal_info')
        .set(json);
  }

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final regionController = TextEditingController();
  final cityController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  //final cityController = TextEditingController();
  DateTime? birthDate;
  bool isDateSelected = false;
  bool isCountrySelected = false;
  bool isCitySelected = false;
  bool isRegionSelected = false;
  //List countries = ['Ethiopia', 'america', 'england', 'Germany'];
  //List regions = ['amhara', 'oromia', 'south', 'somali'];
  //List towns = ['Ethiopia', 'america', 'england', 'Germany'];
  List gender = [
    'Male',
    'Female',
  ];
  String firstName = '';
  String LastName = '';
  String email = '';
  String countryName = '';
  String cityName = '';
  String phoneNumber = '';
  String countryChoosed = '';
  String genderChoosed = '';
  String regionChoosed = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Applicant form'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            // height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Form(
                key: _formKey,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(child: Text('First Name *')),
                    TextFormField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                        labelText: 'First name',
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
                        if (value != null) {
                          firstName = value;
                        }
                      },
                    ),

                    SizedBox(height: 16.0),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Last name',
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
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        if (value != null) {
                          LastName = value;
                        }
                      },
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Gender:',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    DropdownButtonFormField(
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
                        // value: genderChoosed,
                        items: gender.map((item) {
                          return DropdownMenuItem(
                            child: Text(item),
                            value: item,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            genderChoosed = value.toString();
                          });
                        }),
                    SizedBox(height: 16.0),

                    Center(child: Text('Country *')),
                    TextFormField(
                      // controller: firstNameController,
                      decoration: InputDecoration(
                        labelText: 'Country',
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
                          return 'Please enter Your Country name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        if (value != null) {
                          countryName = value;
                        }
                      },
                    ),
                    Center(child: Text('Region *')),
                    TextFormField(
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
                          return 'Please enter your Region';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        if (value != null) {
                          regionChoosed = value;
                        }
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Center(child: Text('City(Home Town) *')),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'city name',
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
                          return 'Please enter your city name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        if (value != null) {
                          cityName = value;
                        }
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Center(child: Text('Contact information *')),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email address',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        email = value.toString();
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'phone number',
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
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        //Do something when the value changes
                        phoneNumber = value.toString();
                      },
                    ),
                    // SizedBox(
                    //   height: 16,
                    // ),
                    //  ElevatedButton(onPressed: () {}, child: Text('Save')),
                    ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState?.save();
                            final personal_info = PersonalInfo(
                                firstName: firstName,
                                lastName: LastName,
                                gender: genderChoosed,
                                city: cityName,
                                region: regionChoosed,
                                email: email,
                                phoneNumber: phoneNumber);
                            // try {
                            //   savePesonalInfo(personal_info);
                            //   Utils.showSnackBar(
                            //       'sucessfully saved', Colors.green);
                            // } on FirebaseException catch (e) {
                            //   Utils.showSnackBar(e.message, Colors.red);
                            // }

                            Navigator.pushNamed(
                                context, EducationForm.routeName);
                          }
                        },
                        style: ButtonStyle(),
                        icon: Icon(Icons.navigate_next),
                        label: Text('Save and continue')),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
