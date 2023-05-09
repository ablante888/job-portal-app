//import 'dart:html';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project1/jobSeekerModel/job_seeker_profile_model.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/user_profile';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? uid;
  String getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
      return user.uid;
    } else {
      return '';
    }
  }

  Stream<QuerySnapshot> readProfile() {
    FirebaseFirestore _db = FirebaseFirestore.instance;
    Stream<QuerySnapshot> JobSeekerProfileStream = _db
        .collection('job-seeker')
        .doc(getCurrentUserUid())
        .collection('profie')
        .snapshots();
    return JobSeekerProfileStream;
  }

  // final FirebaseFirestore _db = FirebaseFirestore.instance;
  // Stream<QuerySnapshot> JobSeekerProfileStream =
  //     _db.collection('job-seeker').doc().collection('profie').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: readProfile(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading...');
            }
            final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
            final List<JobSeekerProfile> jobSeekerProfiles = documents
                .map((doc) => JobSeekerProfile.fromMap(
                    doc.data() as Map<String, dynamic>))
                .toList();
            return Column();
          }),
    );
  }
}
// class ProfilePage extends StatefulWidget {
//   static const routeName = '/user_profile';
//   const ProfilePage({Key? key}) : super(key: key);

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
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

//   // Stream<List<dynamic>> fetchProfileDataStream(CollectionReference colRef) {
//   //   return colRef.snapshots().map((snapshot) {
//   //     return snapshot.docs.map((doc) {
//   //       if (doc.id == 'Education') {
//   //         return Education.fromMap(doc.data()! as Map<String, dynamic>);
//   //       } else if (doc.id == 'Experience') {
//   //         return ExperienceModel.fromMap(doc.data()! as Map<String, dynamic>);
//   //       }
//   //       // Add more if-else statements for other document types.
//   //       return null;
//   //     }).toList();
//   //   });
//   // }

//   List<Map<String, dynamic>> dataList = [];
//   Future<void> getData() async {
//     final QuerySnapshot<Map<String, dynamic>> querySnapshot =
//         await FirebaseFirestore.instance
//             .collection('job-seeker')
//             .doc(getCurrentUserUid())
//             .collection('profile')
//             .get();
//     final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
//         querySnapshot.docs;
//     for (final DocumentSnapshot<Map<String, dynamic>> doc in docs) {
//       print('${doc.id}=>${doc.data()}');
//       // List<Map<String, dynamic>> dataList = [];
//       docs.forEach((doc) {
//         dataList.add(doc.data());
//         print('${dataList[0]['summary']}');
//         // if (doc.id.compareTo('Education') == 0) {
//         //   final EducationObject = Education.fromMap(doc);
//         //   print('your GPA is ${EducationObject.GPA}');

//         // else if (doc.id.compareTo('Experience') == 0) {
//         //   final ExperienceObject = ExperienceModel.fromMap(doc);
//         //   print('your GPA is ${ExperienceObject.GPA}');
//         // }
//       });
//     }
//   }

//   List<dynamic> myData = [];
//   Stream<List<dynamic>> getDataStream() {
//     return FirebaseFirestore.instance
//         .collection('job-seeker')
//         .doc(getCurrentUserUid())
//         .collection('profile')
//         .snapshots()
//         .map((querySnapshot) => querySnapshot.docs
//             .map((doc) {
//               final data = doc.data();
//               switch (doc.id) {
//                 case 'Education':
//                   return Education.fromMap(data);
//                 //myData[0] = Education.fromMap(data);

//                 case 'Experience':
//                   return ExperienceModel.fromMap(data);
//                 case 'Skills':
//                   return Skill.fromMap(data);
//                 // add more cases as needed for other components
//                 default:
//                   return null;
//               }
//             })
//             .where((component) => component != null)
//             .toList());
//   }

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

//   // final docRef = FirebaseFirestore.instance
//   //     .collection('job_seeker')
//   //     .doc(getCurrentUserUid())
//   //     .collection('profile')
//   //     .doc('Education');
// //: if
//   //    request.auth != null
//   @override
//   Widget build(BuildContext context) {
//     getData();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('${dataList[0]['summary']}'),
//       ),
//       body: StreamBuilder(
//         stream: getDataStream(),
//         builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           }

//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           }

//           var data = snapshot.data as Education;

//           return ListView(
//             children: <Widget>[
//               ListTile(
//                 title: Text('Degree'),
//                 subtitle: Text(data.institution.toString()),
//               ),
//               ListTile(
//                 title: Text('University'),
//                 subtitle: Text(data.fieldOfStudy.toString()),
//               ),
//               // Add more list tiles as needed.
//             ],
//           );
//         },
//       ),
//     );
//   }
// }


















// //import 'dart:html';

// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:project1/models/job_seeker_profile_model.dart';

