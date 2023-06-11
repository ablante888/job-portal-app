import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project1/user_account/utils.dart';

import '../Employers/home_page/detail_page.dart';

class Applied_jobs_list extends StatefulWidget {
  static const routeName = '/Applied_jobs_list';
  const Applied_jobs_list({Key? key}) : super(key: key);

  @override
  State<Applied_jobs_list> createState() => _Applied_jobs_listState();
}

class _Applied_jobs_listState extends State<Applied_jobs_list> {
  String getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }

  void deleteApplication(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            'Alert',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure to delete.',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'Yes',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                try {
                  FirebaseFirestore.instance
                      .collection('job-seeker')
                      .doc(getCurrentUserUid())
                      .collection('jobs-applied')
                      .doc(id)
                      .delete();
                  FirebaseFirestore.instance
                      .collection('employers-job-postings')
                      .doc('post-id')
                      .collection('job posting')
                      .doc(id)
                      .delete();
                  Utils.showSnackBar(
                      'Your application deleted sucessfuly', Colors.blue);
                } on FirebaseException catch (e) {
                  Utils.showSnackBar(e.message, Colors.blue);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (getCurrentUserUid().isEmpty) {
      // User not logged in, show a placeholder widget
      return Center(
        child: Text('Please log in to save jobs.'),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Applied Jobs'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('job-seeker')
            .doc(getCurrentUserUid())
            .collection('jobs-applied')
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
                    height: MediaQuery.of(context).size.height - 100,
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => JobDetailPage(
                                          index: index,
                                          job: document,
                                        ), //pass any arguments
                                    settings:
                                        RouteSettings(name: "vendorScreen")),
                              );
                            },
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 10.0),
                                title: Row(
                                  children: [
                                    Icon(
                                      Icons.title,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      document['title'],
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                    // Text(
                                    //   document['jobTitle'],
                                    //   style: TextStyle(fontSize: 16.0),
                                    // ),
                                    Chip(label: Text(document['job category'])),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Chip(label: Text(document['location'])),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Chip(label: Text(document['location'])),
                                  ],
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    deleteApplication(document['id']);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
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
        },
      ),
    );
  }
}
