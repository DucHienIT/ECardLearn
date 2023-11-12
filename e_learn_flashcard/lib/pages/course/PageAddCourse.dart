import 'dart:convert';

import 'package:e_learn_flashcard/model/ModelTopic.dart';
import 'package:e_learn_flashcard/pages/course/PageListCourse.dart';
import 'package:flutter/material.dart';

import '../../model/ModelGlobalData.dart';
import 'package:http/http.dart' as http;

class AddCoursePage extends StatefulWidget {
  @override
  _AddCoursePageState createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  TextEditingController topicNameController = TextEditingController();
  TextEditingController topicDescriptionController = TextEditingController();

  late String selectedTopic = '';

  Future<void> sendAddTopicRequest() async {
    final String apiUrl = 'http://3.27.242.207/api/Course';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'token': GlobalData.Token.toString(),
        },
        body: jsonEncode({
          'courseName': topicNameController.text,
          'courseDescription': topicDescriptionController.text,
          'topicId': 'eb629555-f23f-4215-fc55-08dbe350dd95',
          'teacherId': GlobalData.LoginUser!.id
        }),
      );

      if (response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListCoursePage(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.statusCode.toString()),
            duration: const Duration(seconds: 3), // Đặt thời gian hiển thị
          ),
        );
      }
    } catch (e) {
      // Xử lý khi có lỗi kết nối hoặc lỗi khác
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm Bài Học'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: topicNameController,
              decoration: InputDecoration(labelText: 'Tên Bài Học'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: topicDescriptionController,
              decoration: InputDecoration(labelText: 'Mô tả Bài Học'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Gọi hàm để gửi yêu cầu thêm chủ đề khi nút "Thêm" được nhấn
                sendAddTopicRequest();
              },
              child: Text('Thêm'),
            ),
          ],
        ),
      ),
    );
  }
}
