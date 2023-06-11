import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project1/Employers/models/jobs_model.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

// {'page': EmpHomePage(), 'title': Text('home')},
//   {'page': Posted_jobs(), 'title': Text('jobs posted')},
//   {'page': candidates(), 'title': Text('candidates')},
//   {'page': EmpNotification(), 'title': Text('Notification')}

class EmpNotification extends StatefulWidget {
  static const routeName = 'EmpNotification';
  @override
  _EmpNotificationState createState() => _EmpNotificationState();
}

class _EmpNotificationState extends State<EmpNotification> {
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
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      body: StreamBuilder<QuerySnapshot>(
        stream:
            //FirebaseFirestore.instance
            // .collection('employer')
            // .doc(getCurrentUserUid())
            // .collection('job posting')
            // .snapshots(),
            FirebaseFirestore.instance
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
                          onTap: () {
                            // Navigator.pushNamed(
                            //     context, JobDetailPage.routName,
                            //     arguments: document);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => JobDetailPage(
                            //             index: index,
                            //             job: document,
                            //           ), //pass any arguments
                            //       settings:
                            //           RouteSettings(name: "vendorScreen")),
                            // );
                          },
                          child: Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              style: ListTileStyle.drawer,
                              leading: CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                              //  leading: new Text(document['job category']),
                              title: new Text('document'),
                              subtitle: new Text(document['content']),
                              // trailing: IconButton(
                              //     onPressed: () {
                              //       deleteFavorite(document['id']);
                              //     },
                              //     icon: Icon(
                              //       Icons.delete,
                              //       color: Colors.red,
                              //     )),
                            ),
                          ),
                        );
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
