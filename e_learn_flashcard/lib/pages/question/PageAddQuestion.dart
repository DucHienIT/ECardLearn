import 'package:e_learn_flashcard/model/ModelCourse.dart';
import 'package:e_learn_flashcard/model/ModelGlobalData.dart';
import 'package:flutter/material.dart';

import '../../Util/ApiPaths.dart';
import '../../Util/UtilCallApi.dart';
import '../../model/ModelAnswer.dart';
import '../../model/ModelQuestion.dart';

class AddQuestionPage extends StatefulWidget {
  final Function(Question) onQuestionAdded;
  final Course currentCourse;

  AddQuestionPage({required this.currentCourse, required this.onQuestionAdded});

  @override
  _AddQuestionPageState createState() => _AddQuestionPageState( );
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  late TextEditingController _questionController;
  List<TextEditingController> _answerControllers = [];
  List<bool> _isCorrect = [];

  late Question currentQuestion;

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController();
    _addAnswer();
    addBaseQuestion();
  }
  void addBaseQuestion() {
    final String apiUrl = ApiPaths.getQuestionPath();
    Map<String, dynamic> data = {
      'questionString': 'Câu hỏi',
      'courseId': widget.currentCourse.courseId,
      'answers': []
    };
    AddDataFromAPI(apiUrl, data, setData);
  }
  void setData(Map<String, dynamic> data) {
    setState(() {
      currentQuestion = Question.fromJson(data);
    });
    print(currentQuestion.questionId);
  }


  void deleteBaseQuestion()
  {

  }


  void _addAnswer() {
    _answerControllers.add(TextEditingController());
    _isCorrect.add(false);
  }

  void _updateCorrectAnswer(int index) {
    setState(() {
      for (int i = 0; i < _isCorrect.length; i++) {
        _isCorrect[i] = i == index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm câu hỏi mới'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _questionController,
              decoration: InputDecoration(
                labelText: 'Câu hỏi',
              ),
            ),
            ..._answerControllers.map((controller) {
              int index = _answerControllers.indexOf(controller);
              return Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        labelText: 'Đáp án ${index + 1}',
                      ),
                    ),
                  ),
                  Checkbox(
                    value: _isCorrect[index],
                    onChanged: (value) {
                      _updateCorrectAnswer(index);
                    },
                  ),
                  Text('Đúng'),
                ],
              );
            }).toList(),
            ElevatedButton(
              onPressed: () {
                _addAnswer();
                setState(() {});
              },
              child: Text('Thêm đáp án'),
            ),
            ElevatedButton(
              onPressed: () {
                List<Answer> answers = _answerControllers.map((controller) {
                  int index = _answerControllers.indexOf(controller);
                  return Answer(
                    answerString: controller.text,
                    questionId: currentQuestion.questionId,
                    isCorrect: _isCorrect[index],
                    createdUserId: GlobalData.LoginUser!.id,
                    createdDate: DateTime.now(),
                    updatedUserId: GlobalData.LoginUser!.id,
                    updatedDate: DateTime.now(),
                  );
                }).toList();

                Question newQuestion = Question(
                  questionId: currentQuestion.questionId,
                  questionString: _questionController.text,
                  courseId: widget.currentCourse.courseId,
                  answers: answers,
                  createdUserId: GlobalData.LoginUser!.id,
                  createdDate: DateTime.now(),
                  updatedUserId: GlobalData.LoginUser!.id,
                  updatedDate: DateTime.now(),
                );


                widget.onQuestionAdded(newQuestion);

                Navigator.pop(context);
              },
              child: Text('Thêm câu hỏi'),
            ),
          ],
        ),
      ),
    );
  }
}
