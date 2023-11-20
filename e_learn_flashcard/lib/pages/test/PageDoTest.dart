import 'package:e_learn_flashcard/Util/ApiPaths.dart';
import 'package:flutter/material.dart';

import '../../Util/UtilCallApi.dart';
import '../../model/ModelAnswer.dart';
import '../../model/ModelCourse.dart';

class DoTestPage extends StatefulWidget {
  final String courseId;
  DoTestPage({required this.courseId});

  @override
  _DoTestPageState createState() => _DoTestPageState();
}

class _DoTestPageState extends State<DoTestPage> {
  late Course course = Course.defaultCourse();
  List<QuestionCard> questions = [];
  int currentQuestionIndex = 0;

  bool isCourseOwner = false;

  @override
  void initState() {
    super.initState();
    fetchDataCourse();
  }

  void fetchDataCourse() async {
    final String apiUrl = ApiPaths.getCourseIdPath(widget.courseId);
    FetchObjectFromAPI(apiUrl, setClassCourse);
  }

  void setClassCourse(Object data) {
    setState(() {
      course = Course.fromJson(data as Map<String, dynamic>);
      questions = course.questions.map((question) => QuestionCard(
        question: question.questionString,
        answers: question.answers,
      )).toList();
    });
  }

  void nextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      }
    });
  }

  void previousQuestion() {
    setState(() {
      if (currentQuestionIndex > 0) {
        currentQuestionIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bài kiểm tra: ${course.courseName}'),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Câu hỏi ${questions.length == 0 ? 0 : currentQuestionIndex +
                  1}/${questions.length}:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            if (questions.isNotEmpty)
              QuestionCard(
                question: questions[currentQuestionIndex].question,
                  answers: questions[currentQuestionIndex].answers
              ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: previousQuestion,
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: nextQuestion,
                ),

              ],
            ),
          ],
        ),
      ),

    );
  }
}


class QuestionCard extends StatefulWidget {
  final String question;
  final List<Answer> answers;

  QuestionCard({required this.question, required this.answers});

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  Answer? selectedAnswer; // Keep track of the selected answer

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(widget.question, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            ...widget.answers.map((answer) => ListTile(
              title: Text(answer.answerString),
              leading: Radio(
                value: answer,
                groupValue: selectedAnswer,
                onChanged: (Answer? value) {
                  print('Selected Answer: $value');
                  setState(() {
                    selectedAnswer = value;
                  });
                },
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
