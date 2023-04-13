import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'verify_email.dart';
import 'auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  static const routeName = '/register';
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return Center(
          //     child: CircularProgressIndicator(),
          //   );
          //} else
          if (snapshot.hasData)
            return VerifyEmail();
          else
            return AuthPage();
        },
      ),
    );
  }
}
