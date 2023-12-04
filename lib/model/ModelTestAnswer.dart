class TestAnswer {
  final String testId;
  final String studentId;
  final String questionId;
  final String answerId;

  TestAnswer({
    required this.testId,
    required this.studentId,
    required this.questionId,
    required this.answerId,
  });

  factory TestAnswer.fromJson(Map<String, dynamic> json) {
    return TestAnswer(
      testId: json['testId'] as String,
      studentId: json['studentId'] as String,
      questionId: json['questionId'] as String,
      answerId: json['answerId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'testId': testId,
      'studentId': studentId,
      'questionId': questionId,
      'answerId': answerId,
    };
  }
}
