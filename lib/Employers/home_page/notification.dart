import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class EmpNotification extends StatefulWidget {
  const EmpNotification({Key? key}) : super(key: key);

  @override
  State<EmpNotification> createState() => _EmpNotificationState();
}

class _EmpNotificationState extends State<EmpNotification> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('notification'),
      ),
    );
  }
}
// {'page': EmpHomePage(), 'title': Text('home')},
//   {'page': Posted_jobs(), 'title': Text('jobs posted')},
//   {'page': candidates(), 'title': Text('candidates')},
//   {'page': EmpNotification(), 'title': Text('Notification')}