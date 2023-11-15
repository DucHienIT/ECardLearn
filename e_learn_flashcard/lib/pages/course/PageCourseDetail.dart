import 'package:e_learn_flashcard/Util/ApiPaths.dart';
import 'package:e_learn_flashcard/model/ModelGlobalData.dart';
import 'package:flutter/material.dart';

import '../../Util/AlertManager.dart';
import '../../Util/UtilCallApi.dart';
import '../../model/ModelAnswer.dart';
import '../../model/ModelCourse.dart';
import '../../model/ModelFlashCard.dart';
import '../../model/ModelQuestion.dart';
import '../question/PageAddQuestion.dart';
import 'package:flash_card/flash_card.dart';

class DetailCoursePage extends StatefulWidget {
  final Course course;

  DetailCoursePage({required this.course});

  @override
  _DetailCoursePageState createState() => _DetailCoursePageState();
}

class _DetailCoursePageState extends State<DetailCoursePage> {
  late Course course;
  List<FlashcardItem> flashcards = [];
  int currentQuestionIndex = 0;

  bool isCourseOwner = false;


  @override
  void initState() {
    super.initState();
    course = widget.course;
    if (course.teacherId == GlobalData.LoginUser!.id) {
      isCourseOwner = true;
    }
    flashcards = course.questions.map((question) => FlashcardItem(
      key: question.questionString,
      meaning: getCorrectAns(question),
      phonetic: '', // You might want to add a 'phonetic' field to your Question model
    )).toList();
  }

  void addQuestion(Question question) {
    setState(() {
      String apiUrl = ApiPaths.getQuestionIdPath(question.questionId);
      UpdateDataFromAPI(apiUrl, question.toJson());
    });
    course.questions.add(question);
    flashcards = course.questions.map((question) => FlashcardItem(
      key: question.questionString,
      meaning: getCorrectAns(question),
      phonetic: '', // You might want to add a 'phonetic' field to your Question model
    )).toList();
  }

  void nextQuestion() {
    setState(() {
      if (currentQuestionIndex < flashcards.length - 1) {
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
  void deleteFlashCardItem() {
    setState(() {
      var currentQuest = course.questions[currentQuestionIndex];
      String apiUrl = ApiPaths.getQuestionIdPath(currentQuest.questionId);
      DeleteDataFromAPI(apiUrl, (){
        course.questions.remove(currentQuest);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DetailCoursePage(course: course),
          ),
        );
      });
    });
  }

  String getCorrectAns(Question question) {
    for (Answer element in question.answers) {
      if (element.isCorrect) {
        return element.answerString;
      }
    }
    return '';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết khóa học'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Câu hỏi ${flashcards.length == 0 ? 0 : currentQuestionIndex + 1}/${flashcards.length}:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            if (flashcards.isNotEmpty)
              buildFlashcardItem(flashcards[currentQuestionIndex]),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: previousQuestion,
                ),
                if (isCourseOwner) IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: deleteFlashCardItem ,
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
      floatingActionButton: isCourseOwner
          ? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddQuestionPage(
                currentCourse: course,
                onQuestionAdded: addQuestion,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      )
          : null,
    );
  }



  Widget buildFlashcardItem(FlashcardItem flashcard) {
    return FlashCard(
      key: Key(flashcard.key),
      frontWidget: Container(
        height: 100,
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text.rich(TextSpan(
              text: 'Đáp án:',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              children: [
                TextSpan(
                  text: flashcard.phonetic,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            )),
            Text.rich(TextSpan(
              children: [
                TextSpan(
                  text: flashcard.meaning,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
      backWidget: Container(
        height: 100,
        width: 100,
        child: Center(
          child: Text(
            flashcard.key,
            style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
      width: 350,
      height: 500,
    );
  }
}
