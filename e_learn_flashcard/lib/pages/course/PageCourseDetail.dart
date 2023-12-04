import 'package:e_learn_flashcard/Util/ApiPaths.dart';
import 'package:e_learn_flashcard/model/ModelGlobalData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../Util/AlertManager.dart';
import '../../Util/UtilCallApi.dart';
import '../../model/ModelAnswer.dart';
import '../../model/ModelCourse.dart';
import '../../model/ModelFlashCard.dart';
import '../../model/ModelQuestion.dart';
import '../../model/ModelReview.dart';
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
  List<Review> feedbacks = [];
  List<FlashcardItem> flashcards = [];
  int currentQuestionIndex = 0;

  bool isCourseOwner = false;
  final _descriptionController = TextEditingController();
  double _rating = 0.0;

  @override
  void initState() {
    super.initState();
    course = widget.course;
    fetchDataClass();
    if (course.teacherId == GlobalData.LoginUser!.id) {
      isCourseOwner = true;
    }
    fetchDataFeedback();
  }

  void fetchDataClass() async {
    final String apiUrl = ApiPaths.getCourseIdPath(widget.course.courseId);
    FetchObjectFromAPI(apiUrl, setClassCourse);
  }
  void fetchDataFeedback() async {
    final String apiUrl = ApiPaths.getFeedbackByCourseIdPath(widget.course.courseId);
    FetchDataFromAPI(apiUrl, setFeedbackCourse);
  }
  void setClassCourse(Object data) {
    setState(() {
      course = Course.fromJson(data as Map<String, dynamic>);

      flashcards = course.questions.map((question) => FlashcardItem(
        key: question.questionString,
        meaning: getCorrectAns(question),
        phonetic: '', // You might want to add a 'phonetic' field to your Question model
      )).toList();
    });
  }
  void setFeedbackCourse(List<dynamic> data) {
    setState(() {
      feedbacks.addAll(data.map((item) => Review.fromJson(item)).toList());
    });
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
  void addReview(){
    Review newReview = Review(
        title: GlobalData.LoginUser!.name,
        description: _descriptionController.text,
        rating: _rating.toInt(),
        userId: GlobalData.LoginUser!.id,
        courseId: course.courseId);

    String apiAddFeedbackUrl = ApiPaths.getFeedbackPath();
    AddDataFromAPI(apiAddFeedbackUrl, newReview.toJson(), setTestData);
  }
  void setTestData(Map<String, dynamic> data) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DetailCoursePage(course: course),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Bài học: ${course.courseName}'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              isCourseOwner ? ElevatedButton(
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
                child: Text('Thêm câu hỏi'),
              ) : SizedBox(),
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
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),

                child: Column(
                  children: [
                    SizedBox(height: 10),
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        hintText: 'Bình luận',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _rating = rating;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: addReview,
                      child: Text('Thêm đánh giá'),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: feedbacks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(feedbacks[index].title),
                    subtitle: Text(feedbacks[index].description),
                    trailing: Text('Rating: ${feedbacks[index].rating}'),
                  );
                },
              ),

            ],
          ),
        ),
      ),
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
