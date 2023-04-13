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
  final passwordController = TextEditingController();
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
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
        title: Text('sign Up'),
      ),
      body: Form(
        key: formKey,
        child: Center(
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
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(label: Text('password')),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value != null && value.length < 6
                      ? 'Enter at least 6 characters'
                      : null,
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50)),
                    onPressed: signUp,
                    icon: Icon(Icons.lock_open),
                    label: Text('Sign up')),
                SizedBox(
                  height: 24,
                ),
                RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        text: 'already have accont ?  ',
                        children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onclickedSignUp,
                          text: 'Sign in',
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
