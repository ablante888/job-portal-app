//import 'dart:html';

import 'dart:convert';
//import 'dart:html';
//import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project1/Employers/home_page/tabs_screen.dart';
import 'package:project1/jobSeekerModel/job_seeker_profile_model.dart';
import 'package:project1/job_seeker_home_page/jobSeekerHome.dart';

class ProfilePageView extends StatefulWidget {
  static const routeName = '/user_profile';
  final String id;
  const ProfilePageView({Key? key, required this.id}) : super(key: key);

  @override
  State<ProfilePageView> createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> {
  File? _image;
  List<Map<String, dynamic>> profData = [];
  // Stream<Education> fetchEducationDataStream(DocumentReference docRef) {
  //   return docRef.snapshots().map((snapshot) =>
  //       Education.fromMap(snapshot.data()! as Map<String, dynamic>));
  // }

  String getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }

  List<Map<String, dynamic>> dataList = [];

  Future<void> getData() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('job-seeker')
            .doc(getCurrentUserUid())
            .collection('profile')
            .get();
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
        querySnapshot.docs;
    final Map<String, Map<String, dynamic>> dataMap = {};
    for (final QueryDocumentSnapshot<Map<String, dynamic>> doc in docs) {
      final String docId = doc.id;
      final Education educationObject;
      final Skill skillObject;
      final PersonalInfo personalInfo_object;
      final Other otherObject;
      final Map<String, dynamic> docData = doc.data();
      if (docId == 'Education') {
        education.add(docData);
        educationObject = Education.fromMap(docData);
        print('this is education object ${educationObject.institution}');
      } else if (docId == 'skills') {
        skill.add(doc.data());

        skillObject = Skill.fromMap(docData);
        print('this is education object ${skillObject.languageSkills}');
      } else if (docId == 'other') {
        other.add(doc.data());
        otherObject = Other.fromMap(docData);
      } else if (docId == 'personal_info') {
        p_info.add(doc.data());
        personalInfo_object = PersonalInfo.fromJeson(docData);

        print('this is education object ${personalInfo_object.city}');
      }

      print('doc data is : ${education}');
      print('doc data is : ${other}');
      print('doc data is : ${p_info}');
      print('doc data is : ${skill}');

      print('$docId=>$docData');
      dataMap[docId] = docData;
      // docData.map((key, value) => null)
    }
    // Education ed=education.
  }

  List<Map<String, dynamic>> education = [];
  List<Map<String, dynamic>> skill = [];
  List<Map<String, dynamic>> other = [];
  List<Map<String, dynamic>> p_info = [];

  List<dynamic> myData = [];
  Stream<List<dynamic>> getDataStream() {
    return FirebaseFirestore.instance
        .collection('job-seeker')
        .doc(getCurrentUserUid())
        .collection('profile')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) {
              final data = doc.data();
              switch (doc.id) {
                case 'Education':
                  return Education.fromMap(data);
                //myData[0] = Education.fromMap(data);

                case 'Experience':
                  return ExperienceModel.fromMap(data);
                case 'Skills':
                  return Skill.fromMap(data);
                // add more cases as needed for other components
                default:
                  return null;
              }
            })
            .where((component) => component != null)
            .toList());
  }

  Stream<List<dynamic>> getProfiles() {
    return FirebaseFirestore.instance
        .collection('job-seeker')
        .doc(getCurrentUserUid())
        .collection('profile')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => Education.fromMap(doc.data()))
            .toList());
  }

  // final docRef = FirebaseFirestore.instance
  //     .collection('job_seeker')
  //     .doc(getCurrentUserUid())
  //     .collection('profile')
  //     .doc('Education');
//: if
  //    request.auth != null
  List allSkills = ['ccnn', 'sdsdf', 'retryt', 'erwtyu', 'olkjkl', 'qwwqsqasw'];
  @override
  Widget build(BuildContext context) {
    getData();
    // print('education data is ${education}');
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('aaaaa'),
      // ),

      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('job-seeker')
                .doc(widget.id)
                .collection('jobseeker-profile')
                .doc('profile')
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                    snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (!snapshot.hasData || !snapshot.data!.exists) {
                return Text('No data available');
              }
              Map<String, dynamic>? otherData =
                  snapshot.data!.data()?['other-data'] as Map<String, dynamic>?;
              // print(otherData);
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              otherData?['profile image'] ??
                                  'assets/images/post2.jpeg'),
                          radius: 50,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Ablante daniel',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text('software engineer'),
                    Text('institution'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(onPressed: () {}, child: Text('Edit')),
                        TextButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.download),
                            label: Text('Download CV')),
                      ],
                    ),
                    // Container(
                    //   height: 300,
                    //   width: 350,
                    // decoration:
                    //     BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                    //  child:

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'About me',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.edit))
                            ],
                          ),
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Text(
                        'Skills',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'professional skills',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text('Add'),
                                      Icon(
                                        Icons.add,
                                        color: Colors.amber,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Wrap(
                                spacing: 8.0,
                                runSpacing: 4.0,
                                children: [
                                  ...allSkills.map(
                                    (skill) => Chip(
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                      backgroundColor:
                                          Color.fromARGB(255, 22, 125, 209),
                                      deleteIconColor: Colors.yellow,
                                      label: Text(skill),
                                      onDeleted: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Personal skills',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text('Add'),
                                          Icon(
                                            Icons.add,
                                            color: Colors.amber,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Wrap(
                                    spacing: 8.0,
                                    runSpacing: 4.0,
                                    children: [
                                      ...allSkills.map(
                                        (skill) => Chip(
                                          deleteIconColor: Colors.red,
                                          label: Text(skill),
                                          onDeleted: () {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Language skills',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  GestureDetector(
                                    child: Row(
                                      children: [
                                        Text('Add'),
                                        Icon(
                                          Icons.add,
                                          color: Colors.amber,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Wrap(
                                spacing: 8.0,
                                runSpacing: 4.0,
                                children: [
                                  ...allSkills.map(
                                    (skill) => Chip(
                                      backgroundColor:
                                          Color.fromARGB(255, 48, 214, 226),
                                      deleteIconColor: Colors.red,
                                      label: Text(skill),
                                      onDeleted: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Experience',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.add))
                            ],
                          ),
                          SizedBox(height: 10),
                          ListTile(
                            // leading: CircleAvatar(
                            //   backgroundImage: AssetImage('assets/images/logo1.jpg'),
                            // ),
                            title: Text('Web Developer'),
                            subtitle: Text('ABC Company, Jan 2020 - Present'),
                            trailing: Icon(Icons.edit),
                          ),
                          Divider(),
                          ListTile(
                            // leading: CircleAvatar(
                            //   backgroundImage:
                            //       AssetImage('assets/images/logo2.jpg'),
                            // ),
                            title: Text('Front-end Developer'),
                            subtitle: Text('XYZ Inc., Sep 2018 - Dec 2019'),
                            trailing: Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Education',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.edit))
                            ],
                          ),
                          SizedBox(height: 10),
                          ListTile(
                            // leading: CircleAvatar(
                            //   backgroundImage:
                            //       AssetImage('assets/images/university_logo.jpg'),
                            // ),
                            title:
                                Text('Bachelor of Science in Computer Science'),
                            subtitle:
                                Text('University of ABC, Sep 2014 - May 2018'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ]);
            }),
      ),
    );
  }
}
