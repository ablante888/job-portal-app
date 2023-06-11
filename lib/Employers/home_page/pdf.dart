// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart' as pdfLib;
// import 'package:pdf/widgets.dart' as pdfWidgets;
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ProfilePageWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile Page'),
//       ),
//       body: FutureBuilder<DocumentSnapshot>(
//         future: fetchProfileData(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final profileSnapshot = snapshot.data!;
//             final name = profileSnapshot.data()['name'];
//             final email = profileSnapshot.data()['email'];
//             // Retrieve other profile data as needed
// // Map<String, dynamic>? otherData =
// //                   snapshot.data!.data()['other-data'] as Map<String, dynamic>?;

//     //               Map<String, dynamic>? otherData =
//     // snapshot.data!.data()['other-data'] as Map<String, dynamic>?;
// Map<String, dynamic>? otherData;

// if (snapshot.data != null) {
//   otherData = snapshot.data!.data()['other-data'] as Map<String, dynamic>?;
// }

//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Name: $name'),
//                 Text('Email: $email'),
//                 // Display other profile details here
//                 ElevatedButton(
//                   onPressed: downloadProfileAsPdf,
//                   child: Text('Download PDF'),
//                 ),
//               ],
//             );
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             return CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }

//   Future<DocumentSnapshot> fetchProfileData() async {
//     final snapshot = await FirebaseFirestore.instance
//         .collection('job-seeker')
//         .doc(getCurrentUserUid())
//         .collection('jobseeker-profile')
//         .doc('profile')
//         .get();
//     return snapshot;
//   }

//   Future<void> downloadProfileAsPdf() async {
//     final profileSnapshot = await fetchProfileData();
//     final pdf = await generatePdfDocument(profileSnapshot);

//     final output = await getTemporaryDirectory();
//     final file = File("${output.path}/profile.pdf");

//     await file.writeAsBytes(await pdf.save());
//   }

//   Future<pdfWidgets.Document> generatePdfDocument(
//       DocumentSnapshot profileSnapshot) async {
//     final pdf = pdfWidgets.Document();

//     // Retrieve the data from the snapshot
//     String name = profileSnapshot.data()['name'];
//     final email = profileSnapshot.data()['email'];
//     // Retrieve other profile data as needed

//     pdf.addPage(
//       pdfWidgets.Page(
//         build: (pdfWidgets.Context context) => pdfWidgets.Column(
//           children: [
//             pdfWidgets.Text(name),
//             pdfWidgets.Text(email),
//             // Add other profile details here
//           ],
//         ),
//       ),
//     );

//     return pdf;
//   }
// }

// // Helper function to get the current user UID
// String getCurrentUserUid() {
//   // Replace with your own logic to get the current user's UID
//   // Example: return FirebaseAuth.instance.currentUser.uid;
//   return 'user-uid';
// }

// void main() {
//   runApp(MaterialApp(
//     home: ProfilePageWidget(),
//   ));
// }
