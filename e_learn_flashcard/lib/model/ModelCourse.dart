import 'package:e_learn_flashcard/Util/UtilDateTime.dart';

class Course {
  final String courseId;
  final String courseName;
  final String courseDescription;
  final String topicId;
  final String teacherId;
  final String createdUserId;
  final DateTime createdDate;
  final String updatedUserId;
  final DateTime updatedDate;

  Course({
    required this.courseId,
    required this.courseName,
    required this.courseDescription,
    required this.topicId,
    required this.teacherId,
    required this.createdUserId,
    required this.createdDate,
    required this.updatedUserId,
    required this.updatedDate,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseId: json['courseId'] as String,
      courseName: json['courseName'] as String,
      courseDescription: json['courseDescription'] as String,
      topicId: json['topicId'] as String,
      teacherId: json['teacherId'] as String,
      createdUserId: json['createdUserId'] != null ? json['createdUserId'] as String : '',
      createdDate: DateTime.parse(json['createdDate']),
      updatedUserId: json['updatedUserId'] != null ? json['updatedUserId'] as String : '',
      updatedDate: json['updatedDate'] != null ? DateTime.parse(json['updatedDate']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'courseId': courseId,
      'courseName': courseName,
      'courseDescription': courseDescription,
      'topicId': topicId,
      'teacherId': teacherId,
      'createdUserId': createdUserId,
      'createdDate': createdDate.toIso8601String(),
      'updatedUserId': updatedUserId,
      'updatedDate': updatedDate.toIso8601String(),
    };
  }
}
