import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Posted_jobs extends StatefulWidget {
  const Posted_jobs({Key? key}) : super(key: key);

  @override
  State<Posted_jobs> createState() => _Posted_jobsState();
}

class _Posted_jobsState extends State<Posted_jobs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('posted jobs'),
      ),
    );
  }
}
