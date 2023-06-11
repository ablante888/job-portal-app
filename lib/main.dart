import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:project1/Employers/Employers_account/emp_register.dart';
import 'package:project1/Employers/Employers_account/emp_verify.dart';
import 'package:project1/Employers/bridgeTOemp_home_page.dart';
import 'package:project1/Employers/emp_profile/emp_form.dart';
import 'package:project1/Employers/home_page/applyers_detail.dart';
import 'package:project1/Employers/home_page/candidateProfile.dart';
import 'package:project1/Employers/home_page/detail_page.dart';
import 'package:project1/Employers/home_page/emp_home_page.dart';
import 'package:project1/Employers/manage_posts/edit_posts.dart';
import 'package:project1/Employers/manage_posts/manage_post.dart';
import 'package:project1/hompage.dart';
import 'package:project1/job_seeker_home_page/applied_jobs.dart';
import 'package:project1/profile/job_seeker_view_profile.dart';
import 'package:project1/profile/personal_info.dart';
import 'package:project1/start_page.dart';
import 'package:project1/user_account/login.dart';
import 'package:project1/user_account/utils.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'jobSeekerModel/job_seeker_profile_model.dart';
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
import 'Employers/home_page/job_post_form.dart';

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
  runApp(JobSeekerProfileWrapper());
}

// void main() {
//   runApp(MyApp());
// }
class JobSeekerProfileWrapper extends StatelessWidget {
  const JobSeekerProfileWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => PersonalInfoProvider()),
        ChangeNotifierProvider.value(value: PersonalInfoProvider()),
        //ChangeNotifierProvider(create: (_) => EducationProvider()),
        ChangeNotifierProvider.value(value: EducationProvider()),
        //ChangeNotifierProvider(create: (_) => ExperienceProvider()),
        ChangeNotifierProvider.value(value: ExperienceProvider()),
        // ChangeNotifierProvider(create: (_) => SkillProvider()),
        // ChangeNotifierProvider.value(value: SkillProvider()),
        // ChangeNotifierProvider(create: (_) => otherProvider()),
        // ChangeNotifierProvider.value(value: otherProvider()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of our application.
  @override
  Widget build(BuildContext context) {
    PersonalInfoProvider personal = Provider.of<PersonalInfoProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: Utils.messangerKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.indigo,
        primarySwatch: Colors.blue,
        backgroundColor: Colors.blue,
        errorColor: Colors.red,
      ),
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
        JobPostingForm.routName: ((context) => JobPostingForm()),
        Manage_posts.routeName: ((context) => Manage_posts()),
        Emp_home.routeName: ((context) => Emp_home()),
        HomePage.routeName: ((context) => HomePage()),
        ApplicantPage.routeName: ((context) => ApplicantPage()),
        EditJobPostingForm.routName: ((context) => EditJobPostingForm()),
        candidateProfile.routeName: ((context) => candidateProfile()),
        StartPage.routName: (context) => StartPage(),
        Applied_jobs_list.routeName: (context) => Applied_jobs_list(),
        VerifyEmpEmail.routeName: (context) => VerifyEmpEmail(),
        // JobDetailPage.routName: (context) => JobDetailPage(),
        //   ProfilePageView.routeName: ((context) => ProfilePageView())
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
        title: Text('Hulu Jobs'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(),
            Container(),
            SizedBox(
              height: 100,
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
                  //assets/images/post2.jpeg
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Color.fromARGB(255, 18, 211, 224),
                      child: Center(
                        child: Image(
                          image: AssetImage('assets/images/post2.jpeg'),
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
                          'All can be done in Hullu Jobs',
                          style: TextStyle(fontSize: 25),
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
                              ' Login',
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
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                      onPressed: () {
                        Navigator.popAndPushNamed(context, home.routeName);
                      },
                      icon: Icon(Icons.skip_next),
                      label: Text('Skip')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
