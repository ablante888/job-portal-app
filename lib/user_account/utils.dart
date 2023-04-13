//import 'dart:html';

import 'package:flutter/material.dart';

class Utils {
  static final messangerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text, Color _color) {
    if (text == null) return;
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: _color,
    );
    messangerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
