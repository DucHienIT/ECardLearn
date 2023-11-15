class MyClass {
  final String classId;
  final String className;
  final String classDescription;
  final String teacherId;
  final String createdUserId;
  final DateTime createdDate;
  final String updatedUserId;
  final DateTime updatedDate;

  MyClass({
    required this.classId,
    required this.className,
    required this.classDescription,
    required this.teacherId,
    required this.createdUserId,
    required this.createdDate,
    required this.updatedUserId,
    required this.updatedDate,
  });

  factory MyClass.fromJson(Map<String, dynamic> json) {
    return MyClass(
      classId: json['classId'] as String,
      className: json['className'] as String,
      classDescription: json['classDescription'] as String,
      teacherId: json['teacherId'] as String,
      createdUserId: json['createdUserId'] as String,
      createdDate:json['createdDate'] != null ? DateTime.parse(json['createdDate']) : DateTime.now(),
      updatedUserId: json['updatedUserId'] != null ? json['updatedUserId'] as String : '',
      updatedDate:json['updatedDate'] != null ? DateTime.parse(json['updatedDate']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'className': className,
      'classDescription': classDescription,
      'teacherId': teacherId,
      'createdUserId': createdUserId,
      'createdDate': createdDate.toIso8601String(),
      'updatedUserId': updatedUserId,
      'updatedDate': updatedDate.toIso8601String(),
    };
  }
}
