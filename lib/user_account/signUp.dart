import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project1/user_account/utils.dart';
import 'verify_email.dart';
import '../firebase_options.dart';
import 'package:email_validator/email_validator.dart';

class signUp extends StatefulWidget {
  final VoidCallback onclickedSignUp;
  const signUp({
    Key? key,
    required this.onclickedSignUp,
  }) : super(key: key);

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController1 = TextEditingController();
  final passwordController2 = TextEditingController();
  void dispose() {
    emailController.dispose();
    passwordController1.dispose();
    passwordController2.dispose();
    super.dispose();
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController1.text.trim())
          .then((result) {
        FirebaseFirestore.instance
            .collection('job-seeker')
            .doc(result.user!.uid)
            .set({
          'email': emailController.text,
          'role': 'jobseeker', // or 'jobseeker'
        });
      });

      VerifyEmail();
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message, Colors.red);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SIGN UP'),
      ),
      body: Form(
        key: formKey,
        child: Center(
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
                height: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Welcome ',
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
                        label: Text('Email'),
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
                      controller: passwordController1,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        label: Text('password'),
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
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value != null && value.length < 6
                          ? 'Enter at least 6 characters'
                          : null,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Verify Password'),
                    TextFormField(
                        controller: passwordController2,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          label: Text('password'),
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
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          value != null && value.length < 6
                              ? 'Enter at least 6 characters'
                              : null;
                          if (passwordController2.text !=
                              passwordController1.text) {
                            return 'Password is not match';
                          }
                        }),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(50)),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState?.save();
                            signUp();
                          }
                        },
                        icon: Icon(
                          Icons.person_add,
                          size: 30.0,
                        ),
                        label: Text('Sign up')),
                    SizedBox(
                      height: 24,
                    ),
                    // RichText(
                    //     text: TextSpan(
                    //         style: TextStyle(color: Colors.black),
                    //         text: 'already have accont ?  ',
                    //         children: [
                    //       TextSpan(
                    //           recognizer: TapGestureRecognizer()
                    //             ..onTap = widget.onclickedSignUp,
                    //           text: 'Sign in',
                    //           style: TextStyle(
                    //               color: Colors.blue,
                    //               decoration: TextDecoration.underline))
                    //     ]))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
