import 'package:e_learn_flashcard/Util/ApiPaths.dart';
import 'package:e_learn_flashcard/model/ModelGlobalData.dart';
import 'package:e_learn_flashcard/widget/LoadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../Util/AlertManager.dart';
import '../../Util/UtilCallApi.dart';
import '../../model/ModelAnswer.dart';
import '../../model/ModelCourse.dart';
import '../../model/ModelTest.dart';

class DoTestPage extends StatefulWidget {
  final String courseId;
  final Test test;
  DoTestPage({required this.courseId, required this.test});

  @override
  _DoTestPageState createState() => _DoTestPageState();
}

class _DoTestPageState extends State<DoTestPage> {
  late Course course = Course.defaultCourse();
  List<QuestionCard> questions = [];
  Map<String, String> answerQuestion = {};
  int currentQuestionIndex = 0;

  bool isCourseOwner = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchDataCourse();
  }

  void fetchDataCourse() async {
    isLoading = true;
    final String apiUrl = ApiPaths.getCourseIdPath(widget.courseId);
    FetchObjectFromAPI(apiUrl, setClassCourse);
  }

  void setClassCourse(Object data) {
    setState(() {
      course = Course.fromJson(data as Map<String, dynamic>);
      questions = course.questions.map((question) => QuestionCard(
        question: question.questionString,
        answers: question.answers,
        onAnswerSelected: (Answer? answer) {

        },
      )).toList();
      isLoading = false;
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
  void saveCurrentAnswer(){
    final String apiUrl = ApiPaths.getTestAnswerPath();
    answerQuestion.forEach((key, value){
      setState(() {
        isLoading = true;
      });
      Map<String, dynamic> data = {
        'testId': widget.test.testId,
        'studentId': GlobalData.LoginUser!.id,
        'questionId': key,
        'answerId': value
      };
      AddDataFromAPI(apiUrl, data, setCourseData);
    });
  }
  void setCourseData(Map<String, dynamic> data) {
    setState(() {
      isLoading = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen
      (
        isLoading: isLoading,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Bài kiểm tra: ${course.courseName}'),
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 40),
                  Text(
                    'Câu hỏi ${questions.length == 0 ? 0 : currentQuestionIndex + 1}/${questions.length}:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  if (questions.isNotEmpty)
                    QuestionCard(
                      question: questions[currentQuestionIndex].question,
                      answers: questions[currentQuestionIndex].answers,
                      onAnswerSelected: (Answer? answer) {
                        answerQuestion[answer!.questionId] = answer!.answerId;
                      },
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
              Positioned(
                right: 0,
                top: 0,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return MyAlertDialog(
                          title: "Thông báo",
                          message:  RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Xác nhận nộp bài!',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          onAction: () {
                            saveCurrentAnswer();
                          },
                        );
                      },
                    );
                  },
                  child: Text('Nộp bài',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          )
        )
    );
  }
}


class QuestionCard extends StatefulWidget {
  final String question;
  final List<Answer> answers;
  final ValueChanged<Answer?> onAnswerSelected;

  QuestionCard({required this.question, required this.answers, required this.onAnswerSelected});

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
                  setState(() {
                    selectedAnswer = value;
                    widget.onAnswerSelected(value);
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
