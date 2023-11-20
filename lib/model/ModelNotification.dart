class Notification {
  final String notificationTitle;
  final String notificationContent;
  final String createdUserId;
  final DateTime createdDate;
  final String updatedUserId;
  final DateTime updatedDate;

  Notification({
    required this.notificationTitle,
    required this.notificationContent,
    required this.createdUserId,
    required this.createdDate,
    required this.updatedUserId,
    required this.updatedDate,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      notificationTitle: json['notificationTitle'] as String,
      notificationContent: json['notificationContent'] as String,
      createdUserId: json['createdUserId'] as String,
      createdDate: DateTime.parse(json['createdDate']),
      updatedUserId: json['updatedUserId'] as String,
      updatedDate: DateTime.parse(json['updatedDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notificationTitle': notificationTitle,
      'notificationContent': notificationContent,
      'createdUserId': createdUserId,
      'createdDate': createdDate.toIso8601String(),
      'updatedUserId': updatedUserId,
      'updatedDate': updatedDate.toIso8601String(),
    };
  }
}
