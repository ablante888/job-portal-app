import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project1/user_account/utils.dart';
import 'emp_verify.dart';
import '../../firebase_options.dart';
import 'package:email_validator/email_validator.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class EmpsignUp extends StatefulWidget {
  final VoidCallback onclickedEmpSignUp;
  const EmpsignUp({
    Key? key,
    required this.onclickedEmpSignUp,
  }) : super(key: key);

  @override
  State<EmpsignUp> createState() => _EmpsignUpState();
}

class _EmpsignUpState extends State<EmpsignUp> {
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

  Future EmpsignUp() async {
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
            .collection('employer')
            .doc(result.user!.uid)
            .set({
          'email': emailController.text,
          'role': 'employer', // or 'jobseeker'
        });
      });

      VerifyEmpEmail();
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
            width: (MediaQuery.of(context).size.width) * 3 / 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText('Welcome !',
                        textStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 30,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Times New Roman',
                          fontWeight: FontWeight.w500,
                        ),
                        speed: const Duration(
                          milliseconds: 450,
                        )),
                  ],
                  // onTap: () {
                  //   debugPrint("Welcome back!");
                  // },
                  isRepeatingAnimation: true,
                  totalRepeatCount: 4,
                ),
                SizedBox(
                  height: 15,
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
                  height: 10,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50)),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState?.save();
                        EmpsignUp();
                      }
                    },
                    icon: Icon(Icons.person_add),
                    label: Text('Sign up')),
                SizedBox(
                  height: 24,
                ),
                //  RichText(
                // text: TextSpan(
                //     style: TextStyle(color: Colors.black),
                //     text: 'already have accont ?  ',
                //     children: [
                //   TextSpan(
                //       recognizer: TapGestureRecognizer()
                //         ..onTap = widget.onclickedEmpSignUp,
                //       text: 'Sign in',
                //       style: TextStyle(
                //           // fontWeight: FontWeight.bold,
                //           color: Colors.blue,
                //           decoration: TextDecoration.underline)),
                // ])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
