class ApplicationModel {
  final String id;
  final String jobId;
  final String jobseekerId;
  final String status; // applied, reviewed, accepted, rejected
  final DateTime appliedAt;

  ApplicationModel({
    required this.id,
    required this.jobId,
    required this.jobseekerId,
    required this.status,
    required this.appliedAt,
  });

  factory ApplicationModel.fromMap(Map<String, dynamic> map, String id) {
    return ApplicationModel(
      id: id,
      jobId: map['jobId'],
      jobseekerId: map['jobseekerId'],
      status: map['status'],
      appliedAt: DateTime.parse(map['appliedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'jobId': jobId,
      'jobseekerId': jobseekerId,
      'status': status,
      'appliedAt': appliedAt.toIso8601String(),
    };
  }
}