// class ProfilePage extends StatefulWidget {
//   static const routeName = '/user_profile';
//   const ProfilePage({Key? key}) : super(key: key);

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   String getCurrentUserUid() {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       return user.uid;
//     } else {
//       return '';
//     }
//   }

//   Future<Map<String, dynamic>> fetchEducationData(
//       DocumentReference docRef) async {
//     final snapshot = await docRef.get();

//     if (snapshot.exists) {
//       return snapshot.data() as Map<String, dynamic>;
//     } else {
//       throw Exception('Document does not exist on the database');
//     }
//   }
//   // String? userId; // declare a nullable String variable

//   // void listenToAuthChanges() {
//   //   FirebaseAuth.instance.authStateChanges().listen((User? user) {
//   //     if (user != null) {
//   //       userId = user.uid;
//   //     } else {
//   //       userId = null;
//   //     }
//   //   });
//   // }

//   // Future read() async {
//   //   final doc_ref = FirebaseFirestore.instance
//   //       .collection('job_seeker')
//   //       .doc(getCurrentUserUid())
//   //       .collection('profile')
//   //       .doc('Education');
//   //   final snapshot = await doc_ref.get();
//   //   doc_ref.get().then(
//   //     (DocumentSnapshot doc) {
//   //       final data = doc.data() as Map<String, dynamic>;
//   //       final city = Education.fromMap(data);
//   //       print(city.institution);
//   //       // ...
//   //     },
//   //     onError: (e) => print("Error getting document: $e"),
//   //   );
//   // }

//   Future<Education> read_profile() async {
//     final doc_ref = FirebaseFirestore.instance
//         .collection('job_seeker')
//         .doc(getCurrentUserUid())
//         .collection('profile')
//         .doc('Education');

//     final snapshot = await doc_ref.get();

//     if (snapshot.exists) {
//       return Education.fromMap(snapshot.data()!);
//     } else
//       return Education(
//           levelOfEducation: 'null',
//           institution: 'null',
//           fieldOfStudy: 'null',
//           startDate: 'null',
//           endDate: 'null');
//     Education city;
//     doc_ref.get().then(
//       (DocumentSnapshot doc) {
//         final data = doc.data() as Map<String, dynamic>;
//         city = Education.fromMap(data);
//         print(city.institution);
//         // ...
//       },
//       onError: (e) => print("Error getting document: $e"),
//     );
//     // if(ci)
//     // return city;
//   }

//   // Education ed = new Education(
//   //     levelOfEducation: 'levelOfEducation',
//   //     institution: 'institution',
//   //     fieldOfStudy: 'fieldOfStudy',
//   //     startDate: 'startDate',
//   //     endDate: 'endDate');
//   // String bb = ed.institution;
//   Future getEducation() async {
//     List items = [];
//     final doc_ref = FirebaseFirestore.instance
//         .collection('job_seeker')
//         .doc(getCurrentUserUid())
//         .collection('profile');
//     try {
//       await doc_ref
//           .get()
//           .then((QuerySnapshot) => QuerySnapshot.docs.forEach((element) {
//                 items.add(element.id);
//               }));
//                print(items[0]);
//     } catch (e) {}
//     print(items[0]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('profile'),
//       ),
//       floatingActionButton:
//           FloatingActionButton(child: Icon(Icons.arrow_back), onPressed: () {}),
//       // body: FutureBuilder<Map<String, dynamic>>(
//       //     future: fetchEducationData(FirebaseFirestore.instance
//       //         .collection('job_seeker')
//       //         .doc(getCurrentUserUid())
//       //         .collection('profile')
//       //         .doc('Education')),
//       //     builder: (context, snapshot) {
//       //       if (snapshot.hasData) {
//       //         final education = snapshot.data;
//       //         return Column(
//       //           children: [
//       //             CircleAvatar(
//       //               backgroundImage: AssetImage('assets/images/profile2.jpeg'),
//       //               radius: 50,
//       //             ),
//       //             Text(
//       //               'Ablante daniel',
//       //               style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//       //             ),
//       //             Text('software engineer'),
//       //             Text('${education?['institution']}'),
//       //             Row(
//       //               children: [
//       //                 TextButton(onPressed: () {}, child: Text('Edit')),
//       //                 TextButton.icon(
//       //                     onPressed: () {},
//       //                     icon: Icon(Icons.upload),
//       //                     label: Text('Upload CV'))
//       //               ],
//       //             ),
//       //           ],
//       //         );
//       //       } else
//       //         return Container(
//       //           child: Center(
//       //             child: Text('OOOPS have no data  !!'),
//       //           ),
//       //         );
//       //     }),
//       body: Container(
//         height: 400,
//         width: 300,
//         child: TextButton(onPressed: getEducation, child: Text('read')),
//       ),
//     );
//   }
// }


