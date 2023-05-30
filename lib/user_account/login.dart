//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
//import 'package:flutter/src/foundation/key.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:project1/job_seeker_home_page/jobSeekerHome.dart';
import '../firebase_options.dart';
import 'package:email_validator/email_validator.dart';
import 'forgote_password.dart';
import 'utils.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onclickedSignIn;
  const LoginWidget({
    Key? key,
    required this.onclickedSignIn,
  }) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null) {
        await checkUserRole(user.uid);
        if (isJobSeeker) {
          Navigator.pushNamed(context, home.routeName);
        } else {
          Utils.showSnackBar('Job seeker not found', Colors.red);
          FirebaseAuth.instance.signOut();
        }
      }
    });
  }

  String? uid;
  late FirebaseAuth _outh;
  late Stream<User?> outhStateChange;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isJobSeeker = false;
  Future<void> checkUserRole(String uid) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }

    DocumentSnapshot userData = await FirebaseFirestore.instance
        .collection('job-seeker')
        .doc(user.uid)
        .get();
    if (userData.exists) {
      String role = userData.get('role');
      setState(() {
        isJobSeeker = role == 'jobseeker';
      });
    }
    //return isJobSeeker;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool _showProgressIndicator = false;
  Future signIn() async {
    setState(() {
      _showProgressIndicator = true;
    });
    Visibility(
      visible: _showProgressIndicator,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (context) => Center(
    //           child: CircularProgressIndicator(),
    //         ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      // await checkUserRole();
      // if (isJobSeeker) {
      //   Navigator.pushNamed(context, home.routeName);
      //   //  Navigator.of(context).pop();
      //   // Utils.showSnackBar('Job seeker not found', Colors.red);
      //   // FirebaseAuth.instance.signOut();
      // } else {
      //   Utils.showSnackBar('Job seeker not found', Colors.red);
      //   FirebaseAuth.instance.signOut();
      //   //  Navigator.of(context).pop();
      // }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message, Colors.red);
      print(e.message);
    }
    setState(() {
      _showProgressIndicator = false;
    });
    // if (mounted) {
    //   Navigator.of(context).pop();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGIN'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 81, 152, 211),
                Color.fromARGB(255, 81, 152, 211),
              ],
            ),
          ),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              padding: EdgeInsets.all(12),
              width: (MediaQuery.of(context).size.width) * 3 / 4,
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Welcome Again!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 2.0,
                      wordSpacing: 4.0,
                      shadows: [
                        Shadow(
                          color: Color.fromARGB(255, 158, 158, 158),
                          blurRadius: 2.0,
                          offset: Offset(1.0, 1.0),
                        ),
                      ],
                      // decoration: TextDecoration.underline,
                      // decorationColor: Colors.green,
                      // decorationThickness: 2.0,
                      decorationStyle: TextDecorationStyle.wavy,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Text('Email'),
                      labelStyle: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 18,
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Enter a valid email'
                            : null,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    // keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Text('password'),
                      labelStyle: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 18,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          //shape: ,
                          minimumSize: Size.fromHeight(50)),
                      onPressed: signIn,
                      icon: Icon(Icons.login),
                      label: Text('Sign in')),
                  SizedBox(
                    height: 24,
                  ),
                  GestureDetector(
                      child: Text(
                        'forgote password',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color.fromARGB(255, 255, 7, 172)),
                      ),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ForgotePassword()))),
                  SizedBox(
                    height: 24,
                  ),
                  RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          text: 'No accont ?  ',
                          children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onclickedSignIn,
                            text: 'Sign up',
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline))
                      ]))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//time < timestamp.date(2023, 4, 29);
