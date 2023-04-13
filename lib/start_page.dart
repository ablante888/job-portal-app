import 'package:flutter/material.dart';
import 'user_account/auth_page.dart';
import 'Employers/Employers_account/emp_auth_page.dart';

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
      body: Center(
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
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, AuthPage.routName),
                child: Text('JOB SEEKER'),
                // textColor: Colors.white,
                // color: Colors.deepPurple,
                // padding: EdgeInsets.all(20),
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(50)),
              ),
            ),
            Container(
              width: 200,
              margin: EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, EmpAuthPage.routName),
                child: Text('RECRUITER'),
                // textColor: Colors.white,
                // color: Colors.deepPurple,
                // padding: EdgeInsets.all(20),
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(50)),
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
                    child: ElevatedButton(
                        clipBehavior: Clip.antiAlias,
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(50)),
                        onPressed: () =>
                            Navigator.pushNamed(context, EmpAuthPage.routName),
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.blue),
                        ))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
