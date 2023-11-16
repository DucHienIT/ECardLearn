import 'package:e_learn_flashcard/model/ModelGlobalData.dart';

import 'ModelQuestion.dart';
import 'ModelTopic.dart';

class Course {
  final String courseId;
  final String courseName;
  final String courseDescription;
  final String topicId;
  final Topic topic;
  final List<Question> questions;
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
    required this.topic,
    required this.questions,
    required this.teacherId,
    required this.createdUserId,
    required this.createdDate,
    required this.updatedUserId,
    required this.updatedDate,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseId: json['courseId'] != null ? json['courseId'] as String : '',
      courseName: json['courseName'] != null ? json['courseName'] as String : '',
      courseDescription:json['courseDescription'] != null ? json['courseDescription'] as String : '',
      topicId: json['topicId'] as String,
      topic: json['topic'] != null ? Topic.fromJson(json['topic'] as Map<String, dynamic>) : Topic.defaultTopic(), // Thêm phần này
      questions:json['questions'] != null ? (json['questions'] as List<dynamic>).map((q) => Question.fromJson(q as Map<String, dynamic>)).toList() : [], // Thêm phần này
      teacherId: json['teacherId'] != null ? json['teacherId'] as String : '',
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
      'topic': topic.toJson(), // Thêm phần này
      'questions': questions.map((q) => q.toJson()).toList(), // Thêm phần này
      'teacherId': teacherId,
      'createdUserId': createdUserId,
      'createdDate': createdDate.toIso8601String(),
      'updatedUserId': updatedUserId,
      'updatedDate': updatedDate.toIso8601String(),
    };
  }
}
