//import 'dart:html';

import 'package:project1/Employers/manage_posts/manage_post.dart';
import 'package:project1/Employers/models/jobs_model.dart';

import '../emp_profile/emp_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

import 'job_post_form.dart';

class EmpHomePage extends StatefulWidget {
  static const routeName = '/EmpHomePage';
  @override
  State<EmpHomePage> createState() => _EmpHomePageState();
}

class _EmpHomePageState extends State<EmpHomePage> {
  @override
  Widget build(BuildContext context) {
    final company_Object = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/post.jpeg', width: 350.0),
            Text(
              'Welcome Employer',
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Connect with the most qualified talent',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto',
                    color: Colors.black54),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Access to the largest talent pool',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto',
                    color: Colors.black54),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Post Jobs & Find Candidates',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Roboto',
                    color: Colors.black54),
              ),
            ),
            SizedBox(
              height: 35.0,
            ),
            // FlatButton(
            //   onPressed: () {},
            //   child: Container(
            //     height: 35.0,
            //     width: 200.0,
            //     decoration: BoxDecoration(
            //         color: Colors.blue,
            //         borderRadius: BorderRadius.circular(20.0)),
            //     child: Center(
            //       child: Text('Get Started',
            //           style: TextStyle(
            //               fontSize: 20.0,
            //               fontWeight: FontWeight.bold,
            //               fontFamily: 'Roboto',
            //               color: Colors.white)),
            //     ),
            //   ),
            // ),
            //   Row(children: [],),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, JobPostingForm.routName,
                    arguments: company_Object);
              },
              child: Text('Post a new Job'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Manage_posts.routeName);
              },
              child: Text('Manage Job'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class EmpHomePage extends StatefulWidget {
//   @override
//   State<EmpHomePage> createState() => _EmpHomePageState();
// }

// class _EmpHomePageState extends State<EmpHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Employer Portal"),
//         backgroundColor: Colors.blue[800],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               "Welcome to Employer Portal",
//               style: TextStyle(
//                 fontSize: 30.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(
//               height: 20.0,
//             ),
//             MaterialButton(
//               onPressed: () {
//                 //Post Job Functionality
//               },
//               color: Colors.green,
//               child: Text(
//                 "Post New Job",
//                 style: TextStyle(
//                   fontSize: 20.0,
//                 ),
//               ),
//               minWidth: 200.0,
//               height: 50.0,
//               elevation: 10.0,
//             ),
//             SizedBox(
//               height: 20.0,
//             ),
//             MaterialButton(
//               onPressed: () {
//                 //See Candidates Functionality
//               },
//               color: Colors.blue[800],
//               child: Text(
//                 "See Candidates",
//                 style: TextStyle(
//                   fontSize: 20.0,
//                 ),
//               ),
//               minWidth: 200.0,
//               height: 50.0,
//               elevation: 10.0,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';

// class EmpHomePage extends StatefulWidget {
//   @override
//   State<EmpHomePage> createState() => _EmpHomePageState();
// }

// class _EmpHomePageState extends State<EmpHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               // Hero section with banner image or video
//               height: 300,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/images/banner.png'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               child: Center(
//                 child: Text(
//                   'Welcome to the Job Portal for Employers',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 50),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   Text(
//                     'Find your next top talent',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     'Posting jobs on the job portal offers a larger pool of qualified candidates, reduced hiring time, and simplified hiring processes.',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   SizedBox(height: 50),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       // Job categories or industries section
//                       Column(
//                         children: [
//                           Icon(Icons.business_center, size: 50),
//                           SizedBox(height: 10),
//                           Text('Business', style: TextStyle(fontSize: 18)),
//                         ],
//                       ),
//                       Column(
//                         children: [
//                           Icon(Icons.engineering, size: 50),
//                           SizedBox(height: 10),
//                           Text('Engineering', style: TextStyle(fontSize: 18)),
//                         ],
//                       ),
//                       Column(
//                         children: [
//                           Icon(Icons.computer, size: 50),
//                           SizedBox(height: 10),
//                           Text('Information Technology',
//                               style: TextStyle(fontSize: 18)),
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 50),
//                   // Top employers section
//                   Text(
//                     'Top Employers',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   // Carousel of logos or images
//                   Container(
//                     height: 100,
//                     child: ListView(
//                       scrollDirection: Axis.horizontal,
//                       children: [
//                         Image.asset('assets/images/employer1.png'),
//                         SizedBox(width: 20),
//                         Image.asset('assets/images/employer2.png'),
//                         SizedBox(width: 20),
//                         Image.asset('assets/images/employer3.png'),
//                         SizedBox(width: 20),
//                         Image.asset('assets/images/employer4.png'),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 50),
//                   // Call-to-action button
//                   ElevatedButton(
//                     onPressed: () {},
//                     child: Text('Post a Job'),
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.blue,
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//                       textStyle: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Footer section with links to important pages
//             Container(
//               height: 100,
//               color: Colors.grey[200],
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   TextButton(
//                     onPressed: () {},
//                     child: Text('About Us'),
//                   ),
//                   TextButton(
//                     onPressed: () {},
//                     child: Text('Contact Us'),
//                   ),
//                   TextButton(
//                     onPressed: () {},
//                     child: Text('Privacy Policy'),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
