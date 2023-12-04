class Review {
  final String title;
  final String description;
  final int rating;
  final String userId;
  final String courseId;

  Review({
    required this.title,
    required this.description,
    required this.rating,
    required this.userId,
    required this.courseId,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      title: json['title'] as String,
      description: json['description'] as String,
      rating: json['rating'] as int,
      userId: json['userId'] as String,
      courseId: json['courseId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'rating': rating,
      'userId': userId,
      'courseId': courseId,
    };
  }
}
