//import 'dart:html';

//import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';
import 'package:email_validator/email_validator.dart';
import 'emp_forgote_account.dart';
import 'utils.dart';

class EmpLoginWidget extends StatefulWidget {
  final VoidCallback onclickedSignIn;
  const EmpLoginWidget({
    Key? key,
    required this.onclickedSignIn,
  }) : super(key: key);

  @override
  State<EmpLoginWidget> createState() => _EmpLoginWidgetState();
}

class _EmpLoginWidgetState extends State<EmpLoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final companyNameController = TextEditingController();
  final taxIdController = TextEditingController();

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
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employer Login'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: (MediaQuery.of(context).size.width) * 3 / 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: companyNameController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(label: Text('company name')),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                TextFormField(
                  controller: taxIdController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(label: Text('Tax ID')),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
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
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(label: Text('password')),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
      ),
    );
  }
}
