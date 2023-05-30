//import 'dart:html';

//import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project1/Employers/emp_profile/emp_form.dart';
import 'package:project1/Employers/home_page/emp_home_page.dart';
import 'package:project1/Employers/home_page/tabs_screen.dart';

class Emp_home extends StatefulWidget {
  static const routeName = '/Emp_home';
  const Emp_home({Key? key}) : super(key: key);

  @override
  State<Emp_home> createState() => _Emp_homeState();
}

class _Emp_homeState extends State<Emp_home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          label: Text('Logout out'),
          icon: Icon(Icons.logout_rounded),
        ),
        appBar: AppBar(
          title: Text('Hulu Jobs'),
        ),
        body: Center(
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              height: 400,
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Text(
                  //   ' Fill your company information',
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
                  Divider(),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(50)),
                        onPressed: () => Navigator.of(context)
                            .pushNamed(EmployerRegistrationForm.routeName),
                        icon: Icon(Icons.book),
                        label: Text('Fill your company Profile')),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(50)),
                        onPressed: () => Navigator.of(context)
                            .pushNamed(EmployerRegistrationForm.routeName),
                        icon: Icon(Icons.book),
                        label: Text('Update your company Profile')),
                  ),
                  Divider(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: (MediaQuery.of(context).size.width) * 1 / 2,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(50)),
                      onPressed: () =>
                          Navigator.of(context).pushNamed(TabsScreen.routeName),
                      icon: Icon(
                        Icons.home,
                        size: 36,
                      ),
                      label: Text('Go Home'),
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
        ));
  }
}
