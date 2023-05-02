import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:project1/profile/experience.dart';

class JobSeekerProfile {
  final PersonalInfo personalInfo;
  // final List<Education> education;
  // final List<ExperienceModel> experience;
  // final List<Skill> skills;
  final Education education;
  final ExperienceModel experience;
  final List<Skill> skills;
  JobSeekerProfile({
    required this.personalInfo,
    required this.education,
    required this.experience,
    required this.skills,
    // this.education = const [],
    // this.experience = const [],
    // this.skills = const [],
  });
  factory JobSeekerProfile.fromMap(Map<String, dynamic> data) {
    return JobSeekerProfile(
      personalInfo: data['email'],
      education: Education.fromMap(data['education']),
      experience: ExperienceModel.fromMap(data['experience']),
      skills:
          List<Skill>.from(data['skills'].map((skill) => Skill.fromMap(skill))),
    );
  }
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
  final String levelOfEducation;
  final String institution;
  final String fieldOfStudy;
  final String startDate;
  final String endDate;
  final String GPA;

  Education({
    this.GPA = '',
    required this.levelOfEducation,
    required this.institution,
    required this.fieldOfStudy,
    required this.startDate,
    required this.endDate,
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
  final String title;
  final String company;
  final DateTime startDate;
  final DateTime endDate;
  String region;
  String city;

  ExperienceModel({
    required this.title,
    required this.company,
    required this.startDate,
    required this.endDate,
    required this.region,
    required this.city,
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
  final List<String> professionalSkills;
  final List<String> personalSkills;
  final List<String> languageSkills;
  Skill(
      {required this.languageSkills,
      required this.personalSkills,
      required this.professionalSkills});
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