//import 'dart:html';

//import 'dart:html';
//import 'dart:html';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:project1/profile/job_seeker_profile.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project1/user_account/auth_page.dart';
import 'package:project1/user_account/rgister.dart';

import '../Employers/models/jobs_model.dart';

class home extends StatefulWidget {
  static const routeName = '/home';
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final List<Map<String, dynamic>> _pages = [
    {'page': JobsList(), 'title': Text('jobs')},
    {'page': SavedJobs(), 'title': Text('SavedJobs')},
    {'page': Profile(), 'title': Text('profile')},
    // {'page': EmpNotification(), 'title': Text('Notification')}
  ];

  int selecetedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      selecetedPageIndex = index;
    });
  }

  String getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }

  File? image;

  int _selectedIndex = 0;
  // static List<Widget> _widgetOptions = <Widget>[
  //   JobsList(),
  //   SavedJobs(),
  //   Profile(),
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

//print(DateFormat.yMMMd().format(DateTime.now()));
  Future<QuerySnapshot<Map<String, dynamic>>> getRecentPosts() async {
    String date = '2023-05-30T00:00:00.000';
    final ref = FirebaseFirestore.instance
        .collection('employers-job-postings')
        .doc('post-id')
        .collection('job posting');
    final query = await ref.where('posted time', isLessThan: date).get();

    // .then((querySnapshot) => null);
    return query;
  }

  @override
  Widget build(BuildContext context) {
    image = ModalRoute.of(context)?.settings.arguments as File?;
    print(image?.path);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Ablante Daniel"),
              accountEmail: Text("ablantedaniel@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "AD",
                  style: TextStyle(fontSize: 28),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("My Profile"),
              //  onTap: () {},
              onTap: () => Navigator.pushNamed(context, ProfilePage.routeName),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text("Saved Jobs"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text("Job Alerts"),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Help & Support"),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
                FirebaseAuth.instance.signOut();
                // Navigator.pushNamed(context, Register.routeName);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: _pages[_selectedIndex]['title'],
        actions: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/images/profile2.jpeg'),
          ),
          SizedBox(
            width: 5,
          )
        ],
      ),
      body: _pages[_selectedIndex]['page'],

//cccccccccccccccccccccccccccc,

      bottomNavigationBar: BottomNavigationBar(
        // onTap: _selectPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Saved Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurpleAccent,
        onTap: _onItemTapped,
      ),
    );
  }
  // ugyuftfffffffffff
}

class JobsList extends StatelessWidget {
  final List<String> recentJobs = [
    "Software Engineer",
    "UI/UX Designer",
    "Data Analyst",
    "Product Manager",
    "Marketing Specialist",
  ];
  File? image;
  @override
  Widget build(BuildContext context) {
    image = ModalRoute.of(context)?.settings.arguments as File?;
    print(image?.path);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Ablante Daniel"),
              accountEmail: Text("ablantedaniel@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "AD",
                  style: TextStyle(fontSize: 28),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("My Profile"),
              //  onTap: () {},
              onTap: () => Navigator.pushNamed(context, ProfilePage.routeName),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text("Saved Jobs"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text("Job Alerts"),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Help & Support"),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
                // FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
      // appBar: AppBar(
      //   title: Text('home'),
      //   actions: [
      //     CircleAvatar(
      //       radius: 25,
      //       backgroundColor: Colors.white,
      //       backgroundImage: AssetImage('assets/images/profile2.jpeg'),
      //     ),
      //     SizedBox(
      //       width: 5,
      //     )
      //   ],
      // ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Icon(
                    Icons.search,
                    color: Colors.grey[400],
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search for jobs",
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.deepPurpleAccent,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 16),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 120,
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 8),
              scrollDirection: Axis.horizontal,
              itemCount: recentJobs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  // width: MediaQuery.of(context).size.width / 2,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    recentJobs[index],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                );
              },
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('employers-job-postings')
                .doc('post-id')
                .collection('job posting')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return new Text('Loading...');
                default:
                  return SafeArea(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        height: 450,
                        child: new ListView(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            return GestureDetector(
                              onTap: () {},
                              child: Card(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                child: new ListTile(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.black, width: 1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  style: ListTileStyle.drawer,
                                  leading: CircleAvatar(
                                    child: Icon(Icons.person),
                                  ),
                                  //  leading: new Text(document['job category']),
                                  title: new Text(document['title']),
                                  subtitle: new Text(document['description']),
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
        ],
      ),
    );
  }
}

class SavedJobs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Saved Jobs",
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Profile",
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}


// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

// // class Posted_jobs extends StatefulWidget {
// //   const Posted_jobs({Key? key}) : super(key: key);

// //   @override
// //   State<Posted_jobs> createState() => _Posted_jobsState();
// // }

// // class _Posted_jobsState extends State<Posted_jobs> {
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

// //void main() => runApp(Posted_jobs());

// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../models/jobs_model.dart';

// class Posted_jobs extends StatefulWidget {
//   @override
//   _Posted_jobsState createState() => _Posted_jobsState();
// }

// class _Posted_jobsState extends State<Posted_jobs> {
//   String getCurrentUserUid() {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       return user.uid;
//     } else {
//       return '';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         title: Text('Employer Dashboard'),
//         backgroundColor: Colors.blue[900],
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('employer')
//             .doc(getCurrentUserUid())
//             .collection('job posting')
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
//           switch (snapshot.connectionState) {
//             case ConnectionState.waiting:
//               return new Text('Loading...');
//             default:
//               return new ListView(
//                 padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
//                 children: snapshot.data!.docs.map((DocumentSnapshot document) {
//                   return Card(
//                     margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
//                     child: new ListTile(
//                       shape: RoundedRectangleBorder(
//                         side: BorderSide(color: Colors.black, width: 1),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       style: ListTileStyle.drawer,
//                       leading: new Text(document['job category']),
//                       title: new Text(document['title']),
//                       subtitle: new Text(document['description']),
//                     ),
//                   );
//                 }).toList(),
//               );
//           }
//         },
//       ),
//     );
//   }
// }

// class Posted_jobs extends StatefulWidget {
//   @override
//   _Posted_jobsState createState() => _Posted_jobsState();
// }

// class _Posted_jobsState extends State<Posted_jobs> {
//   String getCurrentUserUid() {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       return user.uid;
//     } else {
//       return '';
//     }
//   }

//   Future<List<JobPost>> getJobPostList() async {
//     List<JobPost> JobPostList = [];
//     QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
//         .instance
//         .collection('employer')
//         .doc(getCurrentUserUid())
//         .collection('JobPost posting')
//         .get();

//     snapshot.docs.forEach((doc) {
//       JobPost job = JobPost.fromJson(doc.data());
//       JobPostList.add(job);
//       print('the title of the job is :${JobPostList[0].title}');
//     });

//     return JobPostList;
//   }

//   late Future<List<JobPost>> _jobListFuture;

//   @override
//   void initState() {
//     super.initState();
//     _jobListFuture = getJobPostList();
//     // print('the title of the job is :${_jobListFuture[0].title}');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Employer Dashboard'),
//       ),
//       body: FutureBuilder<List<JobPost>>(
//         future: _jobListFuture,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 JobPost job = snapshot.data![index];
//                 return ListTile(
//                   shape: RoundedRectangleBorder(
//                     side: BorderSide(color: Colors.black, width: 1),
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   title: Text(job.title),
//                   subtitle: Text(job.description),
//                   trailing: Text('\$${job.salary}'),
//                 );
//               },
//             );
//           } else if (snapshot.hasError) {
//             return Text('${snapshot.error}');
//           } else {
//             return CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }
// }
