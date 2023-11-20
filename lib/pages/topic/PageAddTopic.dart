import 'dart:convert';

import 'package:e_learn_flashcard/pages/topic/PageListTopic.dart';
import 'package:flutter/material.dart';

import '../../model/ModelGlobalData.dart';
import 'package:http/http.dart' as http;
import '../../Util/UtilDateTime.dart';

class AddTopicPage extends StatefulWidget {
  @override
  _AddTopicPageState createState() => _AddTopicPageState();
}

class _AddTopicPageState extends State<AddTopicPage> {
  TextEditingController topicNameController = TextEditingController();
  TextEditingController topicDescriptionController = TextEditingController();

  Future<void> sendAddTopicRequest() async {
    final String apiUrl = 'http://3.27.242.207/api/Topic';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GlobalData.Token}',
        },
        body: jsonEncode({
          'topicName': topicNameController.text,
          'topicDescription': topicDescriptionController.text,
        }),
      );

      if (response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListTopicPage(),
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
        title: Text('Thêm Chủ Đề'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: topicNameController,
              decoration: InputDecoration(labelText: 'Tên Chủ Đề'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: topicDescriptionController,
              decoration: InputDecoration(labelText: 'Mô tả Chủ Đề'),
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
