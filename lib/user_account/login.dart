//import 'dart:html';

import 'package:flutter/gestures.dart';
//import 'package:flutter/src/foundation/key.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
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
  String? uid;
  late FirebaseAuth _outh;
  late Stream<User?> outhStateChange;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      // if (FirebaseAuth.instance.currentUser != null) {
      //    User user = FirebaseAuth.instance.currentUser;
      // }

      // outhStateChange = _outh.authStateChanges();
      // outhStateChange.listen((event) {
      //   print('..User iD is..${event?.uid}');
      // });
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message, Colors.red);
      print(e.message);
    }
    Navigator.of(context).pop();
    // uid = FirebaseAuth.instance.currentUser?.uid;
    // print('User id is...${uid}');

    // String auth = FirebaseAuth.instance.currentUser as String;
    // print(auth);

    // request.auth != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Container(
          width: (MediaQuery.of(context).size.width) * 3 / 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(label: Text('Email')),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Enter a valid email'
                        : null,
              ),
              TextField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(label: Text('password')),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50)),
                  onPressed: signIn,
                  icon: Icon(Icons.lock_open),
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
    );
  }
}
//time < timestamp.date(2023, 4, 29);