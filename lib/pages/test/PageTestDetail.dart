import 'package:e_learn_flashcard/Util/ApiPaths.dart';
import 'package:e_learn_flashcard/model/ModelGlobalData.dart';
import 'package:e_learn_flashcard/pages/test/PageDoTest.dart';
import 'package:flutter/material.dart';

import '../../Util/AlertManager.dart';
import '../../Util/UtilCallApi.dart';
import '../../model/ModelCourse.dart';
import '../../model/ModelTest.dart';
import 'package:intl/intl.dart';

class DetailTestPage extends StatefulWidget {
  final Test test;

  DetailTestPage({required this.test});

  @override
  _DetailTestPageState createState() => _DetailTestPageState();
}

class _DetailTestPageState extends State<DetailTestPage> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'testName${widget.test.testId}',
          child: Text('Bài kiểm tra: ${widget.test.testName}', style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tên Bài Kiểm Tra: ${widget.test.testName}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Text('Mô Tả Bài Kiểm Tra: ${widget.test.testDescription}', style: TextStyle(fontSize: 16)),
                SizedBox(height: 20),
                Text('Thời gian bắt đầu: ${DateFormat('dd/MM/yyyy HH:mm:ss').format(widget.test.testStart)}', style: TextStyle(fontSize: 16)),
                SizedBox(height: 20),
                Text('Thời gian kết thúc: ${DateFormat('dd/MM/yyyy HH:mm:ss').format(widget.test.testEnd)}', style: TextStyle(fontSize: 16)),
                SizedBox(height: 20),
                Text('Thời lượng: ${widget.test.duration}', style: TextStyle(fontSize: 16)),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoTestPage(courseId: widget.test.courseId),
                        ),
                      );
                    },
                    child: isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Vào kiểm tra', style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // background
                      onPrimary: Colors.white, // foreground
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
