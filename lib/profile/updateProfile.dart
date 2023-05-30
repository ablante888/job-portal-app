import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project1/user_account/utils.dart';

class UpdateAboutMeDialog extends StatefulWidget {
  @override
  _UpdateAboutMeDialogState createState() => _UpdateAboutMeDialogState();
}

class _UpdateAboutMeDialogState extends State<UpdateAboutMeDialog> {
  String getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }

  void updateField(String aboutMe) async {
    try {
      await FirebaseFirestore.instance
          .collection('job-seeker')
          .doc(getCurrentUserUid())
          .collection('jobseeker-profile')
          .doc('profile')
          .update({'other-data.about me': '${aboutMe}'});
      print('Field updated successfully.');
    } catch (e) {
      print('Error updating field: $e');
    }
  }

  final TextEditingController aboutMeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Update About Me'),
      content: TextFormField(
        controller: aboutMeController,
        maxLines: 10,
        decoration: InputDecoration(
          labelText: 'About Me',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Save'),
          onPressed: () {
            String updatedAboutMe = aboutMeController.text;
            try {
              updateField(updatedAboutMe);
              Utils.showSnackBar('Sucessfuly Updated', Colors.green);
            } catch (e) {
              Utils.showSnackBar(e.toString(), Colors.red);
            }

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class UpdateSkillsDialog extends StatefulWidget {
  final String skill_Type;
  const UpdateSkillsDialog({Key? key, required this.skill_Type})
      : super(key: key);
  @override
  _UpdateSkillsDialogState createState() => _UpdateSkillsDialogState();
}

class _UpdateSkillsDialogState extends State<UpdateSkillsDialog> {
  String getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }

  void updateField(String skillType, String skillAdded) async {
    try {
      await FirebaseFirestore.instance
          .collection('job-seeker')
          .doc(getCurrentUserUid())
          .collection('jobseeker-profile')
          .doc('profile')
          .update({
        'skills.${skillType}': FieldValue.arrayUnion([skillAdded])
      });
      print('Field updated successfully.');
    } catch (e) {
      print('Error updating field: $e');
    }
  }

  final TextEditingController aboutMeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add more skills'),
      content: TextFormField(
        controller: aboutMeController,
        decoration: InputDecoration(
          labelText: 'Professional Skill',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('ADD'),
          onPressed: () {
            String skillAdded = aboutMeController.text;
            try {
              updateField(widget.skill_Type, skillAdded);
              Utils.showSnackBar('Sucessfuly Updated', Colors.green);
            } catch (e) {
              Utils.showSnackBar(e.toString(), Colors.red);
            }

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class UpdateExperienceDialog extends StatefulWidget {
  @override
  _UpdateExperienceDialogState createState() => _UpdateExperienceDialogState();
}

class _UpdateExperienceDialogState extends State<UpdateExperienceDialog> {
  String getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }

  void updateField(String experienceAdded) async {
    try {
      await FirebaseFirestore.instance
          .collection('job-seeker')
          .doc(getCurrentUserUid())
          .collection('jobseeker-profile')
          .doc('profile')
          .set({
        'experiences.${DateTime.now().millisecondsSinceEpoch.toString()}':
            '${experienceAdded}'
      });
      print('Field updated successfully.');
    } catch (e) {
      print('Error updating field: $e');
    }
  }

  final TextEditingController aboutMeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add experience'),
      content: Container(
        height: MediaQuery.of(context).size.height / 3,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: aboutMeController,
                decoration: InputDecoration(
                  labelText: 'Job title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: aboutMeController,
                decoration: InputDecoration(
                  labelText: 'company name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: aboutMeController,
                decoration: InputDecoration(
                  labelText: 'Region',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: aboutMeController,
                decoration: InputDecoration(
                  labelText: 'city',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: aboutMeController,
                decoration: InputDecoration(
                  labelText: 'Start date',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: aboutMeController,
                decoration: InputDecoration(
                  labelText: 'End date',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Save'),
          onPressed: () {
            String updatedAboutMe = aboutMeController.text;
            try {
              updateField(updatedAboutMe);
              Utils.showSnackBar('Sucessfuly Updated', Colors.green);
            } catch (e) {
              Utils.showSnackBar(e.toString(), Colors.red);
            }

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class UpdateEducationDialog extends StatefulWidget {
  @override
  _UpdateEducationDialogState createState() => _UpdateEducationDialogState();
}

class _UpdateEducationDialogState extends State<UpdateEducationDialog> {
  String getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }

  void updateField(String experienceAdded) async {
    try {
      await FirebaseFirestore.instance
          .collection('job-seeker')
          .doc(getCurrentUserUid())
          .collection('jobseeker-profile')
          .doc('profile')
          .set({
        'experiences.${DateTime.now().millisecondsSinceEpoch.toString()}':
            '${experienceAdded}'
      });
      print('Field updated successfully.');
    } catch (e) {
      print('Error updating field: $e');
    }
  }

  final TextEditingController aboutMeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Education'),
      content: Container(
        height: MediaQuery.of(context).size.height / 3,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: aboutMeController,
                decoration: InputDecoration(
                  labelText: 'Highest Education Level',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: aboutMeController,
                decoration: InputDecoration(
                  labelText: 'college/University name ',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: aboutMeController,
                decoration: InputDecoration(
                  labelText: 'Field of study',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: aboutMeController,
                decoration: InputDecoration(
                  labelText: 'Start Date',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: aboutMeController,
                decoration: InputDecoration(
                  labelText: 'end Date',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: aboutMeController,
                decoration: InputDecoration(
                  labelText: 'Cumulative GPA',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Save'),
          onPressed: () {
            String updatedAboutMe = aboutMeController.text;
            try {
              updateField(updatedAboutMe);
              Utils.showSnackBar('Sucessfuly Updated', Colors.green);
            } catch (e) {
              Utils.showSnackBar(e.toString(), Colors.red);
            }

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
