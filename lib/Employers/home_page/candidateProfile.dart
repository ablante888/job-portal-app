import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project1/Employers/Employers_account/empUtils.dart';
import 'package:project1/Employers/home_page/messages.dart';
import 'package:project1/profile/job_seeker_view_profile.dart';

enum SortBy { Relevance, Experience, ApplicationDate }

enum ViewMode { Grid, List }

// class candidateProfile extends StatefulWidget {
//   static const routeName = '/candidateProfile';

class candidateProfile extends StatelessWidget {
  static const routeName = '/candidateProfile';
  void addToShortlist(String jobId, String applicantId) {
    final candidatesReference = FirebaseFirestore.instance
        .collection('employers-job-postings')
        .doc('post-id')
        .collection('job posting')
        .doc(jobId)
        .collection('candidates');
  }

  Future saveJobPost(String job_id, String applierId) async {
    final job_document_ref = FirebaseFirestore.instance
        .collection('employers-job-postings')
        .doc('post-id')
        .collection('job posting')
        .doc(job_id)
        .collection('Applicants')
        .doc(applierId);
  }

  Future<void> ChooseCandidate(String job_id, String applierId) async {
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection('job-seeker')
            .doc(applierId)
            .collection('jobseeker-profile')
            .doc('profile')
            .get();
    final DocumentReference candidate_Collection_Reference =
        await FirebaseFirestore.instance
            .collection('employers-job-postings')
            .doc('post-id')
            .collection('job posting')
            .doc(job_id)
            .collection("candidates")
            .doc(applierId);
    candidate_Collection_Reference.set(documentSnapshot.data());
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as List;
    final applicant_id = arguments[0];
    final jobId = arguments[1];
    return Scaffold(
      appBar: AppBar(
        title: Text('applicant.name'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          }),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints.expand(
                  height: (MediaQuery.of(context).size.height) - 400,
                  width: MediaQuery.of(context).size.width),
              child: ProfilePageView(
                id: applicant_id,
              ),
            ),
            Column(
              children: [
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.email),
                        title: Text('Send Email'),
                        onTap: () {},
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.message),
                        title: Text('Send Message'),
                        onTap: () {
                          // Within the `FirstRoute` widget

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ComposeMessageScreen(
                                    jobApplierId: applicant_id)),
                          );

                          // showModalBottomSheet(
                          //   context: context,
                          //   isScrollControlled:
                          //       true, // Allow the bottom sheet to take up full screen height
                          //   builder: (BuildContext context) {
                          //     return Container(
                          //       padding: EdgeInsets.all(16.0),
                          //       child: Column(
                          //         mainAxisSize: MainAxisSize.min,
                          //         children: [
                          //           Text(
                          //             'Compose Message',
                          //             style: TextStyle(
                          //               fontSize: 20,
                          //               fontWeight: FontWeight.bold,
                          //             ),
                          //           ),
                          //           SizedBox(height: 16),
                          //           TextField(
                          //             maxLines: null,
                          //             keyboardType: TextInputType.multiline,
                          //             decoration: InputDecoration(
                          //               border: OutlineInputBorder(),
                          //               hintText: 'Enter your message...',
                          //             ),
                          //           ),
                          //           SizedBox(height: 16),
                          //           ElevatedButton(
                          //             child: Text('Send'),
                          //             onPressed: () {
                          //               // Handle send message action
                          //               // ...
                          //               Navigator.pop(
                          //                   context); // Close the bottom sheet
                          //             },
                          //           ),
                          //         ],
                          //       ),
                          //     );
                          //   },
                          // );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          child: Text('Reject'),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                          ),
                          child: Text('Schedule Interview'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
