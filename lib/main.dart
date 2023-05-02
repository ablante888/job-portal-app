import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:project1/Employers/Employers_account/emp_register.dart';
import 'package:project1/Employers/emp_profile/emp_form.dart';
import 'package:project1/hompage.dart';
import 'package:project1/profile/personal_info.dart';
import 'package:project1/user_account/login.dart';
import 'package:project1/user_account/utils.dart';
import 'firebase_options.dart';
import 'user_account/auth_page.dart';
import '../user_account/verify_email.dart';
import 'profile/education.dart';
import 'profile/skills.dart';
import 'profile/experience.dart';
import 'job_seeker_home_page/jobSeekerHome.dart';
import 'Employers/Employers_account/emp_auth_page.dart';
import 'user_account/rgister.dart';
import './loginOption.dart';
import 'profile/job_seeker_profile.dart';
import 'Employers/home_page/tabs_screen.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyHomePage());
// }
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

// void main() {
//   runApp(MyApp());
// }
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: Utils.messangerKey,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, errorColor: Colors.red),
      home: MyHomePage(),
      routes: {
        AuthPage.routName: (context) => AuthPage(),
        EmpAuthPage.routName: (context) => EmpAuthPage(),
        personal_info.routeName: (context) => personal_info(),
        EducationForm.routeName: (context) => EducationForm(),
        SkillSet.routeName: (context) => SkillSet(),
        Experience.routeName: (context) => Experience(),
        home.routeName: ((context) => home()),
        Register.routeName: (context) => Register(),
        loginOption.routeName: ((context) => loginOption()),
        ProfilePage.routeName: (context) => ProfilePage(),
        EmpRegister.routeName: ((context) => EmpRegister()),
        EmployerRegistrationForm.routeName: ((context) =>
            EmployerRegistrationForm()),
        TabsScreen.routeName: ((context) => TabsScreen()),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  // const MyHomePage({Key? key, required this.title}) : super(key: key);

  //final String title = '';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 0;
  List<int> xx = [1, 2, 3, 4, 5];
  PageController _pageController = PageController(initialPage: 0);
  Container dotIndicator(Index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          color: currentPage == Index ? Colors.amber : Colors.grey,
          shape: BoxShape.circle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(),
            Container(),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: PageView(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                physics: BouncingScrollPhysics(),
                controller: _pageController,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 10,
                      color: Color.fromARGB(255, 18, 211, 224),
                      child: Center(
                          child: Image(
                        image: AssetImage('assets/images/search.jpg'),
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Color.fromARGB(255, 18, 211, 224),
                      child: Center(
                        child: Text(
                          'ddddddd',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Color.fromARGB(255, 18, 211, 224),
                      child: Center(
                        child: Text(
                          'ddddddd',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[for (int i = 0; i < 3; i++) dotIndicator(i)],
            ),
            Container(
              child: Text(
                'Register As',
              ),
            ),
            Container(
              width: 200,
              margin: EdgeInsets.all(20),
              child: FloatingActionButton(
                heroTag: "btn1",
                // clipBehavior: Clip.hardEdge,
                onPressed: () =>
                    Navigator.pushNamed(context, Register.routeName),
                child: Text('JOB SEEKER'),
                // textColor: Colors.white,
                // color: Colors.deepPurple,
                // padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
              ),
            ),
            Container(
              width: 200,
              margin: EdgeInsets.all(20),
              child: FloatingActionButton(
                heroTag: "btn2",
                onPressed: () =>
                    Navigator.pushNamed(context, EmpRegister.routeName),
                child: Text('RECRUITER'),
                // textColor: Colors.white,
                // color: Colors.deepPurple,
                // padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Text('Have an account?'),
                ),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Column(
                      children: [
                        OutlinedButton(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            // shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(50)),
                            onPressed: () => Navigator.pushNamed(
                                context, loginOption.routeName),
                            child: Text(
                              'job seeker Login',
                              style: TextStyle(color: Colors.blue),
                            )),
                        // OutlinedButton(
                        //     // shape: RoundedRectangleBorder(
                        //     //     borderRadius: BorderRadius.circular(50)),
                        //     onPressed: () => Navigator.pushNamed(
                        //         context, EmpAuthPage.routName),
                        //     child: Text(
                        //       'Employer Login',
                        //       style: TextStyle(color: Colors.blue),
                        //     )),
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
