class Answer {
  final String answerString;
  final String questionId;
  final bool isCorrect;
  final String createdUserId;
  final DateTime createdDate;
  final String updatedUserId;
  final DateTime updatedDate;

  Answer({
    required this.answerString,
    required this.questionId,
    required this.isCorrect,
    required this.createdUserId,
    required this.createdDate,
    required this.updatedUserId,
    required this.updatedDate,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      answerString: json['answerString'],
      questionId: json['questionId'],
      isCorrect: json['isCorrect'],
      createdUserId: json['createdUserId'],
      createdDate: DateTime.parse(json['createdDate']),
      updatedUserId: json['updatedUserId'],
      updatedDate: DateTime.parse(json['updatedDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'answerString': answerString,
      'questionId': questionId,
      'isCorrect': isCorrect,
      'createdUserId': createdUserId,
      'createdDate': createdDate.toIso8601String(),
      'updatedUserId': updatedUserId,
      'updatedDate': updatedDate.toIso8601String(),
    };
  }
}
