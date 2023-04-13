import 'package:flutter/material.dart';
import './education.dart';
import '../models/job_seeker_profile_model.dart';
import '../models/job_seeker_profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class personal_info extends StatefulWidget {
  const personal_info({Key? key}) : super(key: key);
  static const routeName = '/personal_info';
  @override
  State<personal_info> createState() => _personal_infoState();
}

class _personal_infoState extends State<personal_info> {
  final _formKey = GlobalKey<FormState>();
  Future savePesonalInfo(PersonalInfo personalinfo) async {
    final personal_info_doc =
        FirebaseFirestore.instance.collection('job seeker').doc();
    final json = personalinfo.toJeson();
    await personal_info_doc
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
  List countries = ['Ethiopia', 'america', 'england', 'Germany'];
  List regions = ['Ethiopia', 'america', 'england', 'Germany'];
  List towns = ['Ethiopia', 'america', 'england', 'Germany'];
  List gender = [
    'Male',
    'Female',
  ];
  String? countryChoosed;
  String? genderChoosed;
  String? regionChoosed;
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
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: Text('First Name *')),
                    TextFormField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                        labelText: 'contact person Name',
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
                        // ownerName = value;
                      },
                    ),
                    // Container(
                    //   padding: EdgeInsets.only(
                    //       left: 30.0, right: 50.0, top: 10.0, bottom: 10.0),
                    //   width: MediaQuery.of(context).size.width * 3 / 2,
                    //   child: Card(
                    //     borderOnForeground: true,
                    //     elevation: 5,
                    //     child: TextFormField(
                    //       controller: firstNameController,
                    //       decoration: InputDecoration(
                    //         label: Center(
                    //           child: Text('text'),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Center(child: Text('Last Name *')),
                    Container(
                      padding: EdgeInsets.only(
                          left: 30.0, right: 50.0, top: 10.0, bottom: 10.0),
                      width: MediaQuery.of(context).size.width * 3 / 2,
                      child: Card(
                        borderOnForeground: true,
                        elevation: 5,
                        child: TextFormField(
                          controller: lastNameController,
                          decoration: InputDecoration(
                              label: Center(
                            child: Text('Last name'),
                          )),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            left: 30, right: 0, top: 0, bottom: 0),
                        child: Text(
                          'Gender',
                          textAlign: TextAlign.center,
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 30, right: 0, top: 0, bottom: 0),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10.0, right: 30.0, top: 10.0, bottom: 10.0),
                        //width: MediaQuery.of(context).size.width / 2,
                        child: Card(
                          borderOnForeground: true,
                          elevation: 5,
                          child: DropdownButton(
                            // isDense: true,
                            isExpanded: true,
                            hint: Text('Gender'),
                            items: gender.map((item) {
                              return DropdownMenuItem(
                                  value: item, child: Text(item));
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                genderChoosed = newValue.toString();
                              });
                            },
                            value: genderChoosed,
                          ),
                        ),
                      ),
                    ),
                    Center(child: Text('Country *')),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 30, right: 0, top: 0, bottom: 0),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10.0, right: 30.0, top: 10.0, bottom: 10.0),
                        //width: MediaQuery.of(context).size.width / 2,
                        child: Card(
                          borderOnForeground: true,
                          elevation: 5,
                          child: DropdownButton(
                            // isDense: true,
                            isExpanded: true,
                            hint: Text('Country'),
                            items: countries.map((item) {
                              return DropdownMenuItem(
                                  value: item, child: Text(item));
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                countryChoosed = newValue.toString();
                              });
                            },
                            value: countryChoosed,
                          ),
                        ),
                      ),
                    ),
                    Center(child: Text('Region *')),
                    Container(
                      padding: EdgeInsets.only(
                          left: 40.0, right: 30.0, top: 10.0, bottom: 10.0),
                      width: MediaQuery.of(context).size.width * 3 / 2,
                      height: 70,
                      child: Card(
                        borderOnForeground: true,
                        elevation: 5,
                        child: TextFormField(
                          controller: regionController,
                          decoration: InputDecoration(
                              label: Center(
                            child: Text('Region'),
                          )),
                        ),
                      ),
                    ),
                    Center(child: Text('City(Home Town) *')),
                    Container(
                      padding: EdgeInsets.only(
                          left: 40.0, right: 30.0, top: 10.0, bottom: 10.0),
                      width: MediaQuery.of(context).size.width * 3 / 2,
                      height: 70,
                      child: Card(
                        borderOnForeground: true,
                        elevation: 5,
                        child: TextFormField(
                          controller: cityController,
                          decoration: InputDecoration(
                              label: Center(
                            child: Text('City'),
                          )),
                        ),
                      ),
                    ),
                    Center(child: Text('Contact information *')),
                    Container(
                      padding: EdgeInsets.only(
                          left: 40.0, right: 30.0, top: 10.0, bottom: 10.0),
                      width: MediaQuery.of(context).size.width * 3 / 2,
                      height: 70,
                      child: Card(
                        borderOnForeground: true,
                        elevation: 5,
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                              label: Center(child: Text(' Email Adress'))),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 40.0, right: 30.0, top: 10.0, bottom: 10.0),
                      width: MediaQuery.of(context).size.width * 3 / 2,
                      height: 70,
                      child: Card(
                        borderOnForeground: true,
                        elevation: 5,
                        child: TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(
                              label: Center(child: Text(' phone number'))),
                        ),
                      ),
                    ),
                    //  ElevatedButton(onPressed: () {}, child: Text('Save')),
                    ElevatedButton.icon(
                        onPressed: () {
                          final personal_info = PersonalInfo(
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              gender: genderChoosed.toString(),
                              city: cityController.text,
                              region: regionController.text,
                              email: emailController.text,
                              phoneNumber: phoneController.text);
                          savePesonalInfo(personal_info);
                          Navigator.pushNamed(context, EducationForm.routeName);
                        },
                        icon: Icon(Icons.navigate_next),
                        label: Text('Next')),
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

// import 'package:flutter/material.dart';
// import './skills.dart';
// import './experience.dart';
// import 'package:date_field/date_field.dart';
// import '../models/job_seeker_profile_model.dart' show Education;
// import 'package:cloud_firestore/cloud_firestore.dart';
// import './datepicker.dart';

class EducationForm extends StatefulWidget {
  //const EducationForm({Key? key}) : super(key: key);
  static const routeName = '/EducationForm';

  @override
  State<EducationForm> createState() => _EducationFormState();
}

class _EducationFormState extends State<EducationForm> {
  Future saveEducationInfo(Education educationinfo) async {
    final personal_info_doc =
        FirebaseFirestore.instance.collection('job seeker').doc();
    final education_doc = personal_info_doc
        .collection('profile')
        .doc('personal_info')
        .collection('education')
        .doc();
    final json = educationinfo.toJeson();
    await education_doc.set(json);
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

  var eduLevelChoosed;
  var fieldOfStudyChoosed;
  String startDateSelected = DateTime.now().toString();
  String endDateSelected = DateTime.now().toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('form'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                child: Text('Tell us about your educational backgoung'),
              ),
              Text('Highest Education Level'),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 0, top: 0, bottom: 0),
                child: Container(
                  padding: EdgeInsets.only(
                      left: 10.0, right: 30.0, top: 10.0, bottom: 10.0),
                  //width: MediaQuery.of(context).size.width / 2,
                  child: Card(
                    borderOnForeground: true,
                    elevation: 5,
                    child: DropdownButton(
                      // isDense: true,
                      isExpanded: true,
                      hint: Text('Level of Education'),
                      items: higherEducation.map((item) {
                        return DropdownMenuItem(value: item, child: Text(item));
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          eduLevelChoosed = newValue.toString();
                        });
                      },
                      value: eduLevelChoosed,
                    ),
                  ),
                ),
              ),
              Text('college/University name *'),
              Container(
                padding: EdgeInsets.only(
                    left: 40.0, right: 30.0, top: 10.0, bottom: 10.0),
                width: MediaQuery.of(context).size.width * 3 / 2,
                child: Card(
                  borderOnForeground: true,
                  elevation: 5,
                  child: TextField(
                    controller: collageNameController,
                    decoration: InputDecoration(label: Text(' name')),
                  ),
                ),
              ),
              Text('Field of study'),
              Padding(
                padding: EdgeInsets.only(left: 30, right: 0, top: 0, bottom: 0),
                child: Container(
                  padding: EdgeInsets.only(
                      left: 10.0, right: 30.0, top: 10.0, bottom: 10.0),
                  //width: MediaQuery.of(context).size.width / 2,
                  child: Card(
                    borderOnForeground: true,
                    elevation: 5,
                    child: DropdownButton(
                      // isDense: true,
                      isExpanded: true,
                      hint: Text('Field of study'),
                      items: fieldOfStudy.map((item) {
                        return DropdownMenuItem(value: item, child: Text(item));
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          fieldOfStudyChoosed = newValue.toString();
                        });
                      },
                      value: fieldOfStudyChoosed,
                    ),
                  ),
                ),
              ),
              DateFormField(
                label: 'Start Date',
                initialDate: DateTime.now(),
                onDateSelected: (date) {
                  // do something with the selected date
                },
              ),
              DateFormField(
                label: 'end Date',
                initialDate: DateTime.now(),
                onDateSelected: (date) {
                  // do something with the selected date
                },
              ),
              // Form(
              //   child: DateTimeField(
              //       decoration: InputDecoration(
              //         constraints: BoxConstraints(
              //             maxWidth: MediaQuery.of(context).size.width / 2),
              //         border: OutlineInputBorder(),
              //         suffixIcon: Icon(Icons.event_note),
              //         labelText: 'Start date',
              //       ),
              //       // firstDate: DateTime.now().add(const Duration(days: 20)),
              //       // initialDate: DateTime.now().add(const Duration(days: 10)),
              //       // lastDate: DateTime.now().add(const Duration(days: 40)),
              //       onDateSelected: (value) {
              //         setState(() {
              //           startDateSelected = value.toString();
              //         });
              //       },
              //       selectedDate: DateTime.now()),
              // ),
              SizedBox(
                height: 20,
              ),
              // Form(
              //   child: DateTimeField(
              //     decoration: InputDecoration(
              //       constraints: BoxConstraints(
              //           maxWidth: MediaQuery.of(context).size.width / 2),
              //       border: OutlineInputBorder(),
              //       suffixIcon: Icon(Icons.event_note),
              //       labelText: 'End date',
              //     ),
              //     // firstDate: DateTime.now().add(const Duration(days: 20)),
              //     // initialDate: DateTime.now().add(const Duration(days: 10)),
              //     // lastDate: DateTime.now().add(const Duration(days: 40)),
              //     onDateSelected: (value) {
              //       setState(() {
              //         setState(() {
              //           endDateSelected = value.toString();
              //         });
              //       });

              //       print(value);
              //     },
              //     selectedDate: DateTime.now(),
              //   ),
              // ),
              Text('Cumulative GPA'),
              Container(
                padding: EdgeInsets.only(
                    left: 40.0, right: 30.0, top: 10.0, bottom: 10.0),
                width: MediaQuery.of(context).size.width * 3 / 2,
                child: Card(
                  borderOnForeground: true,
                  elevation: 5,
                  child: TextField(
                    controller: CGPAController,
                    decoration: InputDecoration(label: Text(' CGPA')),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  final educationInfo = Education(
                      levelOfEducation: eduLevelChoosed,
                      institution: collageNameController.text,
                      fieldOfStudy: fieldOfStudyChoosed,
                      startDate: startDateSelected,
                      endDate: endDateSelected);
                  saveEducationInfo(educationInfo);
                  Navigator.pushNamed(context, Experience.routeName);
                },
                icon: Icon(Icons.navigate_next),
                label: Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}











  // Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               children: [
  //                 Form(
  //                   child: DateTimeField(
  //                       decoration: InputDecoration(
  //                         constraints: BoxConstraints(
  //                             maxWidth: MediaQuery.of(context).size.width / 3),
  //                         border: OutlineInputBorder(),
  //                         suffixIcon: Icon(Icons.event_note),
  //                         labelText: 'Start date',
  //                       ),
  //                       // firstDate: DateTime.now().add(const Duration(days: 20)),
  //                       // initialDate: DateTime.now().add(const Duration(days: 10)),
  //                       // lastDate: DateTime.now().add(const Duration(days: 40)),
  //                       onDateSelected: (value) {
  //                         setState(() {
  //                           startDateController = value;
  //                         });
  //                       },
  //                       selectedDate: DateTime.now()),
  //                 ),
  //                 Form(
  //                   child: DateTimeField(
  //                       decoration: InputDecoration(
  //                         constraints: BoxConstraints(
  //                             maxWidth: MediaQuery.of(context).size.width / 3),
  //                         border: OutlineInputBorder(),
  //                         suffixIcon: Icon(Icons.event_note),
  //                         labelText: 'End date',
  //                       ),
  //                       // firstDate: DateTime.now().add(const Duration(days: 20)),
  //                       // initialDate: DateTime.now().add(const Duration(days: 10)),
  //                       // lastDate: DateTime.now().add(const Duration(days: 40)),
  //                       onDateSelected: (value) {
  //                         setState(() {
  //                           endDateController = value;
  //                         });
  //                       },
  //                       selectedDate: DateTime.now()),
  //                 ),
  //               ],
  //             ),





  //###################### skills.dart   ######################

// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:project1/profile/profile_picture.dart';
// import '../models/job_seeker_profile_model.dart';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../Employers/emp_profile/compLogo_Picker.dart';

// class SkillSet extends StatefulWidget {
//   //const SkillSet({Key? key}) : super(key: key);
//   static const routeName = '/SkillSet';

//   @override
//   State<SkillSet> createState() => _SkillSetState();
// }

// class _SkillSetState extends State<SkillSet> {
//   late PickedFile _imageFile;
//   final ImagePicker Picker = ImagePicker();
//   File imageFile = File('');

//   List<String> personalSkill = [];
//   List<String> proffesionalSkill = [];
//   List<String> languageSkill = [];
//   List<String> achivSkill = [];
//   String? about;

//   final profSkillController = TextEditingController();
//   final persSkillController = TextEditingController();
//   final langSkillController = TextEditingController();
//   final achivSkillController = TextEditingController();
//   void _onImageSelected(File image) {
//     File? _image;
//     setState(() {
//       _image = image;
//     });
//   }

//   void _addProffSkill(String skill) {
//     if (!proffesionalSkill.contains(skill)) {
//       setState(() {
//         proffesionalSkill.add(skill);
//       });
//     }
//   }

//   void _removeproffSkill(String skill) {
//     setState(() {
//       proffesionalSkill.remove(skill);
//     });
//   }

//   void _addPersonalSkill(String skill) {
//     if (!personalSkill.contains(skill)) {
//       setState(() {
//         personalSkill.add(skill);
//       });
//     }
//   }

//   void _removePersonalSkill(String skill) {
//     setState(() {
//       personalSkill.remove(skill);
//     });
//   }

//   void _addLanguageSkill(String skill) {
//     if (!languageSkill.contains(skill)) {
//       setState(() {
//         languageSkill.add(skill);
//       });
//     }
//   }

//   // void addLanguageSkill(List skills, Function addSkill) {}
//   void _removeSkill(String skill) {
//     setState(() {
//       languageSkill.remove(skill);
//     });
//   }

//   void _addAchivSkill(String skill) {
//     if (!achivSkill.contains(skill)) {
//       setState(() {
//         achivSkill.add(skill);
//       });
//     }
//   }

//   //void addAchivSkill(List skills, Function addSkill) {}
//   void _removeAchivSkill(String skill) {
//     setState(() {
//       achivSkill.remove(skill);
//     });
//   }

//   Widget bottomSheet() {
//     return Container(
//       height: 100,
//       width: MediaQuery.of(context).size.width,
//       margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//       child: Column(
//         children: [
//           Text('choose profile picture'),
//           SizedBox(
//             height: 20,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               OutlinedButton.icon(
//                   onPressed: () => takePhoto(ImageSource.camera),
//                   icon: Icon(Icons.camera),
//                   label: Text('Camera')),
//               OutlinedButton.icon(
//                   onPressed: () => takePhoto(ImageSource.gallery),
//                   icon: Icon(Icons.image),
//                   label: Text('Gallery')),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   Widget imageProfile(BuildContext ctx) {
//     return Stack(
//       children: [
//         CircleAvatar(
//           radius: 80,
//           backgroundImage: imageFile == null
//               ? AssetImage('assets/profile.png') as ImageProvider
//               : FileImage(File(imageFile.path)),
//         ),
//         Positioned(
//           bottom: 20,
//           right: 20,
//           child: Builder(builder: (context) {
//             return InkWell(
//               // onTap: () => showBottomSheet(
//               //     onClosing: () {}, builder: (context) => bottomSheet()),
//               onTap: () => Scaffold.of(context)
//                   .showBottomSheet((context) => bottomSheet()),
//               // onTap: () {
//               //   showBottomSheet(
//               //       context: context, builder: (ctx) => bottomSheet());
//               // },
//               child: Icon(
//                 color: Colors.white,
//                 Icons.camera_alt,
//                 size: 25,
//               ),
//             );
//           }),
//         )
//       ],
//     );
//   }

//   void takePhoto(ImageSource source) async {
//     final _PickedFile = await Picker.pickImage(source: source);
//     if (_PickedFile == null) return null;
//     setState(() {
//       _imageFile = _PickedFile as PickedFile;
//       imageFile = File(_imageFile.path);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('form'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Text('Share your skills with us'),
//             Row(
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(
//                       left: 40.0, right: 30.0, top: 10.0, bottom: 10.0),
//                   width: MediaQuery.of(context).size.width * 3 / 4,
//                   child: Card(
//                       borderOnForeground: true,
//                       elevation: 5,
//                       child: TextFormField(
//                         // onSubmitted: _addProffSkill,
//                         controller: profSkillController,
//                         decoration: InputDecoration(
//                             label: Text(' Professional skills'),
//                             suffixIcon: IconButton(
//                                 onPressed: () {
//                                   _addProffSkill(profSkillController.text);
//                                 },
//                                 icon: Icon(
//                                   Icons.add,
//                                   color: Colors.pink,
//                                 ))),
//                       )),
//                 ),
//                 // OutlinedButton.icon(
//                 //     onPressed: () {
//                 //       _addProffSkill(profSkillController.text);
//                 //       // proffesionalSkill.add(profSkillController.text);
//                 //       // profSkillController.clear();
//                 //     },
//                 //     icon: Icon(Icons.add),
//                 //     label: Text('ADD')),
//               ],
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Wrap(
//               spacing: 8.0,
//               runSpacing: 4.0,
//               children: [
//                 ...proffesionalSkill.map(
//                   (skill) => Chip(
//                     label: Text(skill),
//                     onDeleted: () => _removeSkill(skill),
//                   ),
//                 ),
//                 // SizedBox(
//                 //   width: 120.0,
//                 //   child: TextField(
//                 //     controller: profSkillController,
//                 //     decoration: InputDecoration(
//                 //       hintText: 'Add skill',
//                 //     ),
//                 //     onSubmitted: _addSkill,
//                 //   ),
//                 // ),
//               ],
//             ),
//             Row(
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(
//                       left: 40.0, right: 30.0, top: 10.0, bottom: 10.0),
//                   width: MediaQuery.of(context).size.width * 3 / 4,
//                   child: Card(
//                       borderOnForeground: true,
//                       elevation: 5,
//                       child: TextFormField(
//                         // onChanged: _addPersonalSkill,
//                         controller: persSkillController,
//                         decoration: InputDecoration(
//                             label: Text(' personal skills'),
//                             suffixIcon: IconButton(
//                                 onPressed: () {
//                                   _addPersonalSkill(persSkillController.text);
//                                 },
//                                 icon: Icon(
//                                   Icons.add,
//                                   color: Colors.pink,
//                                 ))),
//                       )),
//                 ),
//                 // OutlinedButton.icon(
//                 //     onPressed: () {
//                 //       _addPersonalSkill(persSkillController.text);
//                 //       // proffesionalSkill.add(profSkillController.text);
//                 //       // profSkillController.clear();
//                 //     },
//                 //     icon: Icon(Icons.add),
//                 //     label: Text('ADD')),
//               ],
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Wrap(
//               spacing: 8.0,
//               runSpacing: 4.0,
//               children: [
//                 ...personalSkill.map(
//                   (skill) => Chip(
//                     label: Text(skill),
//                     onDeleted: () => _removeSkill(skill),
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(
//                       left: 40.0, right: 30.0, top: 10.0, bottom: 10.0),
//                   width: MediaQuery.of(context).size.width * 3 / 4,
//                   child: Card(
//                       borderOnForeground: true,
//                       elevation: 5,
//                       child: TextFormField(
//                         //onChanged: _addLanguageSkill,
//                         controller: langSkillController,
//                         decoration: InputDecoration(
//                             label: Text(' Language skills'),
//                             suffixIcon: IconButton(
//                                 onPressed: () {
//                                   _addLanguageSkill(langSkillController.text);
//                                 },
//                                 icon: Icon(
//                                   Icons.add,
//                                   color: Colors.pink,
//                                 ))),
//                       )),
//                 ),
//                 // OutlinedButton.icon(
//                 //     onPressed: () {
//                 //       _addLanguageSkill(langSkillController.text);
//                 //       // proffesionalSkill.add(profSkillController.text);
//                 //       // profSkillController.clear();
//                 //     },
//                 //     icon: Icon(Icons.add),
//                 //     label: Text('ADD')),
//               ],
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Wrap(
//               spacing: 8.0,
//               runSpacing: 4.0,
//               children: [
//                 ...languageSkill.map(
//                   (skill) => Chip(
//                     label: Text(skill),
//                     onDeleted: () => _removeSkill(skill),
//                   ),
//                 ),
//               ],
//             ),
//             Text('Achievements'),
//             Row(
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(
//                       left: 40.0, right: 30.0, top: 10.0, bottom: 10.0),
//                   width: MediaQuery.of(context).size.width * 3 / 4,
//                   child: Card(
//                       borderOnForeground: true,
//                       elevation: 5,
//                       child: TextFormField(
//                         // onSubmitted: _addAchivSkill,
//                         controller: achivSkillController,
//                         decoration: InputDecoration(
//                             label: Text(' achivement skills'),
//                             suffixIcon: IconButton(
//                                 onPressed: () {
//                                   _addProffSkill(profSkillController.text);
//                                 },
//                                 icon: Icon(
//                                   Icons.add,
//                                   color: Colors.pink,
//                                 ))),
//                       )),
//                 ),
//                 OutlinedButton.icon(
//                     onPressed: () {
//                       _addPersonalSkill(achivSkillController.text);
//                       // proffesionalSkill.add(profSkillController.text);
//                       // profSkillController.clear();
//                     },
//                     icon: Icon(Icons.add),
//                     label: Text('ADD')),
//               ],
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Wrap(
//               spacing: 8.0,
//               runSpacing: 4.0,
//               children: [
//                 ...achivSkill.map(
//                   (skill) => Chip(
//                     label: Text(skill),
//                     onDeleted: () => _removeSkill(skill),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: EdgeInsets.all(8),
//               child: Text('Tell us about yourself'),
//             ),
//             SizedBox(height: 16.0),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//               child: TextFormField(
//                 onSaved: (newValue) => about = newValue,
//                 maxLines: 5,
//                 decoration: InputDecoration(
//                   labelText: 'summary',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                     borderSide: BorderSide(
//                       color: Colors.grey,
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                     borderSide: BorderSide(
//                       color: Colors.blue,
//                     ),
//                   ),
//                   errorBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                     borderSide: BorderSide(
//                       color: Colors.red,
//                     ),
//                   ),
//                   focusedErrorBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                     borderSide: BorderSide(
//                       color: Colors.red,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16.0),
//             Text('Add your profile image'),
//             // imageProfile(context),
//             CompanyLogoPicker(onImageSelected: _onImageSelected),
//             OutlinedButton.icon(
//                 onPressed: () {
//                   // final skill_Set = Skill(
//                   //     languageSkills: languageSkill,
//                   //     personalSkills: personalSkill,
//                   //     professionalSkills: proffesionalSkill);
//                   Navigator.of(context).pushNamed(profilePicture.routeName);
//                 },
//                 icon: Icon(Icons.navigate_next),
//                 label: Text('Next'))
//           ],
//         ),
//       ),
//     );
//   }
// }
