import 'dart:convert';
import 'package:e_learn_flashcard/model/ModelCourse.dart';
import 'package:e_learn_flashcard/pages/course/PageAddCourse.dart';
import 'package:e_learn_flashcard/pages/course/PageCourseDetail.dart';
import 'package:flutter/material.dart';
import '../../model/ModelGlobalData.dart';
import '../../model/ModelTopic.dart';
import 'package:http/http.dart' as http;

class ListCoursePage extends StatefulWidget {
  @override
  _ListCoursePageState createState() => _ListCoursePageState();
}

class _ListCoursePageState extends State<ListCoursePage> {
  List<Course> courses = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
  }

  Future<void> fetchDataFromAPI() async {
    final String apiUrl = 'http://3.27.242.207/api/Course?PageNumber=1&PageSize=10';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'token': GlobalData.Token.toString(),
      },
    );

    if (response.statusCode == 200) {
      // Nếu yêu cầu thành công, giải mã dữ liệu JSON và cập nhật danh sách chủ đề
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        courses = data.map((item) => Course.fromJson(item)).toList();
      });
    } else {
      print("Loi");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách khóa học'),
      ),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(courses[index].courseName),
            subtitle: Text(courses[index].courseDescription),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailCoursePage(course: courses[index]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Xử lý khi nút được nhấn, ví dụ: điều hướng đến trang thêm Topic
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCoursePage(), // Thay thế AddTopicPage bằng tên trang thêm Topic của bạn
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
