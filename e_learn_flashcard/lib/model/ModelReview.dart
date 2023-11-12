class Review {
  final String title;
  final String description;
  final int rating;
  final String userId;
  final String courseId;
  final String createdUserId;
  final DateTime createdDate;
  final String updatedUserId;
  final DateTime updatedDate;

  Review({
    required this.title,
    required this.description,
    required this.rating,
    required this.userId,
    required this.courseId,
    required this.createdUserId,
    required this.createdDate,
    required this.updatedUserId,
    required this.updatedDate,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      title: json['title'] as String,
      description: json['description'] as String,
      rating: json['rating'] as int,
      userId: json['userId'] as String,
      courseId: json['courseId'] as String,
      createdUserId: json['createdUserId'] as String,
      createdDate: DateTime.parse(json['createdDate']),
      updatedUserId: json['updatedUserId'] as String,
      updatedDate: DateTime.parse(json['updatedDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'rating': rating,
      'userId': userId,
      'courseId': courseId,
      'createdUserId': createdUserId,
      'createdDate': createdDate.toIso8601String(),
      'updatedUserId': updatedUserId,
      'updatedDate': updatedDate.toIso8601String(),
    };
  }
}
