class Notifi {
  final String notificationTitle;
  final String notificationContent;
  final String classId;
  final String teacherId;

  Notifi({
    required this.notificationTitle,
    required this.notificationContent,
    required this.classId,
    required this.teacherId,
  });

  factory Notifi.fromJson(Map<String, dynamic> json) {
    return Notifi(
      notificationTitle: json['notificationTitle'] as String,
      notificationContent: json['notificationContent'] as String,
      classId: json['classId'] as String,
      teacherId: json['teacherId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notificationTitle': notificationTitle,
      'notificationContent': notificationContent,
      'classId': classId,
      'teacherId': teacherId,
    };
  }
}
