class Job {
  final String id;
  final String title;
  final String description;
  final String company;
  final String location;
  final int salary;
  final DateTime postedDate;

  Job({
    required this.id,
    required this.title,
    required this.description,
    required this.company,
    required this.location,
    required this.salary,
    required this.postedDate,
  });
}
