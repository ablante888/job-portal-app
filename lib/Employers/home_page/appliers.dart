import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project1/Employers/home_page/applyers_detail.dart';
import 'package:project1/job_seeker_home_page/filter.dart';

import '../../jobSeekerModel/job_seeker_profile_model.dart';

enum SortBy { Relevance, Experience, ApplicationDate }

enum ViewMode { Grid, List }

class Appliers extends StatefulWidget {
  String jobId;

  Appliers({
    Key? key,
    required this.jobId,
  }) : super(key: key);

  @override
  State<Appliers> createState() => _AppliersState();
}

class _AppliersState extends State<Appliers> {
  String selectedCategory = 'All';
  bool isFilterVisible = false;
  void toggleFilterVisibility() {
    setState(() {
      isFilterVisible = !isFilterVisible;
    });
  }

  List<QueryDocumentSnapshot> filteredJobs = [];
  bool dropDownSelected = false;
  var selectedValue;

  final searchController = TextEditingController();
  String searchQuery = '';
  List<String> categories = [
    'All',
    'Region',
    'City',
    'Education level',
    'salary Expectation',
    'Experience level',
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
  bool isFilterOptionSelected = false;
  void updateSelectedValue(String value, bool isSelected) {
    setState(() {
      selectedValue = value;
      isFilterOptionSelected = isSelected;
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

  final List<String> educationLevel = ['Bachelor', 'MSC', 'PHD'];
  final List<String> employmentType = ['Full time', 'Partime', 'remote'];
  List companyName = [];
  final List<String> salaryExpectation = [
    '>2000',
    '>3000',
    '>5000',
    '>10000',
    '>20000',
  ];
  final List<String> ExperienceLevel = [
    'fresh',
    '1 year',
    '2 years',
    '3 years',
    '5 years',
    '10 years',
    'above 10 '
  ];
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
  SortBy _filterBy = SortBy.Relevance;
  ViewMode _viewMode = ViewMode.List;

  // void _showSortOptions() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Sort By'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             ListTile(
  //               title: Text('Region'),
  //               leading: Radio(
  //                 value: SortBy.Relevance,
  //                 groupValue: _filterBy,
  //                 onChanged: (SortBy? value) {
  //                   setState(() {
  //                     _filterBy = value!;
  //                   });
  //                   switch ('${_filterBy}') {
  //                     case 'All':
  //                       return null;
  //                     case 'Region':
  //                       return openAlertDialog(Regions);
  //                     case 'City':
  //                       return openAlertDialog(cities);
  //                     case 'Education level':
  //                       return openAlertDialog(educationLevel);
  //                     case 'Employment type':
  //                       return openAlertDialog(employmentType);
  //                     case 'Company name':
  //                       return openAlertDialog(companyName);

  //                     default:
  //                       return null;
  //                   }
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ),
  //             ListTile(
  //               title: Text('Experience'),
  //               leading: Radio(
  //                 value: SortBy.Experience,
  //                 groupValue: _filterBy,
  //                 onChanged: (SortBy? value) {
  //                   setState(() {
  //                     _filterBy = value!;
  //                   });
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ),
  //             ListTile(
  //               title: Text('City'),
  //               leading: Radio(
  //                 value: SortBy.ApplicationDate,
  //                 groupValue: _filterBy,
  //                 onChanged: (SortBy? value) {
  //                   setState(() {
  //                     _filterBy = value!;
  //                   });
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget build(BuildContext context) {
    CollectionReference applicantsRef = FirebaseFirestore.instance
        .collection('employers-job-postings')
        .doc('post-id')
        .collection('job posting')
        .doc(widget.jobId)
        .collection('Applicants');
    Stream<QuerySnapshot> applicantsSnapshotStream = FirebaseFirestore.instance
        .collection('employers-job-postings')
        .doc('post-id')
        .collection('job posting')
        .doc(widget.jobId)
        .collection('Applicants')
        .snapshots();
    // getDataStream();
    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   Row(
        //     children: [
        //       Text('Sort option'),
        //       IconButton(onPressed: _showSortOptions, icon: Icon(Icons.sort)),
        //     ],
        //   )
        // ],
        title: Text('Applicants'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('employers-job-postings')
              .doc('post-id')
              .collection('job posting')
              .doc(widget.jobId)
              .collection('Applicants')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            if (!snapshot.hasData) return Text('OOPS there is no posted jobs');
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading...');
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 7,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Applicants'),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.yellow),
                          child: Center(
                              child: Text('${snapshot.data!.docs.length}')),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * (3 / 4) - 70,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 16),
                          child: TextField(
                            controller: searchController,
                            onChanged: (value) {
                              //  searchJobs(value);
                              setState(() {
                                searchQuery = value;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Search applicants',
                              prefixIcon: Icon(Icons.search),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),

                            // Implement search functionality
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            // IconButton(
                            //   icon: Icon(Icons.filter_list),
                            //   onPressed: toggleFilterVisibility,
                            // ),
                            Visibility(
                              visible: isFilterVisible,
                              child: DropdownButton<String>(
                                borderRadius: BorderRadius.circular(15),
                                style: TextStyle(color: Colors.white),
                                dropdownColor: Colors.blue,
                                hint: Text('Filter applicants'),
                                elevation: 30,
                                icon: Icon(Icons.filter),
                                isDense: false,
                                //  value: selectedCategory,
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

                                  switch (selectedCategory) {
                                    case 'All':
                                      return null;
                                    case 'Region':
                                      return openAlertDialog(
                                          Regions, Icons.public);
                                    case 'City':
                                      return openAlertDialog(
                                          cities, Icons.location_city);
                                    case 'Education level':
                                      return openAlertDialog(
                                          educationLevel, Icons.school);
                                    case 'salary Expectation':
                                      return openAlertDialog(
                                          salaryExpectation, Icons.work);
                                    case 'Experience level':
                                      return openAlertDialog(
                                          ExperienceLevel, Icons.business);

                                    default:
                                      return null;
                                  }
                                },
                                items: categories.map<DropdownMenuItem<String>>(
                                    (String value) {
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
                    ],
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('employers-job-postings')
                        .doc('post-id')
                        .collection('job posting')
                        .doc(widget.jobId)
                        .collection('Applicants')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      if (!snapshot.hasData)
                        return Text('OOPS there is no posted jobs');
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text('Loading...');
                      }
                      List<DocumentSnapshot> appliers = [];
                      if (snapshot.hasData) {
                        QuerySnapshot querySnapshot = snapshot.data!;
                        appliers = querySnapshot.docs.toList();
                      }
                      if (searchQuery.isNotEmpty) {
                        QuerySnapshot querySnapshot = snapshot.data!;
                        List<DocumentSnapshot> allAppliers =
                            querySnapshot.docs.toList();

                        appliers = allAppliers.where((doc) {
                          String fieldOfStudy = doc['education']['fieldOfStudy']
                              .toString()
                              .toLowerCase();
                          String gender = doc['personal-info']['gender']
                              .toString()
                              .toLowerCase();
                          String location = doc['personal-info']['city']
                              .toString()
                              .toLowerCase();

                          String lowercaseQuery = searchQuery.toLowerCase();
                          return fieldOfStudy.contains(lowercaseQuery) ||
                              gender.contains(lowercaseQuery) ||
                              location.contains(lowercaseQuery);
                        }).toList();
                        // }
                      }
                      if (isFilterOptionSelected) {
                        if (selectedCategory == 'City') {
                          QuerySnapshot querySnapshot = snapshot.data!;
                          List<DocumentSnapshot> allAppliers =
                              querySnapshot.docs.toList();
                          appliers = allAppliers.where((doc) {
                            String city = doc['personal-info']['city']
                                .toString()
                                .toLowerCase();
                            print('city :${city}');
                            // String lowercaseQuery = selectedCategory.toLowerCase();
                            return city == selectedValue.toLowerCase();
                          }).toList();
                        }
                        if (selectedCategory == 'Education level') {
                          QuerySnapshot querySnapshot = snapshot.data!;
                          List<DocumentSnapshot> allAppliers =
                              querySnapshot.docs.toList();
                          appliers = allAppliers.where((doc) {
                            String levelOfEducation = doc['education']
                                    ['levelOfEducation']
                                .toString()
                                .toLowerCase();

                            //  String lowercaseQuery = selectedCategory.toLowerCase();
                            return levelOfEducation ==
                                selectedValue.toLowerCase();
                          }).toList();
                        }
                        if (selectedCategory == 'salary Expectation') {
                          QuerySnapshot querySnapshot = snapshot.data!;
                          List<DocumentSnapshot> allAppliers =
                              querySnapshot.docs.toList();
                          appliers = allAppliers.where((doc) {
                            String salaryExpectation = doc['other-data']
                                    ['Expected salary']
                                .toString()
                                .toLowerCase();

                            return salaryExpectation ==
                                selectedValue.toLowerCase();
                          }).toList();
                        }
                        if (selectedCategory == 'Experience level') {
                          QuerySnapshot querySnapshot = snapshot.data!;
                          List<DocumentSnapshot> allAppliers =
                              querySnapshot.docs.toList();
                          appliers = allAppliers.where((doc) {
                            String company_name = doc['other-data']
                                    ['Experience level']
                                .toString()
                                .toLowerCase();

                            return company_name == selectedValue.toLowerCase();
                          }).toList();
                        }
                      }

                      return SafeArea(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 600,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  itemCount: appliers.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    DocumentSnapshot document = appliers[index];

                                    return Card(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      child: new ListTile(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        style: ListTileStyle.drawer,
                                        leading: CircleAvatar(
                                          child: Icon(Icons.person),
                                        ),
                                        //  trailing: new Text(document['job category']),
                                        title: new Text(document['education']
                                            ['institution']),
                                        subtitle: Container(
                                            width: 20,
                                            child: new Text(
                                                document['education']
                                                    ['fieldOfStudy'])),
                                        trailing: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                ApplicantPage.routeName,
                                                arguments: [
                                                  document['personal-info']
                                                      ['id'],
                                                  widget.jobId
                                                ]);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Center(
                                                child: Text(
                                              'View Profile',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                            width: 100,
                                            height: 40,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }),
    );
  }
}
