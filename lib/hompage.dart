import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project1/job_seeker_home_page/jobSeekerHome.dart';
import 'package:project1/profile/personal_info.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/HomePage';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          FirebaseAuth.instance.signOut();
          // Navigator.of(context).
        },
        label: Text('Logout out'),
        icon: Icon(Icons.logout_rounded),
      ),
      
      appBar: AppBar(
        title: Text('Hulu jobs'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Center(
              //   child: Text('Logged in'),
              // ),
              Image.asset(
                'assets/images/logo.jpg',
                width: MediaQuery.of(context).size.width,
                height: 200,
              ),
              // SizedBox(
              //   height: 20.0,
              // ),
              Text(
                'Welcome  ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Find your dream job with us. Build your profile and get started',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: (MediaQuery.of(context).size.width) * 1 / 2,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50)),
                    onPressed: () => Navigator.of(context)
                        .pushNamed(personal_info.routeName),
                    child: Text('Build profile')),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: (MediaQuery.of(context).size.width) * 1 / 2,
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50)),
                    onPressed: () {
                      Navigator.of(context).pushNamed(home.routeName);
                    },
                    icon: Icon(
                      Icons.home,
                      size: 36,
                    ),
                    label: Text('Go home')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
