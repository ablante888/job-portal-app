import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _EmailswitchValue = false;
  bool _notificationswitchValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            SwitchListTile(
              value: _EmailswitchValue,
              onChanged: (bool newValue) {
                setState(() {
                  _EmailswitchValue = newValue;
                });
              },
              activeColor: Colors.blue,
              inactiveThumbColor: Colors.grey,
              title: Text(
                'Allow Email notification',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'It allows you to be notified in your Email address',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              secondary: Icon(
                Icons.lightbulb_outline,
                color: _EmailswitchValue ? Colors.yellow : Colors.grey,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SwitchListTile(
              value: _notificationswitchValue,
              onChanged: (bool newValue) {
                setState(() {
                  _notificationswitchValue = newValue;
                });
              },
              activeColor: Colors.blue,
              inactiveThumbColor: Colors.grey,
              title: Text(
                'Allow in app notification',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'It allows you to be notified in your account',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              secondary: Icon(
                Icons.lightbulb_outline,
                color: _notificationswitchValue ? Colors.yellow : Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
//  SwitchListTile(
//               value: _switchValue,
//               onChanged: (bool newValue) {
//                 setState(() {
//                   _switchValue = newValue;
//                 });
//               },
//               activeColor: Colors.blue, // Customize the active color
//               inactiveThumbColor:
//                   Colors.grey, // Customize the inactive thumb color
//               inactiveTrackColor: Colors.grey
//                   .withOpacity(0.5), // Customize the inactive track color
//               title: Text(
//                 'Switch List Tile',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               subtitle: Text(
//                 'An attractive switch list tile',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey,
//                 ),
//               ),
//               secondary: Icon(
//                 Icons.lightbulb_outline,
//                 color: _switchValue ? Colors.yellow : Colors.grey,
//               ),
//             ),