import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project1/Employers/Employers_account/emp_auth_page.dart';
import 'package:project1/Employers/emp_profile/edit_emp_profile.dart';
import 'package:project1/start_page.dart';

enum menu { updateProfile, logout }

class popUpMenu extends StatefulWidget {
  const popUpMenu({Key? key}) : super(key: key);

  @override
  State<popUpMenu> createState() => _popUpMenuState();
}

class _popUpMenuState extends State<popUpMenu> {
  // List menu = ['Update profile', 'Logout'];
  String? selectedItem;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (value) => {
              print('the value is ${value}'),
              if (value == menu.updateProfile)
                {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditEmployerProfile())),
                },
              if (value == menu.logout)
                {
                  FirebaseAuth.instance.signOut(),
                  Navigator.pushReplacementNamed(context, EmpAuthPage.routName),
                }
            },
        itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Update profile'),
                value: menu.updateProfile,
              ),
              PopupMenuItem(
                child: Text('Logout'),
                value: menu.logout,
              )
            ]);
  }
}
