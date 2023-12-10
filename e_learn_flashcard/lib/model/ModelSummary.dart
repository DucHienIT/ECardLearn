class TestSummary {
  String summaryId;
  String userId;
  String fullName;
  int noCorrectAnswer;
  int noIncorrectAnswer;

  TestSummary({
    required this.summaryId,
    required this.userId,
    required this.fullName,
    required this.noCorrectAnswer,
    required this.noIncorrectAnswer,
  });

  factory TestSummary.fromJson(Map<String, dynamic> json) {
    return TestSummary(
      summaryId: json['summaryId'] as String,
      userId: json['userId'] as String,
      fullName: json['fullName'] as String,
      noCorrectAnswer: json['noCorrectAnswer'] as int,
      noIncorrectAnswer: json['noIncorrectAnswer'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'summaryId': summaryId,
      'userId': userId,
      'fullName': fullName,
      'noCorrectAnswer': noCorrectAnswer,
      'noIncorrectAnswer': noIncorrectAnswer,
    };
  }
}
