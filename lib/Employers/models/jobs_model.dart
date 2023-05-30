import 'package:cloud_firestore/cloud_firestore.dart';

class Company {
  String companyId;
  String name;
  String address;
  String city;
  String state;
  String country;
  String phone;
  String email;
  String website;
  String description;
  String industry;
  String companySize;
  String logoUrl;

  Company({
    required this.companyId,
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.phone,
    required this.email,
    required this.website,
    required this.description,
    required this.industry,
    required this.companySize,
    required this.logoUrl,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      companyId: json['companyId'],
      name: json['name'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      phone: json['phone'],
      email: json['email'],
      website: json['website'],
      description: json['description'],
      industry: json['industry'],
      companySize: json['company-size'],
      logoUrl: json['logoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'phone': phone,
      'email': email,
      'website': website,
      'industry': industry,
      'company-size': companySize,
      'logoUrl': logoUrl,
      'companyId': companyId,
    };
  }
}

//Job Post Model
class JobPost {
  DateTime timePosted;
  String JobId;
  String title;
  String category;
  String description;
  List requirements;

  String salary;
  String employmentType;
  String location;
  String experienceLevel;
  String educationLevel;
  DateTime deadline;
  var company;
  //bool isFavorite;

  JobPost({
    required this.timePosted,
    required this.JobId,
    required this.title,
    required this.category,
    required this.description,
    required this.requirements,
    required this.salary,
    required this.employmentType,
    required this.location,
    required this.experienceLevel,
    required this.educationLevel,
    required this.deadline,
    required this.company,
    //  required this.isFavorite,
  });

  factory JobPost.fromJson(Map<String, dynamic> json) {
    return JobPost(
      timePosted: json['posted time'],
      JobId: json['job id'],
      title: json['title'],
      description: json['description'],
      requirements: json['requirements'],
      location: json['location'],
      salary: json['salary'],
      deadline: DateTime.parse(json['deadline']),
      company: Company.fromJson(json['company']),
      employmentType: json['employment type'],
      experienceLevel: json['experience level'],
      educationLevel: json['education level'],
      category: json['job category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'posted time': timePosted,
      'job id': JobId,
      'title': title,
      'description': description,
      'requirements': requirements,
      'location': location,
      'salary': salary,
      'deadline': deadline.toIso8601String(),
      'company': company,
      'employment type': employmentType,
      'experience level': experienceLevel,
      'education level': educationLevel,
      'job category': category,
    };
  }

  // void toggleFavoriteStatus() {
  //   isFavorite = !isFavorite;
  //   notifyListeners();
  // }
}
