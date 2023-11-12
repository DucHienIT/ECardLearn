class Topic {
  final String topicId;
  final String topicName;
  final String topicDescription;
  final String createdUserId;
  final DateTime createdDate;
  final String updatedUserId;
  final DateTime updatedDate;

  Topic({
    required this.topicId,
    required this.topicName,
    required this.topicDescription,
    required this.createdUserId,
    required this.createdDate,
    required this.updatedUserId,
    required this.updatedDate,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      topicId: json['topicId'] as String,
      topicName: json['topicName'] as String,
      topicDescription: json['topicDescription'] as String,
      createdUserId: json['createdUserId'] != null ? json['createdUserId'] as String : '',
      createdDate: DateTime.parse(json['createdDate']),
      updatedUserId: json['updatedUserId'] != null ? json['updatedUserId'] as String : '', // Kiểm tra nếu không tồn tại, gán giá trị rỗng
      updatedDate: json['updatedDate'] != null ? DateTime.parse(json['updatedDate']) : DateTime.now(),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'topicId': topicId,
      'topicName': topicName,
      'topicDescription': topicDescription,
      'createdUserId': createdUserId,
      'createdDate': createdDate.toIso8601String(),
      'updatedUserId': updatedUserId,
      'updatedDate': updatedDate.toIso8601String(),
    };
  }

}
