import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project1/Employers/models/jobs_model.dart';
import 'package:project1/user_account/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../jobSeekerModel/job_seeker_profile_model.dart';

class Job_detail extends StatefulWidget {
  int index;
  DocumentSnapshot<Object?> job;
  DocumentSnapshot<Object?> get Job => Job;
  Job_detail({Key? key, required this.index, required this.job})
      : super(key: key);

  @override
  State<Job_detail> createState() => _Job_detailState();
}

class _Job_detailState extends State<Job_detail> {
  bool favorite = false;
  void favoriteClicked(DocumentSnapshot<Object?> job) {
    setState(() {
      favorite = !favorite;
    });
    if (favorite) {
      addToFavorites(job); // Add the job to favorites list in Firebase
    } else {
      FirebaseFirestore.instance
          .collection('job-seeker')
          .doc(getCurrentUserUid())
          .collection('favorite-jobs')
          .doc(job['job id'])
          .delete();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  Future<void> _loadState() async {
    final state = await StatePersistence.getState('favoriteState');
    setState(() {
      favorite = state as bool;
    });
  }

  Future<void> _saveState() async {
    await StatePersistence.saveState('favoriteState', favorite);
  }

  String randomText =
      '   Porttitor eget dolor morbi non arcu risus. Eget arcu dictum varius duis at consectetur lorem. Velit sed ullamcorper morbi tincidunt ornare massa. At volutpat diam ut venenatis tellus. Tortor at auctor urna nunc id cursus metus aliquam eleifend. Amet commodo nulla facilisi nullam vehicula ipsum a. Vitae nunc sed velit dignissim sodales ut eu. Facilisis leo vel fringilla est ullamcorper. Faucibus scelerisque eleifend donec pretium vulputate sapien nec sagittis. Tempus egestas sed sed risus pretium quam vulputate dignissim suspendisse. Arcu non odio euismod lacinia at quis risus. Ante metus dictum at tempor commodo ullamcorper a lacus vestibulum. Ut placerat orci nulla pellentesque dignissim. Sed nisi lacus sed viverra tellus in. Posuere morbi leo urna molestie at elementum eu. Nibh sit amet commodo nulla facilisi nullam vehicula ipsum a. Non nisi est sit amet facilisis magna etiam tempor orci. Posuere sollicitudin aliquam ultrices sagittis orci a scelerisque purus semper. Mauris in aliquam sem fringilla ut morbi. Vitae nunc sed velit dignissim sodales ut eu. Dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Urna molestie at elementum eu facilisis sed odio morbi quis. Odio ut sem nulla pharetra diam. Nam libero justo laoreet sit amet. Mauris in aliquam sem fringilla ut morbi. Massa tincidunt nunc pulvinar sapien et. A lacus vestibulum sed arcu non odio euismod lacinia. Maecenas volutpat blandit aliquam etiam. Nunc sed id semper risus. Vel pharetra vel turpis nunc eget lorem dolor. Tellus rutrum tellus pellentesque eu tincidunt. Cum sociis natoque penatibus et. Sapien nec sagittis aliquam malesuada bibendum. Nulla posuere sollicitudin aliquam ultrices sagittis orci a. Massa vitae tortor condimentum lacinia quis. Odio tempor orci dapibus ultrices in iaculis nunc. Eu augue ut lectus arcu bibendum. Eu consequat ac felis donec et odio. Auctor neque vitae tempus quam pellentesque nec nam. Venenatis lectus magna fringilla urna porttitor rhoncus dolor purus. Lorem ipsum dolor sit amet consectetur adipiscing. Justo eget magna fermentum iaculis eu non diam phasellus vestibulum. Egestas integer eget aliquet nibh. Est ullamcorper eget nulla facilisi etiam dignissim. Feugiat in ante metus dictum.';
  String getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }

  String? applicantId;
  void createJobId() {
    var uuid = Uuid();
    applicantId = uuid.v4();
  }

  void addToFavorites(DocumentSnapshot<Object?> doc) {
    Map<String, dynamic> jobData = doc.data() as Map<String, dynamic>;
    //  JobPost job_post = JobPost.fromJson(jobData);
    //print(job_post.deadline);
    final DocumentReference favoritesCollection = FirebaseFirestore.instance
        .collection('job-seeker')
        .doc(getCurrentUserUid())
        .collection('favorite-jobs')
        .doc(doc['job id']);
    favoritesCollection.set({
      'title': doc['title'],
      'jobTitle': doc['description'],
      'salary': doc['salary'],
      'location': doc['location'],
      'company': doc['company'],
      'employment type': doc['employment type'],
      'education level': doc['education level'],
      'job category': doc['job category'],
      // 'posted time': doc['posted time'],
      'id': doc['job id'],
      'requirements': doc['requirements'],
      'experience leve': doc['experience level'],
      // Add other job details as needed
    });
  }

// ).then((docRef) {
//
//       print('Job added to favorites: ${docRef.id}');
//     }).catchError((error) {
//       // Error occurred while adding the document
//       print('Failed to add job to favorites: $error');
//     }
// Inside the _Job_detailState class
  bool isButtonDisabled = false;

  void _handleApplyButtonTap(DocumentSnapshot<Object?> doc) {
    if (!isButtonDisabled) {
      saveApplication(doc);

      setState(() {
        isButtonDisabled = true;
      });
    } else {
      // Button already disabled, handle accordingly
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('you alredy applied.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void saveApplication(DocumentSnapshot<Object?> doc) {
    final DocumentReference applicationDocumentReference = FirebaseFirestore
        .instance
        .collection('job-seeker')
        .doc(getCurrentUserUid())
        .collection('jobs-applied')
        .doc(doc['job id']);
    try {
      applicationDocumentReference.set({
        'title': doc['title'],
        'jobTitle': doc['description'],
        'salary': doc['salary'],
        'location': doc['location'],
        'company': doc['company'],
        'employment type': doc['employment type'],
        'education level': doc['education level'],
        'job category': doc['job category'],
        // 'posted time': doc['posted time'],
        'id': doc['job id'],
        'requirements': doc['requirements'],
        'experience leve': doc['experience level'],
        // Add other job details as needed
      });
      getData(doc);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Application Submitted'),
            content: Text('Your application has been submitted successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      Utils.showSnackBar(e.toString(), Colors.red);
    }
  }

  Future<void> getData(DocumentSnapshot<Object?> doc) async {
    // createJobId();
    // final CollectionReference applicantCollectionReference = FirebaseFirestore
    //     .instance
    //     .collection('employers-job-postings')
    //     .doc('post-id')
    //     .collection('job posting')
    //     .doc(doc['job id'])
    //     .collection("Applicants")
    //     .doc(applicantId)
    //     .collection('applicant profile');
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection('job-seeker')
            .doc(getCurrentUserUid())
            .collection('jobseeker-profile')
            .doc('profile')
            .get();
    final DocumentReference applicant_Collection_Reference =
        await FirebaseFirestore.instance
            .collection('employers-job-postings')
            .doc('post-id')
            .collection('job posting')
            .doc(doc['job id'])
            .collection("Applicants")
            .doc(getCurrentUserUid());
    applicant_Collection_Reference.set(documentSnapshot.data());
    // Education educationObject;
    // Skill skillObject;
    // PersonalInfo personalInfo_object;
    // Other otherObject;
    // final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
    //     querySnapshot.docs;
    // docs.first.id;
    // final Map<String, Map<String, dynamic>> dataMap = {};
    // for (final QueryDocumentSnapshot<Map<String, dynamic>> doc in docs) {
    //   final String docId = doc.id;

    //   final Map<String, dynamic> docData = doc.data();
    //   if (docId == 'Education') {
    //     education.add(docData);
    //     educationObject = Education.fromMap(docData);
    //     applicantCollectionReference.doc(docId).set(docData);
    //     print('this is education object ${educationObject.institution}');
    //   } else if (docId == 'skills') {
    //     skill.add(doc.data());

    //     skillObject = Skill.fromMap(docData);
    //     applicantCollectionReference.doc(docId).set(docData);
    //     print('this is education object ${skillObject.languageSkills}');
    //   } else if (docId == 'other') {
    //     other.add(doc.data());
    //     otherObject = Other.fromMap(docData);
    //     applicantCollectionReference.doc(docId).set(docData);
    //   } else if (docId == 'personal_info') {
    //     p_info.add(doc.data());
    //     personalInfo_object = PersonalInfo.fromJeson(docData);

    //     print('this is education object ${personalInfo_object.city}');
    //     applicantCollectionReference.doc(docId).set(docData);
    //   }

    //   print('doc data is : ${education}');
    //   print('doc data is : ${other}');
    //   print('doc data is : ${p_info}');
    //   print('doc data is : ${skill}');

    //   print('$docId=>$docData');
    //   dataMap[docId] = docData;
    //   // docData.map((key, value) => null)

    // }

    // String id = personalInfo_object.id;

    // Education ed=education.
  }

  List<Map<String, dynamic>> education = [];
  List<Map<String, dynamic>> skill = [];
  List<Map<String, dynamic>> other = [];
  List<Map<String, dynamic>> p_info = [];

  @override
  Widget build(BuildContext context) {
    print('this is the index of listile ${widget.index}');
    print(widget.job.data());

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Icon(Icons.location_city), Text('Ethipia Addiss Ababa')],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Text('Posted time'), Text('9 hours ago')],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Job type',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text('salary',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Text('Full time'), Text('5000ETB')],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(randomText),
        ),
        SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2 - 20,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(15)),
              child: TextButton(
                  onPressed: () {
                    _handleApplyButtonTap(widget.job);
                    style:
                    ElevatedButton.styleFrom(
                      onSurface: Colors.brown,
                    );
                  },
                  child: Text(
                    'Apply',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            Container(
              //width: MediaQuery.of(context).size.width / 2 - 20,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(15)),
              child: TextButton.icon(
                icon: Icon(
                  favorite ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: () {
                  favoriteClicked(widget.job);
                },

                // child: Text('Job descreption')
                label: Text(''),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  @override
  void dispose() {
    _saveState();
    super.dispose();
  }
}

class StatePersistence {
  static Future<bool> saveState(String key, dynamic value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is String) {
      return await prefs.setString(key, value);
    } else if (value is int) {
      return await prefs.setInt(key, value);
    } else if (value is double) {
      return await prefs.setDouble(key, value);
    } else if (value is bool) {
      return await prefs.setBool(key, value);
    } else {
      return false;
    }
  }

  static Future<dynamic> getState(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }
}
