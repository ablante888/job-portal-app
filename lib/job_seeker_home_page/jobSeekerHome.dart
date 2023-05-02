//import 'dart:html';

//import 'dart:html';
//import 'dart:html';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project1/profile/job_seeker_profile.dart';

class home extends StatefulWidget {
  static const routeName = '/home';
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  File? image;
  final List<String> recentJobs = [
    "Software Engineer",
    "UI/UX Designer",
    "Data Analyst",
    "Product Manager",
    "Marketing Specialist",
  ];

  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    JobsList(),
    SavedJobs(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    image = ModalRoute.of(context)?.settings.arguments as File?;
    print(image?.path);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Ablante Daniel"),
              accountEmail: Text("ablantedaniel@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "AD",
                  style: TextStyle(fontSize: 28),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("My Profile"),
              //  onTap: () {},
              onTap: () => Navigator.pushNamed(context, ProfilePage.routeName),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text("Saved Jobs"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text("Job Alerts"),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Help & Support"),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('home'),
        actions: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/images/profile2.jpeg'),
          ),
          SizedBox(
            width: 5,
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Icon(
                    Icons.search,
                    color: Colors.grey[400],
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search for products",
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.deepPurpleAccent,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 16),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 120,
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 8),
              scrollDirection: Axis.horizontal,
              itemCount: recentJobs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  // width: MediaQuery.of(context).size.width / 2,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    recentJobs[index],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Saved Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurpleAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}

class JobsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Jobs List",
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class SavedJobs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Saved Jobs",
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Profile",
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
