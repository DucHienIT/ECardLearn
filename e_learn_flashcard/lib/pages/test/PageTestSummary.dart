import 'package:flutter/material.dart';
import '../../Util/ApiPaths.dart';
import '../../Util/UtilCallApi.dart';
import '../../model/ModelSummary.dart';

class TestSummaryPage extends StatefulWidget {
  final String testId;

  TestSummaryPage({required this.testId});

  @override
  _TestSummaryPageState createState() => _TestSummaryPageState();
}

class _TestSummaryPageState extends State<TestSummaryPage> {
  List<TestSummary> testSummarys = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTestSummaryData();
  }

  void fetchTestSummaryData() {
    final String apiUrl = ApiPaths.getTestSummaryByTestIdPath(widget.testId);
    FetchDataFromAPI(apiUrl, setSummaryTest);
  }

  void setSummaryTest(List<dynamic> data) {
    setState(() {
      testSummarys.addAll(data.map((item) => TestSummary.fromJson(item)).toList());
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kết quả bài kiểm tra'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? CircularProgressIndicator() // Display loading indicator while fetching data
            : Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Số câu trả lời đúng: ${testSummarys.first.noCorrectAnswer}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Tổng điểm: ${calculateTotalScore(testSummarys.first)}/10',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }



  // Calculate total score based on the number of correct and incorrect answers
  double calculateTotalScore(TestSummary testSummary) {
    int correctAnswers = testSummary.noCorrectAnswer;
    int incorrectAnswers = testSummary.noIncorrectAnswer;

    // Assuming each correct answer is worth 1 point and each incorrect answer deducts 0.5 points
    double totalScore = correctAnswers - (incorrectAnswers * 0.5);

    // Ensure the total score is not negative
    return totalScore < 0 ? 0 : totalScore;
  }
}
