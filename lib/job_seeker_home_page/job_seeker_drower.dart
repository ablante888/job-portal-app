import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project1/job_seeker_home_page/applied_jobs.dart';
import 'package:project1/job_seeker_home_page/jobSeekerSetting.dart';

import '../profile/job_seeker_profile.dart';

class Drower extends StatefulWidget {
  const Drower({Key? key}) : super(key: key);

  @override
  State<Drower> createState() => _DrowerState();
}

class _DrowerState extends State<Drower> {
  String getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return 'null';
    }
  }

  @override
  Widget build(BuildContext context) {
    print('the current user id is ${getCurrentUserUid()}');
    return Container(
      height: MediaQuery.of(context).size.height - 500,
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

            onTap: () {
              Navigator.pop(context); // Close the drawer

              if (getCurrentUserUid() != 'null') {
                Navigator.pushNamed(context, ProfilePage.routeName);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please sign up first.'),
                    action: SnackBarAction(
                      label: 'Sign Up',
                      onPressed: () {
                        // Handle the sign-up action
                        // Navigate to the sign-up page or perform any other necessary actions
                      },
                    ),
                  ),
                );
              }
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.work),
            title: Text("Applied Jobs"),
            onTap: () {
              if (getCurrentUserUid() != 'null') {
                Navigator.pushNamed(context, Applied_jobs_list.routeName);
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Job Alerts"),
            onTap: () {
              if (getCurrentUserUid() != 'null') {}
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {
              if (getCurrentUserUid() != 'null') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );
              }
            },
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
              // Navigator.pushNamed(context, Register.routeName);
            },
          ),
        ],
      ),
    );
  }
}
