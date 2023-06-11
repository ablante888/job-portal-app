import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project1/user_account/utils.dart';

class UpdateAboutMeDialog extends StatefulWidget {
  @override
  _UpdateAboutMeDialogState createState() => _UpdateAboutMeDialogState();
}

class _UpdateAboutMeDialogState extends State<UpdateAboutMeDialog> {
  String getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }

  void updateField(String aboutMe) async {
    try {
      await FirebaseFirestore.instance
          .collection('job-seeker')
          .doc(getCurrentUserUid())
          .collection('jobseeker-profile')
          .doc('profile')
          .update({'other-data.about me': '${aboutMe}'});
      print('Field updated successfully.');
    } catch (e) {
      print('Error updating field: $e');
    }
  }

  final TextEditingController aboutMeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Update About Me'),
      content: TextFormField(
        controller: aboutMeController,
        maxLines: 10,
        decoration: InputDecoration(
          labelText: 'About Me',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Save'),
          onPressed: () {
            String updatedAboutMe = aboutMeController.text;
            try {
              updateField(updatedAboutMe);
              Utils.showSnackBar('Sucessfuly Updated', Colors.green);
            } catch (e) {
              Utils.showSnackBar(e.toString(), Colors.red);
            }

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class UpdateSkillsDialog extends StatefulWidget {
  final String skill_Type;
  const UpdateSkillsDialog({Key? key, required this.skill_Type})
      : super(key: key);
  @override
  _UpdateSkillsDialogState createState() => _UpdateSkillsDialogState();
}

class _UpdateSkillsDialogState extends State<UpdateSkillsDialog> {
  String getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }

  void updateField(String skillType, String skillAdded) async {
    try {
      await FirebaseFirestore.instance
          .collection('job-seeker')
          .doc(getCurrentUserUid())
          .collection('jobseeker-profile')
          .doc('profile')
          .update({
        'skills.${skillType}': FieldValue.arrayUnion([skillAdded])
      });
      print('Field updated successfully.');
    } catch (e) {
      print('Error updating field: $e');
    }
  }

  final TextEditingController aboutMeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add more skills'),
      content: TextFormField(
        controller: aboutMeController,
        decoration: InputDecoration(
          labelText: 'Professional Skill',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('ADD'),
          onPressed: () {
            String skillAdded = aboutMeController.text;
            try {
              updateField(widget.skill_Type, skillAdded);
              Utils.showSnackBar('Sucessfuly Updated', Colors.green);
            } catch (e) {
              Utils.showSnackBar(e.toString(), Colors.red);
            }

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class UpdateExperienceDialog extends StatefulWidget {
  final Map<String, dynamic>? Experience;
  UpdateExperienceDialog({
    Key? key,
    required this.Experience,
  }) : super(key: key);
  @override
  _UpdateExperienceDialogState createState() => _UpdateExperienceDialogState();
}

class _UpdateExperienceDialogState extends State<UpdateExperienceDialog> {
  String getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }

  void updateField(String experienceAdded) async {
    try {
      await FirebaseFirestore.instance
          .collection('job-seeker')
          .doc(getCurrentUserUid())
          .collection('jobseeker-profile')
          .doc('profile')
          .set({
        'experiences.${DateTime.now().millisecondsSinceEpoch.toString()}':
            '${experienceAdded}'
      });
      print('Field updated successfully.');
    } catch (e) {
      print('Error updating field: $e');
    }
  }

  final TextEditingController aboutMeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add experience'),
      content: Container(
        height: MediaQuery.of(context).size.height / 3,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: aboutMeController
                  ..text = widget.Experience?['job title'],
                decoration: InputDecoration(
                  labelText: 'Job title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: aboutMeController,
                decoration: InputDecoration(
                  labelText: 'company name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: aboutMeController,
                decoration: InputDecoration(
                  labelText: 'Region',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: aboutMeController,
                decoration: InputDecoration(
                  labelText: 'city',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: aboutMeController,
                decoration: InputDecoration(
                  labelText: 'Start date',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: aboutMeController,
                decoration: InputDecoration(
                  labelText: 'End date',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Save'),
          onPressed: () {
            String updatedAboutMe = aboutMeController.text;
            try {
              updateField(updatedAboutMe);
              Utils.showSnackBar('Sucessfuly Updated', Colors.green);
            } catch (e) {
              Utils.showSnackBar(e.toString(), Colors.red);
            }

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class UpdateEducationDialog extends StatefulWidget {
  @override
  _UpdateEducationDialogState createState() => _UpdateEducationDialogState();
}

class _UpdateEducationDialogState extends State<UpdateEducationDialog> {
  String getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }

  void updateField(String experienceAdded) async {
    try {
      await FirebaseFirestore.instance
          .collection('job-seeker')
          .doc(getCurrentUserUid())
          .collection('jobseeker-profile')
          .doc('profile')
          .set({
        'experiences.${DateTime.now().millisecondsSinceEpoch.toString()}':
            '${experienceAdded}'
      });
      print('Field updated successfully.');
    } catch (e) {
      print('Error updating field: $e');
    }
  }

  final TextEditingController aboutMeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Education'),
      content: Container(
        height: MediaQuery.of(context).size.height / 3,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: aboutMeController,
                decoration: InputDecoration(
                  labelText: 'Highest Education Level',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: aboutMeController,
                decoration: InputDecoration(
                  labelText: 'college/University name ',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: aboutMeController,
                decoration: InputDecoration(
                  labelText: 'Field of study',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: aboutMeController,
                decoration: InputDecoration(
                  labelText: 'Start Date',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: aboutMeController,
                decoration: InputDecoration(
                  labelText: 'end Date',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: aboutMeController,
                decoration: InputDecoration(
                  labelText: 'Cumulative GPA',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Save'),
          onPressed: () {
            String updatedAboutMe = aboutMeController.text;
            try {
              updateField(updatedAboutMe);
              Utils.showSnackBar('Sucessfuly Updated', Colors.green);
            } catch (e) {
              Utils.showSnackBar(e.toString(), Colors.red);
            }

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}








// class _UpdateExperienceDialogState extends State<UpdateExperienceDialog> {
//   String formatTimestamp(Timestamp timestamp) {
//     DateTime dateTime = timestamp.toDate();

//     return DateFormat("yyyy-MM-dd").format(dateTime);
//   }

//   final _formKey = GlobalKey<FormState>();
//   String getCurrentUserUid() {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       return user.uid;
//     } else {
//       return '';
//     }
//   }

//   void updateField(Map<String, dynamic> experienceAdded) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('job-seeker')
//           .doc(getCurrentUserUid())
//           .collection('jobseeker-profile')
//           .doc('profile')
//           .set({'experiences.experience': '${experienceAdded}'});
//       print('Field updated successfully.');
//     } catch (e) {
//       print('Error updating field: $e');
//     }
//   }

//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController compName = TextEditingController();
//   final TextEditingController regionController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController start = TextEditingController();
//   final TextEditingController end = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     String startDate = formatTimestamp(widget.Experience?['startDte']);
//     String endDate = formatTimestamp(widget.Experience?['End date']);

//     return AlertDialog(
//       title: Text('Add experience'),
//       content: Container(
//         height: MediaQuery.of(context).size.height / 3,
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 TextFormField(
//                   controller: titleController
//                     ..text = widget.Experience?['job title'],
//                   decoration: InputDecoration(
//                     labelText: 'Job title',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 TextFormField(
//                   controller: compName..text = widget.Experience?['company'],
//                   decoration: InputDecoration(
//                     labelText: 'company name',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 TextFormField(
//                   controller: regionController
//                     ..text = widget.Experience?['Region'],
//                   decoration: InputDecoration(
//                     labelText: 'Region',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 TextFormField(
//                   controller: cityController..text = widget.Experience?['city'],
//                   decoration: InputDecoration(
//                     labelText: 'city',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 TextFormField(
//                   controller: start..text = startDate,
//                   decoration: InputDecoration(
//                     labelText: 'Start date',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 TextFormField(
//                   controller: end..text = endDate,
//                   decoration: InputDecoration(
//                     labelText: 'End date',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       actions: [
//         TextButton(
//           child: Text('Cancel'),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         TextButton(
//           child: Text('Save'),
//           onPressed: () {
//             // if (_formKey.currentState!.validate()) {
//             //   _formKey.currentState?.save();
//             //   ExperienceModel experienceData = ExperienceModel(
//             //       title: titleController.text,
//             //       company: compName.text,
//             //       startDate: DateTime.now(),
//             //       endDate: widget.Experience?['End date'],
//             //       region: regionController.text,
//             //       city: cityController.text);
//             //   try {
//             //     updateField(experienceData.toJson());
//             //     Utils.showSnackBar('Sucessfuly Updated', Colors.green);
//             //   } catch (e) {
//             //     Utils.showSnackBar(e.toString(), Colors.red);
//             //   }
//             // }
//             Navigator.of(context).pop();
//           },
//         ),
//       ],
//     );
//   }
// }
























/////////////////////////////////////////
///////////////////////////////////////////
//////////////////////////////////////////
///
///
///
//import 'dart:html';

// import 'dart:convert';
// //import 'dart:html';
// //import 'dart:ui';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:intl/intl.dart';
// import 'package:project1/Employers/home_page/pdf.dart';
// import 'package:project1/Employers/home_page/tabs_screen.dart';
// import 'package:project1/jobSeekerModel/job_seeker_profile_model.dart';
// import 'package:project1/job_seeker_home_page/jobSeekerHome.dart';
// import 'package:project1/profile/updateProfile.dart';

// class ProfilePage extends StatefulWidget {
//   static const routeName = '/user_profile';
//   const ProfilePage({Key? key}) : super(key: key);

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   File? _image;
//   List<Map<String, dynamic>> profData = [];
//   // Stream<Education> fetchEducationDataStream(DocumentReference docRef) {
//   //   return docRef.snapshots().map((snapshot) =>
//   //       Education.fromMap(snapshot.data()! as Map<String, dynamic>));
//   // }

//   String getCurrentUserUid() {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       return user.uid;
//     } else {
//       return '';
//     }
//   }

//   Map<String, dynamic>? otherData;
//   Map<String, dynamic>? personalInfo;
//   Map<String, dynamic>? skills;
//   Map<String, dynamic>? professionalSkills;
//   Map<String, dynamic>? personalSkills;
//   Map<String, dynamic>? languageSkills;

//   // void _removeproffSkill(String skill, List prof_skill) {
//   //   DocumentReference profileDocument = FirebaseFirestore.instance
//   //       .collection('job-seeker')
//   //       .doc(getCurrentUserUid())
//   //       .collection('jobseeker-profile')
//   //       .doc('profile');

//   //   setState(() {
//   //     prof_skill.remove(skill);
//   //   });
//   //   profileDocument.update({'professional skills': prof_skill}).then((_) {
//   //     print('Value deleted successfully.');
//   //   });
//   // }

//   // void _removepersonalSkill(String skill, List pers_skill) {
//   //   setState(() {
//   //     pers_skill.remove(skill);
//   //   });
//   // }

//   // void _removelanguageSkill(String skill, List lang_skill) {
//   //   setState(() {
//   //     lang_skill.remove(skill);
//   //   });
//   // }

//   String formatTimestamp(Timestamp timestamp) {
//     DateTime dateTime = timestamp.toDate();

//     return DateFormat("yyyy-MM-dd").format(dateTime);
//   }

//   List<Map<String, dynamic>> dataList = [];

//   List<Map<String, dynamic>> education = [];
//   List<Map<String, dynamic>> skill = [];
//   List<Map<String, dynamic>> other = [];
//   List<Map<String, dynamic>> p_info = [];

//   List<dynamic> myData = [];

//   Stream<List<dynamic>> getProfiles() {
//     return FirebaseFirestore.instance
//         .collection('job-seeker')
//         .doc(getCurrentUserUid())
//         .collection('profile')
//         .snapshots()
//         .map((querySnapshot) => querySnapshot.docs
//             .map((doc) => Education.fromMap(doc.data()))
//             .toList());
//   }

//   List allSkills = ['ccnn', 'sdsdf', 'retryt', 'erwtyu', 'olkjkl', 'qwwqsqasw'];
//   @override
//   Widget build(BuildContext context) {
//     // print('education data is ${education}');
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('aaaaa'),
//       // ),
//       floatingActionButton: FloatingActionButton(
//           child: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.of(context).pop();
//           }),
//       body: SingleChildScrollView(
//         child: StreamBuilder(
//             stream: getCurrentUserUid() != null
//                 ? FirebaseFirestore.instance
//                     .collection('job-seeker')
//                     .doc(getCurrentUserUid())
//                     .collection('jobseeker-profile')
//                     .doc('profile')
//                     .snapshots()
//                 : null,
//             builder: (BuildContext context,
//                 AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
//                     snapshot) {
//               if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               } else if (snapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator();
//               } else if (!snapshot.hasData || !snapshot.data!.exists) {
//                 if (getCurrentUserUid() == null) {
//                   return Text('User is not logged in');
//                 } else {
//                   return Text('No data available');
//                 }
//               }
//               Map<String, dynamic>? otherData =
//                   snapshot.data!.data()?['other-data'] as Map<String, dynamic>?;
//               Map<String, dynamic>? personalInfo = snapshot.data!
//                   .data()?['personal-info'] as Map<String, dynamic>?;
//               Map<String, dynamic>? skills =
//                   snapshot.data!.data()?['skills'] as Map<String, dynamic>?;
//               final List<dynamic> languageSkills =
//                   snapshot.data!.data()?['skills']['language skills'] ?? [];
//               final List<dynamic> personalSkills =
//                   snapshot.data!.data()?['skills']['personal skills'] ?? [];
//               final List<dynamic> professionalSkills =
//                   snapshot.data!.data()?['skills']['professional skills'] ?? [];
//               Map<String, dynamic>? experience =
//                   snapshot.data!.data()?['experiences']['experience']
//                       as Map<String, dynamic>?;
//               Map<String, dynamic>? education =
//                   snapshot.data!.data()?['education'] as Map<String, dynamic>?;

//               String startDate = formatTimestamp(experience?['startDte']);
//               String finalDate = formatTimestamp(experience?['End date']);

//               // print(otherData);
//               // String formattedDate = DateFormat('yyyy-MM-dd-kk:mm')
//               //     .format(experience?['End date']);
//               return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
//                     SizedBox(
//                       height: 50,
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 10),
//                           child: CircleAvatar(
//                             backgroundImage: NetworkImage(
//                                 otherData?['profile image'] ??
//                                     'assets/images/post2.jpeg'),
//                             radius: 50,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 10),
//                       child: Text(
//                         '  ${personalInfo?['first name']} ${personalInfo?['last name']}',
//                         style: TextStyle(
//                             fontSize: 30, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 4),
//                           child: Text('${education?['institution']}'),
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         IconButton(
//                             onPressed: () {},
//                             icon: Icon(
//                               Icons.edit,
//                               color: Colors.grey,
//                             ))
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 4),
//                           child: Text(
//                               '${education?['levelOfEducation']} in ${education?['fieldOfStudy']}'),
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         IconButton(
//                             onPressed: () {},
//                             icon: Icon(
//                               Icons.edit,
//                               color: Colors.grey,
//                             ))
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         TextButton(onPressed: () {}, child: Text('Edit')),
//                         //  DownloadCv(),
//                       ],
//                     ),
//                     // Container(
//                     //   height: 300,
//                     //   width: 350,
//                     // decoration:
//                     //     BoxDecoration(border: Border.all(color: Colors.blueAccent)),
//                     //  child:

//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: 20),
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[200],
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'About me',
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               IconButton(
//                                   onPressed: () {
//                                     showDialog(
//                                       context: context,
//                                       builder: (BuildContext context) =>
//                                           UpdateAboutMeDialog(),
//                                     );
//                                   },
//                                   icon: Icon(
//                                     Icons.edit,
//                                     color: Colors.grey,
//                                   ))
//                             ],
//                           ),
//                           Text(
//                             otherData?['about me'],
//                             style: TextStyle(fontSize: 17),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Center(
//                       child: Text(
//                         'Skills',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 25),
//                       ),
//                     ),

//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: 15),
//                       child: Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15.0),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 10),
//                           child: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(
//                                       'professional skills',
//                                       style: TextStyle(
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                   Row(
//                                     children: [
//                                       Text('Add'),
//                                       IconButton(
//                                         onPressed: () {
//                                           showDialog(
//                                               context: context,
//                                               builder: (BuildContext context) =>
//                                                   UpdateSkillsDialog(
//                                                       skill_Type:
//                                                           'professional skills'));
//                                         },
//                                         icon: Icon(
//                                           Icons.add,
//                                           color: Colors.amber,
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               Wrap(
//                                 spacing: 8.0,
//                                 runSpacing: 4.0,
//                                 children: [
//                                   ...professionalSkills.map(
//                                     (skill) => Chip(
//                                       labelStyle:
//                                           TextStyle(color: Colors.white),
//                                       backgroundColor:
//                                           Color.fromARGB(255, 22, 125, 209),
//                                       deleteIconColor: Colors.yellow,
//                                       label: Text(skill),
//                                       onDeleted: () {
//                                         // _removeproffSkill(
//                                         //     skill, professionalSkills);
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),

//                     Column(
//                       children: [
//                         Container(
//                           margin: EdgeInsets.symmetric(horizontal: 15),
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15.0),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 15, vertical: 10),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(
//                                           'Personal skills',
//                                           style: TextStyle(
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                       Row(
//                                         children: [
//                                           Text('Add'),
//                                           IconButton(
//                                             onPressed: () {
//                                               showDialog(
//                                                   context: context,
//                                                   builder: (BuildContext
//                                                           context) =>
//                                                       UpdateSkillsDialog(
//                                                           skill_Type:
//                                                               'personal skills'));
//                                             },
//                                             icon: Icon(
//                                               Icons.add,
//                                               color: Colors.amber,
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   Wrap(
//                                     spacing: 8.0,
//                                     runSpacing: 4.0,
//                                     children: [
//                                       ...personalSkills.map(
//                                         (skill) => Chip(
//                                           deleteIconColor: Colors.red,
//                                           label: Text(skill),
//                                           onDeleted: () {
//                                             // _removepersonalSkill(
//                                             //     skill, personalSkills);
//                                           },
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),

//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: 15),
//                       // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                       child: Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15.0),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 15, vertical: 10),
//                           child: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(
//                                       'Language skills',
//                                       style: TextStyle(
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                   GestureDetector(
//                                     child: Row(
//                                       children: [
//                                         Text('Add'),
//                                         IconButton(
//                                           onPressed: () {
//                                             showDialog(
//                                                 context: context,
//                                                 builder: (BuildContext
//                                                         context) =>
//                                                     UpdateSkillsDialog(
//                                                         skill_Type:
//                                                             'language skills'));
//                                           },
//                                           icon: Icon(
//                                             Icons.add,
//                                             color: Colors.amber,
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Wrap(
//                                 spacing: 8.0,
//                                 runSpacing: 4.0,
//                                 children: [
//                                   ...languageSkills.map(
//                                     (skill) => Chip(
//                                       backgroundColor:
//                                           Color.fromARGB(255, 48, 214, 226),
//                                       deleteIconColor: Colors.red,
//                                       label: Text(skill),
//                                       onDeleted: () {
//                                         // _removelanguageSkill(
//                                         //     skill, languageSkills);
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),

//                     SizedBox(height: 20),
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: 20),
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[200],
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Experience',
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               IconButton(
//                                   onPressed: () {
//                                     showDialog(
//                                         context: context,
//                                         builder: (BuildContext context) =>
//                                             UpdateExperienceDialog(
//                                               Experience: experience,
//                                             ));
//                                   },
//                                   icon: Icon(Icons.add))
//                             ],
//                           ),
//                           SizedBox(height: 10),
//                           ListTile(
//                             // leading: CircleAvatar(
//                             //   backgroundImage: AssetImage('assets/images/logo1.jpg'),
//                             // ),
//                             title: Text(experience?['job title']),
//                             subtitle: Text(
//                                 '${experience?['company']},${startDate} - ${startDate}'),
//                             trailing: IconButton(
//                                 onPressed: () {
//                                   showDialog(
//                                       context: context,
//                                       builder: (BuildContext context) =>
//                                           UpdateExperienceDialog(
//                                             Experience: experience,
//                                           ));
//                                 },
//                                 icon: Icon(Icons.edit)),
//                           ),
//                           Divider(),
//                           ListTile(
//                             // leading: CircleAvatar(
//                             //   backgroundImage:
//                             //       AssetImage('assets/images/logo2.jpg'),
//                             // ),
//                             title: Text('Front-end Developer'),
//                             subtitle: Text('XYZ Inc., Sep 2018 - Dec 2019'),
//                             trailing: Icon(Icons.edit),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: 20),
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[200],
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'Education',
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Row(
//                                 children: [
//                                   IconButton(
//                                       onPressed: () {
//                                         showDialog(
//                                             context: context,
//                                             builder: (BuildContext context) =>
//                                                 UpdateEducationDialog());
//                                       },
//                                       icon: Icon(Icons.edit)),
//                                   IconButton(
//                                       onPressed: () {
//                                         showDialog(
//                                             context: context,
//                                             builder: (BuildContext context) =>
//                                                 UpdateEducationDialog());
//                                       },
//                                       icon: Icon(Icons.add)),
//                                 ],
//                               )
//                             ],
//                           ),
//                           SizedBox(height: 10),
//                           ListTile(
//                             // leading: CircleAvatar(
//                             //   backgroundImage:
//                             //       AssetImage('assets/images/university_logo.jpg'),
//                             // ),
//                             title: Text(
//                                 'Bachelor in ${education?['fieldOfStudy']} '),
//                             subtitle:
//                                 Text('University of ABC, Sep 2014 - May 2018'),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                   ]);
//             }),
//       ),
//     );
//   }
// }
