import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:project1/Employers/Employers_account/emp_sign_up.dart';
import 'package:project1/user_account/signUp.dart';
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
            return VerifyEmpEmail();
          else
            return EmpsignUp(
              onclickedEmpSignUp: () {},
            );
        },
      ),
    );
  }
}
// class EmpRegister extends StatefulWidget {
//   static const routeName = '/Empregister';
//   const EmpRegister({Key? key}) : super(key: key);

//   @override
//   State<EmpRegister> createState() => _EmpRegisterState();
// }

// class _EmpRegisterState extends State<EmpRegister> {
//   bool _showProgressIndicator = false;
//   bool _isUserRoleChecked = false;
//   bool _isJobSeeker = false;

//   @override
//   void initState() {
//     super.initState();
//     _checkUserRole();
//   }

//   void _checkUserRole() async {
//     setState(() {
//       _showProgressIndicator = true;
//     });

//     User? user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       return;
//     }

//     DocumentSnapshot userData = await FirebaseFirestore.instance
//         .collection('job-seeker')
//         .doc(user.uid)
//         .get();
//     if (userData.exists) {
//       String role = userData.get('role');
//       setState(() {
//         _isJobSeeker = role == 'jobseeker';
//         _isUserRoleChecked = true;
//         _showProgressIndicator = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _showProgressIndicator
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : _isUserRoleChecked
//               // ? _isJobSeeker
//               ? VerifyEmpEmail()
//               // : EmployerHome()
//               : EmpAuthPage(),
//     );
//   }
// }

// class _EmpRegisterState extends State<EmpRegister> {
//   bool _showProgressIndicator = false;
//   bool _isUserRoleChecked = false;
//   bool _isJobSeeker = false;
//   Stream<User?> authStream = FirebaseAuth.instance.authStateChanges();
//   void _checkUserRole() async {
//     setState(() {
//       _showProgressIndicator = true;
//     });

//     User? user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       return;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: authStream,
//         builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             // Show a progress indicator if the connection is waiting
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasData) {
//             // User is signed in, check their role and navigate accordingly
//             _checkUserRole();
//             if (_showProgressIndicator) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (_isUserRoleChecked && _isJobSeeker) {
//               return VerifyEmpEmail();
//             } else {
//               return EmpAuthPage();
//             }
//           } else {
//             // User is signed out, show the AuthPage
//             return EmpAuthPage();
//           }
//         },
//       ),
//     );
//   }
// }
