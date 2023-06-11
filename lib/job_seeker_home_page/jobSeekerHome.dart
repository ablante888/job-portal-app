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
import 'package:project1/Employers/home_page/detail_page.dart';
import 'package:project1/job_seeker_home_page/job_seeker_drower.dart';
import 'package:project1/profile/job_seeker_profile.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project1/user_account/auth_page.dart';
import 'package:project1/user_account/rgister.dart';

import '../Employers/models/jobs_model.dart';
import '../hompage.dart';
import './job_list.dart';
import 'favorites.dart';
import './jobSeekerNotification.dart';

class home extends StatefulWidget {
  static const routeName = '/home';
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Map<String, dynamic>> _pages = [
    {'page': JobsList(), 'title': Text('jobs')},
    {'page': Favorite(), 'title': Text('SavedJobs')},
    {'page': JobSeekerNotification(), 'title': Text('profile')},
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, HomePage.routeName, (route) => false);
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        drawer: Container(
          height: MediaQuery.of(context).size.height * 0.85,
          child: Align(
            alignment: Alignment.topLeft,
            child: Drawer(
              child: Drower(),
            ),
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
              icon: Icon(Icons.notification_add),
              label: 'Notification',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.deepPurpleAccent,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
  // ugyuftfffffffffff
}

// class SavedJobs extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         "Saved Jobs",
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }


