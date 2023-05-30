import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../profile/job_seeker_profile.dart';

class Drower extends StatefulWidget {
  const Drower({Key? key}) : super(key: key);

  @override
  State<Drower> createState() => _DrowerState();
}

class _DrowerState extends State<Drower> {
  @override
  Widget build(BuildContext context) {
    return ListView(
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
            // Navigator.pushNamed(context, Register.routeName);
          },
        ),
      ],
    );
  }
}
