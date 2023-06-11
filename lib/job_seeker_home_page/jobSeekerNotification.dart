import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project1/Employers/models/jobs_model.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class JobSeekerNotification extends StatefulWidget {
  static const routeName = 'JobSeekerNotification';
  @override
  _JobSeekerNotificationState createState() => _JobSeekerNotificationState();
}

class _JobSeekerNotificationState extends State<JobSeekerNotification> {
  String getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (getCurrentUserUid().isEmpty) {
      // User not logged in, show a placeholder widget
      return Center(
        child: Text('Please log in to view notifications.'),
      );
    }
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('job-seeker')
            .doc(getCurrentUserUid())
            .collection('messages')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              // Update the postedJobs list with document snapshots
              List<DocumentSnapshot> postedJobs = snapshot.data!.docs.toList();

              return SafeArea(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      itemCount: postedJobs.length,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot document = postedJobs[index];
                        return GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    bottomRight: Radius.circular(25)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4.0,
                                    offset: Offset(0.0, 2.0),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                title: Text(
                                  'ABC company',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.yellow),
                                ),
                                subtitle: Text(
                                  document['content'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ));
                      },
                    ),
                  ),
                ),
              );
          }
          ;
        },
      ),
    );
  }
}
