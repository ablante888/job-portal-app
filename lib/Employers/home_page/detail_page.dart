import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project1/Employers/home_page/company_detail.dart';
import 'package:project1/Employers/home_page/job_detail.dart';
import 'package:project1/job_seeker_home_page/jobSeekerHome.dart';

class JobDetailPage extends StatefulWidget {
  int index;
  DocumentSnapshot job;
  static const routName = '/JobDetailPage';
  JobDetailPage({Key? key, required this.index, required this.job})
      : super(key: key);

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  bool button1 = true;
  bool button2 = false;

  final SelectedtextColor = Colors.white;
  final unselectedtextColor = Colors.white;
  final SelectedButtontColor = Colors.white;
  final unselectedButtonColor = Colors.white;

  void button1Clicked() {
    setState(() {
      button1 = true;
      button2 = false;
    });
  }

  void button2Clicked() {
    setState(() {
      button1 = false;
      button2 = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height * 2,
                width: MediaQuery.of(context).size.width),
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 159, 196, 226),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0))),
              width: MediaQuery.of(context).size.width,
              // height: ,
              //  color: Theme.of(context).backgroundColor,

              child: Stack(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new_sharp)),
                  Positioned(
                    top: 150,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      // height: MediaQuery.of(context).size.height - 200,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        elevation: 4.0,
                        // margin:
                        //     EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                'Job title!',
                                style: TextStyle(fontSize: 24.0),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      20,
                                  decoration: BoxDecoration(
                                      color:
                                          button1 ? Colors.blue : Colors.white,
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15.0),
                                          topLeft: Radius.circular(15.0))),
                                  child: TextButton(
                                      onPressed: () => button1Clicked(),
                                      child: Text(
                                        'Job descreption',
                                        style: TextStyle(
                                            color: button1
                                                ? Colors.white
                                                : Colors.blue),
                                      )),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      20,
                                  decoration: BoxDecoration(
                                      color:
                                          button2 ? Colors.blue : Colors.white,
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(15.0),
                                          topRight: Radius.circular(15.0))),
                                  child: TextButton(
                                      onPressed: () => button2Clicked(),
                                      child: Text(
                                        'Company',
                                        style: TextStyle(
                                            color: button2
                                                ? Colors.white
                                                : Colors.blue),
                                      )),
                                ),
                              ],
                            ),
                            button1 == true
                                ? Job_detail(
                                    index: widget.index,
                                    job: widget.job,
                                  )
                                : company_detail(),
                          ],
                        ),
                        //button1 == true ? Job_detail() : company_detail(),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 110,
                    left: 20,
                    right: 20,
                    child: Container(
                      width: 100,
                      height: 100,
                      // decoration: BoxDecoration(
                      //   color: Colors.grey[200],
                      //   borderRadius: BorderRadius.circular(10),
                      // ),
                      alignment: Alignment.topCenter,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Icon(Icons.person),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
