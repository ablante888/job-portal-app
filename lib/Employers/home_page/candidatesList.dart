import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project1/Employers/home_page/applyers_detail.dart';
import 'package:project1/Employers/home_page/candidateProfile.dart';

class CandidatesList extends StatefulWidget {
  String jobId;

  CandidatesList({
    Key? key,
    required this.jobId,
  }) : super(key: key);

  @override
  State<CandidatesList> createState() => _CandidatesListState();
}

class _CandidatesListState extends State<CandidatesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Applicants'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('employers-job-postings')
            .doc('post-id')
            .collection('job posting')
            .doc(widget.jobId)
            .collection('candidates')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          if (!snapshot.hasData) {
            return Text('OOPS there is no posted jobs');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return new Text('Loading...');
          } else {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.width / 7,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.yellow),
                            child: Center(
                                child: Text('${snapshot.data!.docs.length}')),
                          ),
                          Text('Candidates'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 600,
                      child: new ListView(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          return Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            child: new ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              style: ListTileStyle.drawer,
                              leading: CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                              //  trailing: new Text(document['job category']),
                              title: new Text(
                                  document['education']['institution']),
                              subtitle: Container(
                                  width: 20,
                                  child: new Text(
                                      document['education']['fieldOfStudy'])),
                              trailing: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, candidateProfile.routeName,
                                      arguments: [
                                        document['personal-info']['id'],
                                        widget.jobId
                                      ]);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Center(
                                      child: Text(
                                    'Review Profile',
                                    style: TextStyle(color: Colors.white),
                                  )),
                                  width: 100,
                                  height: 40,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
