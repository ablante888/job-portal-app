//import 'dart:html';

import 'package:flutter/material.dart';

class EmpUtils {
  static final messangerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text, Color _color) {
    if (text == null) return;
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: _color,
    );
    final currentState = messangerKey.currentState;
    if (currentState != null) {
      currentState
        ..removeCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }
}
