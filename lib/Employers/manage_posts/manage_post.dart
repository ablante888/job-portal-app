import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

// // class Manage_posts extends StatefulWidget {
// //   const Manage_posts({Key? key}) : super(key: key);

// //   @override
// //   State<Manage_posts> createState() => _Manage_postsState();
// // }

// // class _Manage_postsState extends State<Manage_posts> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       child: Center(
// //         child: Text('posted jobs'),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';

// //void main() => runApp(Manage_posts());

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project1/Employers/Employers_account/empUtils.dart';
import 'package:project1/Employers/manage_posts/edit_posts.dart';

import '../home_page/job_post_form.dart';
import '../models/jobs_model.dart';

class Manage_posts extends StatefulWidget {
  static const routeName = 'Manage_posts';
  @override
  _Manage_postsState createState() => _Manage_postsState();
}

class _Manage_postsState extends State<Manage_posts> {
  String getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }

  void deleteJob(String id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              Row(
                children: [
                  Text('Are you sure to delete this job '),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.warning,
                        color: Colors.red,
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        try {
                          FirebaseFirestore.instance
                              .collection('employers-job-postings')
                              .doc('post-id')
                              .collection('job posting')
                              .doc(id)
                              .delete();
                          FirebaseFirestore.instance
                              .collection('employer')
                              .doc(getCurrentUserUid())
                              .collection('job posting')
                              .doc(id)
                              .delete();
                          Navigator.of(context).pop();
                          EmpUtils.showSnackBar(
                              'Job deleted sucessfuly', Colors.green);
                        } on FirebaseException catch (e) {
                          EmpUtils.showSnackBar(e.message, Colors.red);
                        }
                      },
                      child: Text('Delete')),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel')),
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Employer Dashboard'),
        backgroundColor: Colors.blue[900],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('employer')
            .doc(getCurrentUserUid())
            .collection('job posting')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
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
                        return GestureDetector(
                          onTap: () {},
                          child: Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            child: new ListTile(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              style: ListTileStyle.drawer,
                              leading: CircleAvatar(
                                foregroundImage: NetworkImage(document[
                                        'company']['logoUrl'] ??
                                    'https://www.bing.com/images/search?view=detailV2&ccid=q182Q4Zy&id=D8C88B9D55DB76A095EADD6BDE4D4DF28EFD9B65&thid=OIP.q182Q4ZyCS-WUHuYGfac4QHaDt&mediaurl=https%3a%2f%2fhitechengineeringindia.com%2fimg%2fheader-img%2fprofile.jpg&cdnurl=https%3a%2f%2fth.bing.com%2fth%2fid%2fR.ab5f36438672092f96507b9819f69ce1%3frik%3dZZv9jvJNTd5r3Q%26pid%3dImgRaw%26r%3d0&exph=834&expw=1666&q=image+for+company+profile+picture&simid=608015538228691274&FORM=IRPRST&ck=97AE052C55DA4BCF742295A439E9F6CE&selectedIndex=22'),

                                // :child: Icon(Icons.person),
                              ),
                              //  leading: new Text(document['job category']),
                              title: new Text(document['title']),
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
                              trailing: Container(
                                width: 100,
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context,
                                              EditJobPostingForm.routName,
                                              arguments: document);
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Theme.of(context).primaryColor,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          deleteJob(document.id);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Theme.of(context).errorColor,
                                        ))
                                  ],
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
