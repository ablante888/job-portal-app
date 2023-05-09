import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:project1/profile/experience.dart';
import 'package:provider/provider.dart';

class JobSeekerProfile {
  String profileId;
  final PersonalInfo personalInfo;
  // final List<Education> education;
  // final List<ExperienceModel> experience;
  // final List<Skill> skills;
  final Education education;
  final ExperienceModel experience;
  final Skill skills;
  final Other otherInfo;
  JobSeekerProfile({
    required this.profileId,
    required this.personalInfo,
    required this.education,
    required this.experience,
    required this.skills,
    required this.otherInfo,
    // this.education = const [],
    // this.experience = const [],
    // this.skills = const [],
  });
  factory JobSeekerProfile.fromMap(Map<String, dynamic> data) {
    return JobSeekerProfile(
        profileId: json.decode('profile id'),
        personalInfo: PersonalInfo.fromJeson(data['personal info']),
        education: Education.fromMap(data['education']),
        experience: ExperienceModel.fromMap(data['experience']),
        skills: Skill.fromMap(data['skills']),
        otherInfo: Other.fromMap(data['other info']));
  }
  Map<String, dynamic> toJeson() => {
        'profile id': profileId,
        'personal info': personalInfo.toJeson(),
        'education': education.toJeson(),
        'experience': experience.toJeson(),
        'skills': Skill,
        'region': Other,
      };
}

class PersonalInfo {
  String id;
  String firstName;
  String lastName;
  String gender;
  String region;
  String city;
  String email;
  String phoneNumber;
  PersonalInfo(
      {this.id = '',
      this.firstName = '',
      this.lastName = '',
      this.gender = '',
      this.city = '',
      this.region = '',
      this.email = '',
      this.phoneNumber = ''});
  Map<String, dynamic> toJeson() => {
        'id': id,
        'first name': firstName,
        'last name': lastName,
        'gender': gender,
        'city': city,
        'region': region,
        'email': email,
        'phone number': phoneNumber,
      };
  static PersonalInfo fromJeson(Map<String, dynamic> json) => PersonalInfo(
      id: json['id'],
      firstName: json['first name'],
      lastName: json['last name'],
      gender: json['gender'],
      city: json['city'],
      region: json['region'],
      email: json['email'],
      phoneNumber: json[['phone number']]);
}

class Education {
  String? levelOfEducation;
  String? institution;
  String? fieldOfStudy;
  String? startDate;
  String? endDate;
  String? GPA;

  Education({
    this.GPA = '',
    this.levelOfEducation,
    this.institution,
    this.fieldOfStudy,
    this.startDate,
    this.endDate,
  });
  Map<String, dynamic> toJeson() => {
        'levelOfEducation': levelOfEducation,
        'institution': institution,
        'fieldOfStudy': fieldOfStudy,
        'startDte': startDate,
        'endDate': endDate,
      };
  factory Education.fromMap(Map<String, dynamic> json) => Education(
      levelOfEducation: json['levelOfEducation'],
      institution: json['institution'],
      fieldOfStudy: json['fieldOfStudy'],
      startDate: json['startDate'],
      endDate: json['endDate']);
}

class ExperienceModel {
  String? title;
  String? company;
  DateTime? startDate;
  DateTime? endDate;
  String? region;
  String? city;

  ExperienceModel({
    this.title,
    this.company,
    this.startDate,
    this.endDate,
    this.region,
    this.city,
  });
  Map<String, dynamic> toJeson() => {
        'job title': title,
        'company': company,
        'startDte': startDate,
        'End date': endDate,
        'Region': region,
        'city': city
      };
  factory ExperienceModel.fromMap(Map<String, dynamic> json) => ExperienceModel(
      title: json['job title'],
      company: json['company'],
      startDate: json['startDte'],
      endDate: json['End Date'],
      region: json['Region'],
      city: json['city']);
}

class Skill {
  List<String>? professionalSkills;
  List<String>? personalSkills;
  List<String>? languageSkills;
  Skill({this.languageSkills, this.personalSkills, this.professionalSkills});
  Map<String, dynamic> toJeson() => {
        'professional skills': professionalSkills,
        'personal skills': personalSkills,
        'language skills': languageSkills,
      };
  factory Skill.fromMap(Map<String, dynamic> json) => Skill(
      languageSkills: json['language skills'],
      personalSkills: json['personal skills'],
      professionalSkills: json['professional skills']);
}

class Other {
  String? aboutMe;
  String? imageUrl;
  Other({this.aboutMe, this.imageUrl});
  factory Other.fromMap(Map<String, dynamic> json) => Other(
        aboutMe: json['language skills'],
        imageUrl: json['personal skills'],
      );
  Map<String, dynamic> toJeson() => {
        'about me': aboutMe,
        'profile image': imageUrl,
        //  'language skills': languageSkills,
      };
}
// class EducationProvider extends ChangeNotifier{
//   late String _degree;
//   late String _institution;
//   late String _startDate;
//   late String _endDate;

//   EducationProvider({
//     required String levelOfEducation,
//     required String institution,
//      required String fieldOfStudy,
//     required String startDate,
//     required String endDate,
//   })
//   set eduaction(String levelOfEducation,String institution,String fieldOfStudy, String startDate,String endDate){}
// }

class PersonalInfoProvider extends ChangeNotifier {
  PersonalInfo _personalInfo = PersonalInfo();

  PersonalInfo get personalInfo => _personalInfo;

  set personalInfo(PersonalInfo value) {
    _personalInfo = value;
    notifyListeners();
  }
}

class EducationProvider extends ChangeNotifier {
  Education _education = Education();
  Education get education => _education;

  set education(Education value) {
    _education = value;
    notifyListeners();
  }
}

class ExperienceProvider extends ChangeNotifier {
  ExperienceModel _experience = ExperienceModel();

  ExperienceModel get experience => _experience;

  set experience(ExperienceModel value) {
    _experience = value;
    notifyListeners();
  }
}

class SkillProvider extends ChangeNotifier {
  Skill _skill = Skill();

  Skill get skill => _skill;

  set skill(Skill value) {
    _skill = value;
    notifyListeners();
  }
}

class otherProvider extends ChangeNotifier {
  Other _otherInfo = Other();
  Other get otherInfo => _otherInfo;
  set otherInfo(Other value) {
    _otherInfo = value;
    notifyListeners();
  }
}
