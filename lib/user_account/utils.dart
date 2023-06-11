//import 'dart:html';

import 'package:flutter/material.dart';

class Utils {
  static final messangerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text, Color _color) {
    if (text == null) return;
    final snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(text),
          Icon(
            Icons.check,
            color: Colors.white,
          ),
        ],
      ),
      backgroundColor: _color,
    );
    messangerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
