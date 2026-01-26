class JobModel {
  final String id;
  final String title;
  final String category;
  final String location;
  final String employmentType;
  final String salary;
  final String description;
  final String company;
  final String employerId;
  final DateTime createdAt;

  JobModel({
    required this.id,
    required this.title,
    required this.category,
    required this.location,
    required this.employmentType,
    required this.salary,
    required this.description,
    required this.company,
    required this.employerId,
    required this.createdAt,
  });

  factory JobModel.fromMap(Map<String, dynamic> map, String id) {
    return JobModel(
      id: id,
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      location: map['location'] ?? '',
      employmentType: map['employmentType'] ?? '',
      salary: map['salary'] ?? '',
      description: map['description'] ?? '',
      company: map['company'] ?? '',
      employerId: map['employerId'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'category': category,
      'location': location,
      'employmentType': employmentType,
      'salary': salary,
      'description': description,
      'company': company,
      'employerId': employerId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
