class Employer {
  String id;
  String name;
  String email;
  String password;
  String company;
  String website;
  String description;
  String logoUrl;
  List<String> industries;
  List<String> locations;
  List<String> jobPostings;
  List<String> savedJobPostings;
  List<String> notifications;

  Employer({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.company,
    required this.website,
    required this.description,
    required this.logoUrl,
    required this.industries,
    required this.locations,
    required this.jobPostings,
    required this.savedJobPostings,
    required this.notifications,
  });

  factory Employer.fromMap(Map<String, dynamic> map, String id) {
    return Employer(
      id: id,
      name: map['name'],
      email: map['email'],
      password: map['password'],
      company: map['company'],
      website: map['website'],
      description: map['description'],
      logoUrl: map['logoUrl'],
      industries: List<String>.from(map['industries']),
      locations: List<String>.from(map['locations']),
      jobPostings: List<String>.from(map['jobPostings']),
      savedJobPostings: List<String>.from(map['savedJobPostings']),
      notifications: List<String>.from(map['notifications']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'company': company,
      'website': website,
      'description': description,
      'logoUrl': logoUrl,
      'industries': industries,
      'locations': locations,
      'jobPostings': jobPostings,
      'savedJobPostings': savedJobPostings,
      'notifications': notifications,
    };
  }
}

class JobPosting {
  String id;
  String title;
  String company;
  String location;
  String industry;
  String description;
  double salary;
  DateTime deadline;
  List<String> requirements;

  JobPosting({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.industry,
    required this.description,
    required this.salary,
    required this.deadline,
    required this.requirements,
  });

  factory JobPosting.fromMap(Map<String, dynamic> map, String id) {
    return JobPosting(
      id: id,
      title: map['title'],
      company: map['company'],
      location: map['location'],
      industry: map['industry'],
      description: map['description'],
      salary: map['salary'],
      deadline: DateTime.fromMillisecondsSinceEpoch(map['deadline']),
      requirements: List<String>.from(map['requirements']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'company': company,
      'location': location,
      'industry': industry,
      'description': description,
      'salary': salary,
      'deadline': deadline.millisecondsSinceEpoch,
      'requirements': requirements,
    };
  }
}
