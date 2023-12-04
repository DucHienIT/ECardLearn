import 'ModelAnswer.dart';

class Question {
  final String questionId;
  final String questionString;
  final String courseId;
  final List<Answer> answers;
  final String createdUserId;
  final DateTime createdDate;
  final String updatedUserId;
  final DateTime updatedDate;

  Question({
    required this.questionId,
    required this.questionString,
    required this.courseId,
    required this.answers,
    required this.createdUserId,
    required this.createdDate,
    required this.updatedUserId,
    required this.updatedDate,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    var answerList = json['answers'] as List;
    List<Answer> answers = answerList.map((i) => Answer.fromJson(i)).toList();

    return Question(
      questionId: json['questionId'] as String,
      questionString: json['questionString'] as String,
      courseId: json['courseId'] as String,
      answers: answers,
      createdUserId: json['createdUserId'] != null ?  json['createdUserId'] as String : '',
      createdDate: json['createdDate'] != null ? DateTime.parse(json['createdDate']) : DateTime.now(),
      updatedUserId: json['updatedUserId'] != null ? json['updatedUserId'] as String : '',
      updatedDate: json['updatedDate'] != null ? DateTime.parse(json['updatedDate']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'questionString': questionString,
      'courseId': courseId,
      'answers': answers.map((answer) => answer.toJson()).toList(),
      'createdUserId': createdUserId,
      'createdDate': createdDate.toIso8601String(),
      'updatedUserId': updatedUserId,
      'updatedDate': updatedDate.toIso8601String(),
    };
  }
}
