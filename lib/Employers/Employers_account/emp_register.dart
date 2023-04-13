import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'emp_auth_page.dart';
import 'emp_verify.dart';

class EmpRegister extends StatefulWidget {
  static const routeName = '/Empregister';
  const EmpRegister({Key? key}) : super(key: key);

  @override
  State<EmpRegister> createState() => _EmpRegisterState();
}

class _EmpRegisterState extends State<EmpRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return VerifyEmail();
          else
            return EmpAuthPage();
        },
      ),
    );
  }
}
