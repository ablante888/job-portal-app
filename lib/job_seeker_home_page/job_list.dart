import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project1/Employers/models/jobs_model.dart';
import 'package:project1/job_seeker_home_page/filter.dart';

import '../Employers/home_page/detail_page.dart';
import 'package:rxdart/rxdart.dart';

class JobsList extends StatefulWidget {
  @override
  State<JobsList> createState() => _JobsListState();
}

class _JobsListState extends State<JobsList> {
  List<DocumentSnapshot<Object?>> filtered_Jobs = [];
  List<DocumentSnapshot<Object?>> postedJobs = [];
  List filteredJobsByCategory = [];
  bool dropDownSelected = false;
  var selectedValue;
  List recommendedJobs = [];
  bool selectRecommended = false;
  String selectedCategory = 'All';
  List<String> categories = [
    'All',
    'Region',
    'City',
    'Employment type',
    'Education level',
  ];

  bool seleceByCategory = false;
  var category;
  bool isJobTitleMatched = false;
  String searchQuery = '';
  final searchController = TextEditingController();
  void searchJobs(String query) {
    filtered_Jobs = postedJobs.where((job) {
      String jobTitle = job['title'].toLowerCase() as String;
      final input = query.toLowerCase();
      return jobTitle.contains(input);
    }).toList();
    setState(() {
      postedJobs = filtered_Jobs;
      isJobTitleMatched = true;
    });
    // }
  }

