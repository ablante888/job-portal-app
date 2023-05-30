import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project1/Employers/models/jobs_model.dart';
import 'package:project1/job_seeker_home_page/filter.dart';

import '../Employers/home_page/detail_page.dart';

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
  String selectedCategory = 'All';
  List<String> categories = [
    'All',
    'Region',
    'City',
    'Employment type',
    'Education level',
    'Company name'
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
    'Addiss Ababa',
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
  // void openAdvancedFilterScreen(List items) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Advanced Filter'),
  //         content: Text('This is the advanced filter screen.'),
  //         actions: [
  //           Container(
  //             height: 400,
  //             width: 400,
  //             child: SingleChildScrollView(
  //               child: Column(
  //                 children: [
  //                   SizedBox(
  //                     height: 300, // Adjust the height as needed
  //                     child: GridView.builder(
  //                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                         crossAxisCount: 2,
  //                         mainAxisSpacing: 8,
  //                         crossAxisSpacing: 8,
  //                         childAspectRatio: 1,
  //                       ),
  //                       itemBuilder: (BuildContext context, int index) {
  //                         return GestureDetector(
  //                           onTap: () {
  //                             setState(() {
  //                               // seleceByCategory = true;
  //                               selectedValue = items[index];
  //                             });
  //                             Navigator.of(context).pop();
  //                           },
  //                           child: Container(
  //                             height: 100,
  //                             width: 100,
  //                             alignment: Alignment.center,
  //                             decoration: BoxDecoration(
  //                               color: Colors.grey[200],
  //                               borderRadius: BorderRadius.circular(8),
  //                             ),
  //                             child: Text(
  //                               items[index],
  //                               style: TextStyle(
  //                                 fontSize: 16,
  //                                 fontWeight: FontWeight.w500,
  //                               ),
  //                             ),
  //                           ),
  //                         );
  //                       },
  //                       itemCount: items.length,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Close'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void updateSelectedValue(String value) {
    setState(() {
      selectedValue = value;
    });
  }

  void openAlertDialog(List selectedItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return OverlayScreen(
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
                  crossAxisCount: 1,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1,
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
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        recentJobs[index],
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
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
                                  return openAlertDialog(Regions);
                                case 'City':
                                  return openAlertDialog(cities);
                                case 'Education level':
                                  return openAlertDialog(educationLevel);
                                case 'Employment type':
                                  return openAlertDialog(employmentType);
                                case 'Company name':
                                  return openAlertDialog(companyName);

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
                        },
                        child: Text('Recommended')),
                  ),
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('employers-job-postings')
                  .doc('post-id')
                  .collection('job posting')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading...');
                }

                List<DocumentSnapshot> postedJobs = [];
                if (snapshot.hasData) {
                  QuerySnapshot querySnapshot = snapshot.data!;
                  postedJobs = querySnapshot.docs.toList();
                  // companyName = querySnapshot.docs.where((doc) {
                  //   String company_name = doc['company']['name'];
                  //   return company_name != null;
                  // }).toList();
                  // companyName=postedJobs.where((doc) {});
                }
                if (snapshot.hasData && seleceByCategory == true) {
                  QuerySnapshot querySnapshot = snapshot.data!;
                  postedJobs = querySnapshot.docs.where((doc) {
                    // Filter the jobs by category
                    return doc['job category'] == category;
                  }).toList();
                }
                if (searchQuery.isNotEmpty) {
                  QuerySnapshot querySnapshot = snapshot.data!;
                  List<DocumentSnapshot> allJobs = querySnapshot.docs.toList();

                  postedJobs = allJobs.where((doc) {
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
                // if (dropDownSelected) {
                //  if (selectedCategory == 'All') {}
                if (selectedCategory == 'City') {
                  QuerySnapshot querySnapshot = snapshot.data!;
                  List<DocumentSnapshot> allJobs = querySnapshot.docs.toList();
                  postedJobs = allJobs.where((doc) {
                    String city =
                        doc['company']['city'].toString().toLowerCase();
                    print('city :${city}');
                    // String lowercaseQuery = selectedCategory.toLowerCase();
                    return city == selectedValue.toLowerCase();
                  }).toList();
                }

                if (selectedCategory == 'Employment type') {
                  QuerySnapshot querySnapshot = snapshot.data!;
                  List<DocumentSnapshot> allJobs = querySnapshot.docs.toList();
                  postedJobs = allJobs.where((doc) {
                    String emplyment_type =
                        doc['employment type'].toString().toLowerCase();

                    //  String lowercaseQuery = selectedCategory.toLowerCase();
                    return emplyment_type == selectedValue.toLowerCase();
                  }).toList();
                }
                if (selectedCategory == 'Education level') {
                  QuerySnapshot querySnapshot = snapshot.data!;
                  List<DocumentSnapshot> allJobs = querySnapshot.docs.toList();
                  postedJobs = allJobs.where((doc) {
                    String education_level =
                        doc['education level'].toString().toLowerCase();

                    return education_level == selectedValue.toLowerCase();
                  }).toList();
                }
                if (selectedCategory == 'Company name') {
                  QuerySnapshot querySnapshot = snapshot.data!;
                  List<DocumentSnapshot> allJobs = querySnapshot.docs.toList();
                  postedJobs = allJobs.where((doc) {
                    String company_name =
                        doc['company']['name'].toString().toLowerCase();

                    return company_name == selectedValue.toLowerCase();
                  }).toList();
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
                                trailing: Container(
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
