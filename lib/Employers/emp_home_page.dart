import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Emp_home extends StatefulWidget {
  const Emp_home({Key? key}) : super(key: key);

  @override
  State<Emp_home> createState() => _Emp_homeState();
}

class _Emp_homeState extends State<Emp_home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('home'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Welcome /n Fill your company information'),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50)),
                  onPressed: () {},
                  icon: Icon(Icons.lock_open),
                  label: Text('Fill company info')),
            ],
          ),
        ));
  }
}