  void showFilterOption(BuildContext context) {
    DropdownButton<String>(
      value: selectedCategory,
      onChanged: (newValue) {
        setState(() {
          selectedCategory = newValue!;
        });
      },
      items: categories.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  final List<String> recentJobs = [
    "Engineering",
    "Agriculture",
    "Technology",
    "social",
    "health",
  ];
  final List<String> Regions = [
    'Amhara',
    'Oromia',
    'South nations',
    'Afar',
    'Harari',
    'Benishangul gumuz',
    'Gambela',
    'Tigray',
    'Somalia',
    'Sidamo'
  ];

  final List<String> educationLevel = ['Bachelor', 'MSC', 'PHD'];
  final List<String> employmentType = ['Full time', 'Partime', 'remote'];
  List companyName = [];
  final List<String> cities = [
    'Bahirdar',
    'Gonder',
    'Addis Ababa',
    'Mekele',
    'Dere Dawa',
    'Hawasa',
    'Dessie',
    'jigjiga',
    'Jimma',
    'shashemene'
  ];

  String getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }

  File? image;
  void filterByCategory(String category) {
    final postedJobs = FirebaseFirestore.instance
        .collection('employers-job-postings')
        .doc('post-id')
        .collection('job posting')
        .snapshots();
    postedJobs.map((snapshot) {
      snapshot.docs.map((job) {
        if (category == job['job category']) {
          filteredJobsByCategory.add(job);
        }
      });
    });
    //.data!.docs.map((DocumentSnapshot document)
    print('this is the list of jobs filtered ${filteredJobsByCategory}');
  }

  bool isFilterVisible = false;
  void toggleFilterVisibility() {
    setState(() {
      isFilterVisible = !isFilterVisible;
    });
  }

  List<QueryDocumentSnapshot> filteredJobs = [];

  void updateSelectedValue(String value, bool abc) {
    setState(() {
      selectedValue = value;
    });
  }

  void openAlertDialog(List selectedItem, IconData? icon) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return OverlayScreen(
          icon: icon,
          callback: updateSelectedValue,
          items: selectedItem,
        );
      },
    );
  }

  String getPostedTime(Timestamp postedDate) {
    final now = DateTime.now();
    final difference = now.difference(postedDate.toDate());

    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    print('selected value is :${selectedValue}');
    print('selected category value is :${selectedCategory}');
    image = ModalRoute.of(context)?.settings.arguments as File?;
    //  print(image?.path);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                      controller: searchController,
                      onChanged: (value) {
                        //  searchJobs(value);
                        setState(() {
                          searchQuery = value;

                          isJobTitleMatched = true;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Search by Title,category,location",
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
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        searchController.clear();
                        setState(() {
                          isJobTitleMatched = false;
                        });
                      },
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
              height: 100,
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 8),
                scrollDirection: Axis.horizontal,
                itemCount: recentJobs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  // crossAxisCount: 1,
                  // mainAxisSpacing: 8,
                  // childAspectRatio: 1,
                  crossAxisCount: 1,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        seleceByCategory = true;
                        category = recentJobs[index];
                      });
                    },
                    child: Container(
                      // width: MediaQuery.of(context).size.width / 2,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        // color: Colors.blue,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 51, 224, 255), // Start color
                            Color.fromARGB(255, 55, 0, 255), // End color
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        recentJobs[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            isJobTitleMatched = false;
                            seleceByCategory = false;
                            selectRecommended = false;
                          });
                        },
                        child: Text('See all')),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.filter_list),
                          onPressed: toggleFilterVisibility,
                        ),
                        Visibility(
                          visible: isFilterVisible,
                          child: DropdownButton<String>(
                            value: selectedCategory,
                            onChanged: (newValue) {
                              setState(() {
                                selectedCategory = newValue!;
                                dropDownSelected = true;
                              });
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => OverlayScreen()),
                              // );

                              switch ('${selectedCategory}') {
                                case 'All':
                                  return null;
                                case 'Region':
                                  return openAlertDialog(Regions, Icons.public);
                                case 'City':
                                  return openAlertDialog(
                                      cities, Icons.location_city);
                                case 'Education level':
                                  return openAlertDialog(
                                      educationLevel, Icons.school);
                                case 'Employment type':
                                  return openAlertDialog(
                                      employmentType, Icons.work);
                                // case 'Company name':
                                //   return openAlertDialog(
                                //       companyName, Icons.business);

                                default:
                                  return null;
                              }
                            },
                            items: categories
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextButton(
                        onPressed: () {
                          final profile = FirebaseFirestore.instance
                              .collection('job-seeker')
                              .doc(getCurrentUserUid())
                              .collection('jobseeker-profile')
                              .doc('profile')
                              .snapshots();
                          setState(() {
                            selectRecommended = true;
                          });
                        },
                        child: Text('Recommended')),
                  ),
                ],
              ),
            ),
            StreamBuilder<List<dynamic>>(
              stream: CombineLatestStream.list([
                FirebaseFirestore.instance
                    .collection('job-seeker')
                    .doc(getCurrentUserUid())
                    .collection('jobseeker-profile')
                    .doc('profile')
                    .snapshots(),
                FirebaseFirestore.instance
                    .collection('employers-job-postings')
                    .doc('post-id')
                    .collection('job posting')
                    .snapshots(),
              ]),
              builder: (BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading...');
                }
                DocumentSnapshot profileData =
                    snapshot.data?[0]; // Get the profile data
                Map<String, dynamic>? otherData =
                    (profileData.data() as Map<String, dynamic>)['other-data']
                        as Map<String, dynamic>?;
                //   print('other data is ${otherData}');
                // Map<String, dynamic>? otherData = snapshot.data?[0]
                //     .data()!['other-data'] as Map<String, dynamic>?;
                Map<String, dynamic>? personalInfo = snapshot.data?[0]!
                    .data()?['personal-info'] as Map<String, dynamic>?;
                // print('personal info is ${personalInfo}');
                Map<String, dynamic>? skills = snapshot.data?[0]!
                    .data()?['skills'] as Map<String, dynamic>?;
                // final List<dynamic> languageSkills =
                //     snapshot.data?[0]!.data()?['skills']['language skills'] ??
                //         [];
                // final List<dynamic> personalSkills =
                //     snapshot.data?[0]!.data()?['skills']['personal skills'] ??
                //         [];
                // final List<dynamic> professionalSkills = snapshot.data?[0]!
                //         .data()?['skills']['professional skills'] ??
                //     [];
                // Map<String, dynamic>? experience =
                //     snapshot.data?[0]!.data()?['experiences']['experience']
                //         as Map<String, dynamic>?;
                Map<String, dynamic>? education = snapshot.data?[0]!
                    .data()?['education'] as Map<String, dynamic>?;
                QuerySnapshot jobPostings = snapshot.data?[1];
                if (jobPostings != null && jobPostings.docs.isNotEmpty) {
                  // Access the job postings documents
                  postedJobs = jobPostings.docs.toList();
                }
                if (jobPostings != null &&
                    jobPostings.docs.isNotEmpty &&
                    seleceByCategory == true) {
                  List<QueryDocumentSnapshot> AllpostedJobs =
                      jobPostings.docs.toList();
                  //  print(AllpostedJobs.first.data());
                  // QuerySnapshot querySnapshot = snapshot.data!;
                  postedJobs = AllpostedJobs.where((doc) {
                    // Filter the jobs by category
                    return doc['job category'] == category;
                  }).toList();
                }
                //search field operation
                if (searchQuery.isNotEmpty) {
                  // QuerySnapshot querySnapshot = snapshot.data!;

                  //  List<DocumentSnapshot> allJobs = querySnapshot.docs.toList();
                  List<QueryDocumentSnapshot> AllpostedJobs =
                      jobPostings.docs.toList();
                  postedJobs = AllpostedJobs.where((doc) {
                    String title = doc['title'].toString().toLowerCase();
                    String location = doc['location'].toString().toLowerCase();
                    String category =
                        doc['job category'].toString().toLowerCase();

                    String lowercaseQuery = searchQuery.toLowerCase();
                    return title.contains(lowercaseQuery) ||
                        location.contains(lowercaseQuery) ||
                        category.contains(lowercaseQuery);
                  }).toList();
                  // }
                }
                // List<QueryDocumentSnapshot> postedJobs = jobPostingsSnapshot.docs;
                List<QueryDocumentSnapshot> recommendedJobs = [];
                if (selectRecommended) {
                  List<QueryDocumentSnapshot> AllpostedJobs =
                      jobPostings.docs.toList();
                  postedJobs = AllpostedJobs.where((doc) {
                    String jobTitle =
                        doc['title'].toString().toLowerCase().trim();
                    String location =
                        doc['location'].toString().toLowerCase().trim();
                    String educationLevel =
                        doc['education level'].toString().toLowerCase();

                    String experienceLevel =
                        doc['experience level'].toString().toLowerCase();
                    print(
                        'education level required is: ${otherData?['Experience level'].toString().toLowerCase()}');
                    print('education level required is: ${experienceLevel}');
                    print('education level required is: ${jobTitle}');
                    print(
                        'education level required is: ${otherData?['preferred job'].toString().toLowerCase()}');
                    String salary = doc['salary'].toString().toLowerCase();
                    //  String category =
                    //     doc['job category'].toString().toLowerCase().trim();
                    print(
                        'boolian value is : ${jobTitle == otherData?['preferred job'].toString().toLowerCase() && experienceLevel == otherData?['Experience level'].toString().toLowerCase()}');
                    bool isMatching = (jobTitle ==
                            otherData?['preferred job']
                                ?.toString()
                                .toLowerCase()) &&
                        (experienceLevel ==
                            otherData?['experience level']
                                ?.toString()
                                .toLowerCase());

                    print('boolean value is: $isMatching');
                    String lowercaseQuery = searchQuery.toLowerCase();
                    return jobTitle ==
                                otherData?['preferred job']
                                    .toString()
                                    .toLowerCase()
                                    .replaceAll(' ', '') &&
                            location ==
                                personalInfo?['city']
                                    .toString()
                                    .toLowerCase()
                                    .replaceAll(' ', '') ||
                        jobTitle ==
                                otherData?['preferred job']
                                    .toString()
                                    .toLowerCase() &&
                            educationLevel == education?['levelOfEducation'] ||
                        jobTitle ==
                                otherData?['preferred job']
                                    .toString()
                                    .toLowerCase() &&
                            experienceLevel == otherData?['Experience level'] ||
                        //if all are matched
                        jobTitle == otherData?['preferred job'] &&
                            salary == otherData?['Expected salary'] ||
                        jobTitle == otherData?['preferred job'] &&
                            location == personalInfo?['city'] &&
                            educationLevel == education?['levelOfEducation'] &&
                            experienceLevel == otherData?['Experience level'] &&
                            salary == otherData?['Expected salary'];
                  }).toList();
                }
                print('this is posted jobs data : ${postedJobs}');
                if (selectedCategory == 'City') {
                  List<QueryDocumentSnapshot> AllpostedJobs =
                      jobPostings.docs.toList();
                }
                // if (dropDownSelected) {
                //  if (selectedCategory == 'All') {}
                if (selectedCategory == 'City') {
                  // QuerySnapshot querySnapshot = snapshot.data!;
                  // List<DocumentSnapshot> allJobs = querySnapshot.docs.toList();
                  List<QueryDocumentSnapshot> AllpostedJobs =
                      jobPostings.docs.toList();
                  postedJobs = AllpostedJobs.where((doc) {
                    String city = doc['location']
                        .toString()
                        .toLowerCase()
                        .replaceAll(' ', '');
                    print('city :${city}');
                    // String lowercaseQuery = selectedCategory.toLowerCase();
                    return city ==
                        selectedValue
                            .toString()
                            .toLowerCase()
                            .replaceAll(' ', '');
                  }).toList();
                }

                if (selectedCategory == 'Employment type') {
                  // QuerySnapshot querySnapshot = snapshot.data!;
                  // List<DocumentSnapshot> allJobs = querySnapshot.docs.toList();
                  List<QueryDocumentSnapshot> AllpostedJobs =
                      jobPostings.docs.toList();
                  postedJobs = AllpostedJobs.where((doc) {
                    String emplyment_type =
                        doc['employment type'].toString().toLowerCase();

                    //  String lowercaseQuery = selectedCategory.toLowerCase();
                    return emplyment_type == selectedValue.toLowerCase();
                  }).toList();
                }
                if (selectedCategory == 'Education level') {
                  // QuerySnapshot querySnapshot = snapshot.data!;
                  // List<DocumentSnapshot> allJobs = querySnapshot.docs.toList();
                  List<QueryDocumentSnapshot> AllpostedJobs =
                      jobPostings.docs.toList();
                  postedJobs = AllpostedJobs.where((doc) {
                    String education_level =
                        doc['education level'].toString().toLowerCase();

                    return education_level == selectedValue.toLowerCase();
                  }).toList();
                }

                if (selectedCategory == 'Company name') {
                  // QuerySnapshot querySnapshot = snapshot.data!;
                  // List<DocumentSnapshot> allJobs = querySnapshot.docs.toList();
                  List<QueryDocumentSnapshot> AllpostedJobs =
                      jobPostings.docs.toList();
                  postedJobs = AllpostedJobs.where((doc) {
                    String company_name =
                        doc['company']['name'].toString().toLowerCase();

                    return company_name == selectedValue.toLowerCase();
                  }).toList();
                }
                if (selectRecommended) {
                  Stream<DocumentSnapshot<Map<String, dynamic>>> abc =
                      FirebaseFirestore.instance
                          .collection('job-seeker')
                          .doc(getCurrentUserUid())
                          .collection('jobseeker-profile')
                          .doc('profile')
                          .snapshots();

                  abc.listen((DocumentSnapshot<Map<String, dynamic>> snapshot) {
                    if (snapshot.exists) {
                      Map<String, dynamic> data = snapshot.data()!;

                      // Accessing individual fields
                      String name = data['name'];
                      String email = data['email'];
                      int age = data['age'];
                      List<String> skills = List<String>.from(data['skills']);

                      // Do something with the fields
                      print('Name: $name');
                      print('Email: $email');
                      print('Age: $age');
                      print('Skills: $skills');

                      // You can also pass the data to your recommendation function
                      //  recommendJob(data);
                    }
                  });
                }

                return SafeArea(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height - 400,
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        itemCount: postedJobs.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot document = postedJobs[index];

                          return GestureDetector(
                            onTap: () {
                              // Navigator.pushNamed(
                              //     context, JobDetailPage.routName,
                              //     arguments: document);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JobDetailPage(
                                    index: index,
                                    job: document,
                                  ),
                                  settings:
                                      RouteSettings(name: "jobDetailRoute"),
                                ),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  // side:
                                  //     BorderSide(color: Colors.black, width: 1),
                                  // borderRadius: BorderRadius.circular(15),
                                  borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              )),
                              elevation: 5,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              child: ListTile(
                                style: ListTileStyle.drawer,
                                leading: CircleAvatar(
                                  child: Icon(Icons.person),
                                ),
                                title: Text(document['title']),
                                subtitle: Row(
                                  children: [
                                    Chip(
                                      label: Text(document['employment type']),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Chip(
                                      label: Container(
                                          width: 40,
                                          child: Text(
                                              document['experience level'])),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Chip(
                                      label: Container(
                                          width: 50,
                                          child: Text(
                                              document['company']['city'])),
                                    ),
                                  ],
                                ),
                                trailing: Flexible(
                                  fit: FlexFit.loose,
                                  child: Container(
                                    height: 20,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5.0,
                                      horizontal: 5.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Text(
                                      getPostedTime(document['posted time']),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class converToDate {
  static const DATE_FORMAT = 'dd/MM/yyyy';
  String formattedDate(DateTime dateTime) {
    print('dateTime ($dateTime)');
    return DateFormat(DATE_FORMAT).format(dateTime);
  }
}
