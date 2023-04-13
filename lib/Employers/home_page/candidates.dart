import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class candidates extends StatefulWidget {
  const candidates({Key? key}) : super(key: key);

  @override
  State<candidates> createState() => _candidatesState();
}

class _candidatesState extends State<candidates> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('candidates'),
      ),
    );
  }
}
