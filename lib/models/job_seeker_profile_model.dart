class JobSeekerProfile {
  final PersonalInfo personalInfo;
  final List<Education> education;
  final List<ExperienceModel> experience;
  final List<Skill> skills;

  JobSeekerProfile({
    required this.personalInfo,
    this.education = const [],
    this.experience = const [],
    this.skills = const [],
  });
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
}
