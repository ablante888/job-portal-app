import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project1/job_seeker_home_page/jobSeekerHome.dart';
import 'package:project1/user_account/utils.dart';
import 'package:provider/provider.dart';
import '../jobSeekerModel/job_seeker_profile_model.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Employers/emp_profile/compLogo_Picker.dart';
import './education.dart';
import './experience.dart';
import './personal_info.dart';
import 'package:uuid/uuid.dart';
// class JobSeekerProfileWrapper extends StatelessWidget {
//   const JobSeekerProfileWrapper({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => PersonalInfoProvider()),
//         ChangeNotifierProvider(create: (_) => EducationProvider()),
//         ChangeNotifierProvider(create: (_) => ExperienceProvider()),
//         ChangeNotifierProvider(create: (_) => SkillProvider()),
//       ],
//       child: SkillSet(),
//     );
//   }
// }

class SkillSet extends StatefulWidget {
  //const SkillSet({Key? key}) : super(key: key);
  static const routeName = '/SkillSet';

  @override
  State<SkillSet> createState() => _SkillSetState();
}

class _SkillSetState extends State<SkillSet> {
  final List<String> salaryExpectation = [
    '>2000',
    '>3000',
    '>5000',
    '>10000',
    '>20000'
  ];
  List experienceLevel = [
    'Fresh',
    '2 years',
    '3 years',
    '5 years',
    '10 years',
    '> 10 years'
  ];
  var experienceLevelChoosed;
  var salaryLevelChoosed;
  String? _jobPreference;
  String? uid;
  File? _image;
  String? _imageUrl;
  List<String> personalSkill = [];
  List<String> proffesionalSkill = [];
  List<String> languageSkill = [];
  List<String> achivSkill = [];
  String about = '';
  final _formKey = GlobalKey<FormState>();
  final profSkillController = TextEditingController();
  final persSkillController = TextEditingController();
  final langSkillController = TextEditingController();
  final achivSkillController = TextEditingController();
  String profileId = '';
  void _onImageSelected(File image) {
    setState(() {
      _image = image;
      //  _imageUrl = Url;
    });
  }

  void _addProffSkill(String skill) {
    if (!proffesionalSkill.contains(skill)) {
      setState(() {
        proffesionalSkill.add(skill);
      });
    }
  }

  void _removeproffSkill(String skill) {
    setState(() {
      proffesionalSkill.remove(skill);
    });
  }

  void _addPersonalSkill(String skill) {
    if (!personalSkill.contains(skill)) {
      setState(() {
        personalSkill.add(skill);
      });
    }
  }

  void _removePersonalSkill(String skill) {
    setState(() {
      personalSkill.remove(skill);
    });
  }

  void _addLanguageSkill(String skill) {
    if (!languageSkill.contains(skill)) {
      setState(() {
        languageSkill.add(skill);
      });
    }
  }

  // void addLanguageSkill(List skills, Function addSkill) {}
  void _removeLanguageSkill(String skill) {
    setState(() {
      languageSkill.remove(skill);
    });
  }

  void _addAchivSkill(String skill) {
    if (!achivSkill.contains(skill)) {
      setState(() {
        achivSkill.add(skill);
      });
    }
  }

  //void addAchivSkill(List skills, Function addSkill) {}
  void _removeAchivSkill(String skill) {
    setState(() {
      achivSkill.remove(skill);
    });
  }

  User? user = FirebaseAuth.instance.currentUser;

