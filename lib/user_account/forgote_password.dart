import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:email_validator/email_validator.dart';
import 'utils.dart';

class ForgotePassword extends StatefulWidget {
  const ForgotePassword({Key? key}) : super(key: key);

  @override
  State<ForgotePassword> createState() => _ForgotePasswordState();
}

class _ForgotePasswordState extends State<ForgotePassword> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Utils.showSnackBar('password reset mail sent', Colors.red);
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message, Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset password'),
      ),
      body: Center(
        child: Container(
          width: (MediaQuery.of(context).size.width) * 3 / 4,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Insert your email to\n reset your password'),
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
                SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50)),
                    onPressed: resetPassword,
                    icon: Icon(Icons.lock_reset),
                    label: Text('Reset')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
