import 'package:flutter/material.dart';
import 'user_account/auth_page.dart';
import 'Employers/Employers_account/emp_auth_page.dart';

enum UserType {
  jobSeeker,
  recruiter,
}

class loginOption extends StatefulWidget {
  static const routeName = '/loginOption';
  @override
  _loginOptionState createState() => _loginOptionState();
}

class _loginOptionState extends State<loginOption> {
  UserType _userType = UserType.jobSeeker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select your user type:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: UserType.jobSeeker,
                  groupValue: _userType,
                  onChanged: (value) {
                    setState(() {
                      _userType = value as UserType;
                    });
                  },
                ),
                Text('Job Seeker'),
                SizedBox(width: 30.0),
                Radio(
                  value: UserType.recruiter,
                  groupValue: _userType,
                  onChanged: (value) {
                    setState(() {
                      _userType = value as UserType;
                    });
                  },
                ),
                Text('Recruiter'),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (_userType == UserType.jobSeeker) {
                  // Add job seeker login logic here
                  Navigator.pushNamed(context, AuthPage.routName);
                } else {
                  // Add recruiter login logic here
                  Navigator.pushNamed(context, EmpAuthPage.routName);
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
