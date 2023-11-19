import 'dart:convert';
import 'package:flutter/material.dart';
import '../../model/ModelCourse.dart';
import 'package:http/http.dart' as http;

import '../../widget/LoadingScreen.dart';

class AddTestPage extends StatefulWidget {
  @override
  _AddTestPageState createState() => _AddTestPageState();
}

class _AddTestPageState extends State<AddTestPage> {
  TextEditingController testNameController = TextEditingController();
  TextEditingController testDescriptionController = TextEditingController();
  List<Course>? listCourse = [];
  late Course selectedCourse = Course.defaultCourse();

  // Hàm xử lý thêm bài kiểm tra
  void addTest() {
    // Thực hiện logic thêm bài kiểm tra, ví dụ gửi yêu cầu API
    // Sử dụng các giá trị từ các controllers và widget.selectedCourse
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm Bài Kiểm Tra'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Thêm các trường nhập liệu cho bài kiểm tra
            TextField(
              controller: testNameController,
              decoration: InputDecoration(labelText: 'Tên Bài Kiểm Tra'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: testDescriptionController,
              decoration: InputDecoration(labelText: 'Mô Tả Bài Kiểm Tra'),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<Course>(
              value: selectedCourse,
              onChanged: (newValue) {
                setState(() {
                  selectedCourse = newValue!;
                });
              },
              items: listCourse!.map<DropdownMenuItem<Course>>((Course course) {
                return DropdownMenuItem<Course>(
                  value: course,
                  child: Text(course.courseName),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Chọn Chủ Đề',
              ),
            ),

            // Thêm nút "Thêm" để xử lý thêm bài kiểm tra
            ElevatedButton(
              onPressed: () {
                // Gọi hàm xử lý thêm bài kiểm tra
                addTest();
              },
              child: Text('Thêm Bài Kiểm Tra'),
            ),
          ],
        ),
      ),
    );
  }


}
