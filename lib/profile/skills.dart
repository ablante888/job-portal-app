import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project1/job_seeker_home_page/jobSeekerHome.dart';
import 'package:project1/user_account/utils.dart';
import '../models/job_seeker_profile_model.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Employers/emp_profile/compLogo_Picker.dart';
import './education.dart';
import './experience.dart';
import './personal_info.dart';

class SkillSet extends StatefulWidget {
  //const SkillSet({Key? key}) : super(key: key);
  static const routeName = '/SkillSet';

  @override
  State<SkillSet> createState() => _SkillSetState();
}

class _SkillSetState extends State<SkillSet> {
  String? uid;
  File? _image;
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

  void _onImageSelected(File image) {
    setState(() {
      _image = image;
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

  // Future uploadImage() async {
  //   final fileName = _image?.path.split('/').last;
  //   Reference ref = FirebaseStorage.instance.ref(fileName);
  //   UploadTask uploadTask = ref.putFile(_image as File);
  //   TaskSnapshot taskSnapshot = await uploadTask;
  //   String dowloadUrl = await taskSnapshot.ref.getDownloadURL();
  //   return dowloadUrl;
  // }

  // Future<void> addImageToFirestore() async {
  //   String imageUrl = await uploadImage();
  //   user_reference
  //       .doc(getCurrentUserUid())
  //       .collection('profile')
  //       .doc('profile_pecture')
  //       .set({'imageUrl': imageUrl});
  //   // FirebaseFirestore.instance.collection('images').add({
  //   //   'imageUrl': imageUrl,
  //   // });
  // }

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
    final json = job_seeker_skill.toJeson();
    await personal_info_doc_ref.collection('profile').doc('skills').set(json);
  }

  UploadTask? fileUpload(String destination, File? file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file as File);
    } catch (e) {
      return null;
    }
  }

  Future uploadFile() async {
    if (_image == null) return;
    final fileName = _image!.path;
    final destination = 'files/${fileName}';
    fileUpload(destination, _image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('form'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Share your skills with us'),

              Container(
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

              SizedBox(
                height: 10,
              ),
              Wrap(
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

              Container(
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

              SizedBox(
                height: 10,
              ),
              Wrap(
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

              Container(
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

              SizedBox(
                height: 10,
              ),
              Wrap(
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
              Text('Achievements'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // padding: EdgeInsets.only(
                    //     left: 60.0, right: 10.0, top: 10.0, bottom: 10.0),
                    width: MediaQuery.of(context).size.width * 4 / 5,
                    child: TextFormField(
                      // onSubmitted: _addAchivSkill,
                      controller: achivSkillController,
                      decoration: InputDecoration(
                        label: Text(' achivement skills'),
                        suffixIcon: IconButton(
                            onPressed: () {
                              _addAchivSkill(profSkillController.text);
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
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: [
                  ...achivSkill.map(
                    (skill) => Chip(
                      label: Text(skill),
                      onDeleted: () => _removeAchivSkill(skill),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.all(8),
                child: Text('Tell us about yourself'),
              ),
              SizedBox(height: 16.0),
              Container(
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
              SizedBox(height: 16.0),
              Text('Add your profile image'),
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

                    // try {
                    //   // saveSkillInfo(skill_Set);
                    //   user_reference
                    //       .doc(getCurrentUserUid())
                    //       .collection('profile')
                    //       .doc('About')
                    //       .set({'summary': about});
                    //   // uploadImage();
                    //   // addImageToFirestore();
                    //   // uploadFile();
                    //   Utils.showSnackBar('sucessfully saved', Colors.green);
                    // } on FirebaseException catch (e) {
                    //   Utils.showSnackBar(e.message, Colors.red);
                    // }
                  }

                  Navigator.of(context)
                      .pushNamed(home.routeName, arguments: _image);
                },
                // icon: Icon(Icons.navigate_next),
                style: ElevatedButton.styleFrom(
                    //minimumSize: Size.fromHeight(50),
                    //maximumSize: Size.fromWidth(30)
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
