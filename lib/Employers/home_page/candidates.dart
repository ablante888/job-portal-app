import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project1/Employers/home_page/appliers.dart';
import 'package:project1/Employers/home_page/candidatesList.dart';

import '../models/jobs_model.dart';

class candidates extends StatefulWidget {
  static const routeName = 'candidates';
  @override
  _candidatesState createState() => _candidatesState();
}

class _candidatesState extends State<candidates> {
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
                .collection('employer')
                .doc(getCurrentUserUid())
                .collection('job posting')
                .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          if (!snapshot.hasData) return Text('OOPS there is no posted jobs');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');

            default:
              return SafeArea(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: 600,
                    child: new ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            child: new ListTile(
                              shape: RoundedRectangleBorder(
                                // side: BorderSide(color: Colors.blue, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              style: ListTileStyle.drawer,
                              leading: CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                              //  leading: new Text(document['job category']),
                              title: new Text(
                                document['title'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  width: 20,
                                  child: Row(
                                    children: [
                                      new Text(document['job category']),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      new Text(document['employment type']),
                                    ],
                                  )),
                              trailing: GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CandidatesList(
                                            jobId: document['job id'],
                                          )),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Center(
                                      child: Text(
                                    'Candidates ',
                                    style: TextStyle(color: Colors.white),
                                  )),
                                  width: 100,
                                  height: 40,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
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
