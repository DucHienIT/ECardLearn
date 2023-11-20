import 'package:e_learn_flashcard/model/ModelCourse.dart';

class MyClass {
  final String classId;
  final String className;
  final String classDescription;
  final String teacherId;
  final List<Course>? courses; // Thêm "?" để đánh dấu rằng đây có thể là null
  final String createdUserId;
  final DateTime createdDate;
  final String updatedUserId;
  final DateTime updatedDate;

  MyClass({
    required this.classId,
    required this.className,
    required this.classDescription,
    required this.teacherId,
    required this.courses,
    required this.createdUserId,
    required this.createdDate,
    required this.updatedUserId,
    required this.updatedDate,
  });
  MyClass.defaultClass()
      : classId = '',
        className = '',
        classDescription = '',
        teacherId = '',
        courses = null,
        createdUserId = '',
        createdDate = DateTime.now(),
        updatedUserId = '',
        updatedDate = DateTime.now();

  factory MyClass.fromJson(Map<String, dynamic> json) {
    return MyClass(
      classId: json['classId'] as String,
      className: json['className'] as String,
      classDescription: json['classDescription'] as String,
      teacherId: json['teacherId'] as String,
      courses: json['courses'] != null
          ? (json['courses'] as List<dynamic>).map((q) => Course.fromJson(q as Map<String, dynamic>)).toList()
          : [],
      createdUserId: json['createdUserId'] as String,
      createdDate: json['createdDate'] != null ? DateTime.parse(json['createdDate']) : DateTime.now(),
      updatedUserId: json['updatedUserId'] as String? ?? '', // Thêm xử lý null ở đây
      updatedDate: json['updatedDate'] != null ? DateTime.parse(json['updatedDate']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'className': className,
      'classDescription': classDescription,
      'teacherId': teacherId,
      'courses': courses?.map((q) => q.toJson()).toList(), // Thêm "?" ở đây
      'createdUserId': createdUserId,
      'createdDate': createdDate.toIso8601String(),
      'updatedUserId': updatedUserId,
      'updatedDate': updatedDate.toIso8601String(),
    };
  }
}
