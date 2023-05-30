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
                            title: new Text(document['title']),
                            subtitle: new Text(document['jobTitle']),
                            trailing: IconButton(
                                onPressed: () {
                                  deleteFavorite(document['id']);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )),
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