  String getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
      return user.uid;
    } else {
      return '';
    }
  }

  final user_reference = FirebaseFirestore.instance.collection('job-seeker');
  Future saveSkillInfo(Skill job_seeker_skill) async {
    final personal_info_doc_ref = user_reference.doc(getCurrentUserUid());
    final json = job_seeker_skill.toJson();
    await personal_info_doc_ref
        .collection('jobseeker-profile')
        .doc('profile')
        .set({'skills': json}, SetOptions(merge: true));
  }

  Future saveOtherInfo(Other other_info) async {
    final personal_info_doc_ref = user_reference.doc(getCurrentUserUid());
    final json = other_info.toJson();
    await personal_info_doc_ref
        .collection('jobseeker-profile')
        .doc('profile')
        .set({'other-data': json}, SetOptions(merge: true));
  }

  String? _uploadedFileURL;

  Future<void> _uploadFile() async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final Reference reference =
        storage.ref().child('images/jobSeekers/$fileName');
    final UploadTask uploadTask = reference.putFile(_image!);
    final TaskSnapshot downloadUrl = (await uploadTask);
    final String url = (await downloadUrl.ref.getDownloadURL());
    setState(() {
      _uploadedFileURL = url;
      _imageUrl = _uploadedFileURL;
    });
    print(_imageUrl);
  }

  void createProfileId() {
    var uuid = Uuid();
    profileId = uuid.v4();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> writeJobSeekerProfile(JobSeekerProfile jobSeekerProfile) async {
    final personalInfoMap = jobSeekerProfile.personalInfo.toJson();
    //final educationMap = jobSeekerProfile.education.toJson();
    //final experienceMap = jobSeekerProfile.experience.toJson();
    // final skillMap = jobSeekerProfile.skills.toJson();
    // final otherMap = jobSeekerProfile.otherInfo.toJson();
    createProfileId();
    try {
      await firestore
          .collection('job-seeker')
          .doc(user!.uid)
          .collection('profile')
          .doc(profileId)
          .set({
        'profile id': profileId,
        'personal_info': personalInfoMap,
        // 'education': educationMap,
        //'experience': experienceMap,
        // 'skills': skillMap,
        // 'about me': otherMap,
      });
    } catch (e) {
      print('Error writing JobSeekerProfile to Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Skills'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Text(
                  'Share your skills with us',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.blue),
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
                  // padding: EdgeInsets.only(
                  //     left: 60.0, right: 10.0, top: 10.0, bottom: 10.0),
                  width: MediaQuery.of(context).size.width * 4 / 5,
                  child: TextFormField(
                    // onSubmitted: _addProffSkill,
                    controller: profSkillController,
                    decoration: InputDecoration(
                      label: Text(' Professional skills'),
                      suffixIcon: IconButton(
                          onPressed: () {
                            _addProffSkill(profSkillController.text);
                            profSkillController.clear();
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.pink,
                          )),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: [
                    ...proffesionalSkill.map(
                      (skill) => Chip(
                        label: Text(skill),
                        onDeleted: () => _removeproffSkill(skill),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
                  // padding: EdgeInsets.only(
                  //     left: 60.0, right: 10.0, top: 10.0, bottom: 10.0),
                  width: MediaQuery.of(context).size.width * 4 / 5,
                  child: TextFormField(
                    // onChanged: _addPersonalSkill,
                    controller: persSkillController,
                    decoration: InputDecoration(
                      label: Text(' personal skills'),
                      suffixIcon: IconButton(
                          onPressed: () {
                            _addPersonalSkill(persSkillController.text);
                            persSkillController.clear();
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.pink,
                          )),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: [
                    ...personalSkill.map(
                      (skill) => Chip(
                        label: Text(skill),
                        onDeleted: () => _removePersonalSkill(skill),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
                  // padding: EdgeInsets.only(
                  //     left: 60.0, right: 10.0, top: 10.0, bottom: 10.0),
                  width: MediaQuery.of(context).size.width * 4 / 5,
                  child: TextFormField(
                    //onChanged: _addLanguageSkill,
                    controller: langSkillController,
                    decoration: InputDecoration(
                      label: Text(' Language skills'),
                      suffixIcon: IconButton(
                          onPressed: () {
                            _addLanguageSkill(langSkillController.text);
                            langSkillController.clear();
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.pink,
                          )),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: [
                    ...languageSkill.map(
                      (skill) => Chip(
                        label: Text(skill),
                        onDeleted: () => _removeLanguageSkill(skill),
                      ),
                    ),
                  ],
                ),
              ),
              // Text('Achievements'),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //       // padding: EdgeInsets.only(
              //       //     left: 60.0, right: 10.0, top: 10.0, bottom: 10.0),
              //       width: MediaQuery.of(context).size.width * 4 / 5,
              //       child: TextFormField(
              //         // onSubmitted: _addAchivSkill,
              //         controller: achivSkillController,
              //         decoration: InputDecoration(
              //           label: Text(' achivement skills'),
              //           suffixIcon: IconButton(
              //               onPressed: () {
              //                 _addAchivSkill(profSkillController.text);
              //               },
              //               icon: Icon(
              //                 Icons.add,
              //                 color: Colors.pink,
              //               )),
              //           border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(10.0),
              //             borderSide: BorderSide(
              //               color: Colors.grey,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 10,
              ),
              // Wrap(
              //   spacing: 8.0,
              //   runSpacing: 4.0,
              //   children: [
              //     ...achivSkill.map(
              //       (skill) => Chip(
              //         label: Text(skill),
              //         onDeleted: () => _removeAchivSkill(skill),
              //       ),
              //     ),
              //   ],
              // ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text('Tell us about yourself'),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width * 4 / 5,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: TextFormField(
                      onSaved: (newValue) {
                        if (newValue != null) about = newValue;
                      },
                      maxLines: 10,
                      decoration: InputDecoration(
                        labelText: 'summary',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Text('Preferred job'),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Job Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a job title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _jobPreference = value;
                  },
                ),
              ),
              SizedBox(height: 16.0),
              Text('Salary Expectation'),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      // filled: true,
                      // fillColor: Colors.blue,
                      hintText: 'Select an option',
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    validator: ((value) {
                      if (value == null) {
                        return 'please select an option';
                      }
                    }),
                    value: salaryLevelChoosed,
                    items: salaryExpectation.map((item) {
                      return DropdownMenuItem(
                        child: Text(item),
                        value: item,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        salaryLevelChoosed = value.toString();
                      });
                    }),
              ),
              Text('Your level of Experience'),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      // filled: true,
                      // fillColor: Colors.blue,
                      hintText: 'Select an option',
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    validator: ((value) {
                      if (value == null) {
                        return 'please select an option';
                      }
                    }),
                    value: experienceLevelChoosed,
                    items: experienceLevel.map((item) {
                      return DropdownMenuItem(
                        child: Text(item),
                        value: item,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        experienceLevelChoosed = value.toString();
                      });
                    }),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text('Add your profile image'),
              ),
              // imageProfile(context),
              CompanyLogoPicker(onImageSelected: _onImageSelected),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
                    final skill_Set = Skill(
                        languageSkills: languageSkill,
                        personalSkills: personalSkill,
                        professionalSkills: proffesionalSkill);
                    //  _uploadFile(); //uploades image to firebase storage

                    SkillProvider provider = SkillProvider();
                    provider.skill = skill_Set;
                    otherProvider otherInfoProvider = otherProvider();
                    //otherInfoProvider.otherInfo = other_info;
                    try {
                      _uploadFile();
                      saveSkillInfo(skill_Set);
                      // _uploadFile();
                      final other_info = Other(
                          aboutMe: about,
                          imageUrl: _imageUrl,
                          preferredJob: _jobPreference,
                          SalaryExpectation: salaryLevelChoosed,
                          levelOfExperience: experienceLevelChoosed);
                      saveOtherInfo(other_info);
                      // user_reference
                      //     .doc(getCurrentUserUid())
                      //     .collection('profile')
                      //     .doc('About')
                      //     .set({'summary': about});

                      // uploadImage();
                      // addImageToFirestore();
                      // uploadFile();
                      JobSeekerProfile profile = JobSeekerProfile(
                        profileId: profileId,
                        personalInfo: Provider.of<PersonalInfoProvider>(context,
                                listen: false)
                            .personalInfo,
                        // education:
                        //     Provider.of<EducationProvider>(context, listen: false)
                        //         .education,
                        // experience: Provider.of<ExperienceProvider>(context,
                        //         listen: false)
                        //     .experience,
                        // skills: Provider.of<SkillProvider>(context, listen: false)
                        //     .skill,
                        // otherInfo:
                        //     Provider.of<otherProvider>(context, listen: false)
                        //         .otherInfo,
                      );
                      final abc = Provider.of<ExperienceProvider>(context,
                              listen: false)
                          .experience
                          .city;
                      print('my beautifull city is called :${abc}');
                      // writeJobSeekerProfile(profile);
                      Utils.showSnackBar(
                          'Profile successfuly saved', Colors.green);
                    } catch (e) {
                      Utils.showSnackBar(e.toString(), Colors.red);
                      print(e.toString());
                    }
                  }

                  Navigator.of(context).pushNamed(
                    home.routeName,
                  );
                },
                // icon: Icon(Icons.navigate_next),
                style: ElevatedButton.styleFrom(
                  //minimumSize: Size.fromHeight(50),
                  //maximumSize: Size.fromWidth(30)
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  // primary: Colors.blue[900],
                  padding: EdgeInsets.all(10.0),
                  elevation: 10.0,
                ),
                //ElevatedButton.styleFrom(minimumSize: Size.fromWidth(50)),
                child: Text('Finish'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
