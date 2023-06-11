import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../Employers/home_page/detail_page.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  String getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }

  void deleteFavorite(String id) {
    FirebaseFirestore.instance
        .collection('job-seeker')
        .doc(getCurrentUserUid())
        .collection('favorite-jobs')
        .doc(id)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    if (getCurrentUserUid().isEmpty) {
      // User not logged in, show a placeholder widget
      return Center(
        child: Text('Please log in to save jobs.'),
      );
    }
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('job-seeker')
          .doc(getCurrentUserUid())
          .collection('favorite-jobs')
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
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
                                settings: RouteSettings(name: "vendorScreen")),
                          );
                        },
                        child: Card(
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          elevation: 2, // Add elevation for a shadow effect
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            // leading: CircleAvatar(
                            //   backgroundColor: Colors
                            //       .blue, // Set a background color for the avatar
                            //   child: Icon(Icons.person, color: Colors.white),
                            // ),
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
                              // mainAxisAlignment: MainAxisAlignment.start,
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
                                Chip(
                                    label: Text(
                                        '${document['employment type']} ')),
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                deleteFavorite(document['id']);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}
