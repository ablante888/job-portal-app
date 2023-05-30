import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project1/Employers/home_page/applyers_detail.dart';

import '../../jobSeekerModel/job_seeker_profile_model.dart';

enum SortBy { Relevance, Experience, ApplicationDate }

enum ViewMode { Grid, List }

class Appliers extends StatefulWidget {
  String jobId;

  Appliers({
    Key? key,
    required this.jobId,
  }) : super(key: key);

  @override
  State<Appliers> createState() => _AppliersState();
}

class _AppliersState extends State<Appliers> {
  SortBy _sortBy = SortBy.Relevance;
  ViewMode _viewMode = ViewMode.List;

  void _showSortOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sort By'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Relevance'),
                leading: Radio(
                  value: SortBy.Relevance,
                  groupValue: _sortBy,
                  onChanged: (SortBy? value) {
                    setState(() {
                      _sortBy = value!;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ),
              ListTile(
                title: Text('Experience'),
                leading: Radio(
                  value: SortBy.Experience,
                  groupValue: _sortBy,
                  onChanged: (SortBy? value) {
                    setState(() {
                      _sortBy = value!;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ),
              ListTile(
                title: Text('Application Date'),
                leading: Radio(
                  value: SortBy.ApplicationDate,
                  groupValue: _sortBy,
                  onChanged: (SortBy? value) {
                    setState(() {
                      _sortBy = value!;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget build(BuildContext context) {
    CollectionReference applicantsRef = FirebaseFirestore.instance
        .collection('employers-job-postings')
        .doc('post-id')
        .collection('job posting')
        .doc(widget.jobId)
        .collection('Applicants');
    Stream<QuerySnapshot> applicantsSnapshotStream = FirebaseFirestore.instance
        .collection('employers-job-postings')
        .doc('post-id')
        .collection('job posting')
        .doc(widget.jobId)
        .collection('Applicants')
        .snapshots();
    // getDataStream();
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              Text('Sort option'),
              IconButton(onPressed: _showSortOptions, icon: Icon(Icons.sort)),
            ],
          )
        ],
        title: Text('Applicants'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('employers-job-postings')
            .doc('post-id')
            .collection('job posting')
            .doc(widget.jobId)
            .collection('Applicants')
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
                            Text('Applicants'),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.yellow),
                              child: Center(
                                  child: Text('${snapshot.data!.docs.length}')),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * (3 / 4) -
                                50,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 16),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search applicants',
                                  prefixIcon: Icon(Icons.search),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blueAccent),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),

                                // Implement search functionality
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('sort by'),
                              IconButton(
                                  onPressed: () {
                                    _showSortOptions();
                                  },
                                  icon: Icon(Icons.sort))
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 600,
                        child: new ListView(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, ApplicantPage.routeName,
                                    arguments: [
                                      document['personal-info']['id'],
                                      widget.jobId
                                    ]);
                              },
                              child: Card(
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
                                      child: new Text(document['education']
                                          ['fieldOfStudy'])),
                                  trailing: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Center(
                                        child: Text(
                                      'View Profile',
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

// class ApplicantData {
//   //final Education education;
//   final PersonalInfo personal_Info;
//   final Skill skills;

//   ApplicantData(this.education, this.personal_Info, this.skills);
// }
