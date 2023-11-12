class Question {
  final String questionString;
  final String correctAnswerId;
  final String courseId;
  final String createdUserId;
  final DateTime createdDate;
  final String updatedUserId;
  final DateTime updatedDate;

  Question({
    required this.questionString,
    required this.correctAnswerId,
    required this.courseId,
    required this.createdUserId,
    required this.createdDate,
    required this.updatedUserId,
    required this.updatedDate,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionString: json['questionString'] as String,
      correctAnswerId: json['correctAnswerId'] as String,
      courseId: json['courseId'] as String,
      createdUserId: json['createdUserId'] as String,
      createdDate: DateTime.parse(json['createdDate']),
      updatedUserId: json['updatedUserId'] as String,
      updatedDate: DateTime.parse(json['updatedDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionString': questionString,
      'correctAnswerId': correctAnswerId,
      'courseId': courseId,
      'createdUserId': createdUserId,
      'createdDate': createdDate.toIso8601String(),
      'updatedUserId': updatedUserId,
      'updatedDate': updatedDate.toIso8601String(),
    };
  }
}
