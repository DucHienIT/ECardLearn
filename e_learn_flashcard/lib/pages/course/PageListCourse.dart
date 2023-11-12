import 'dart:convert';
import 'package:e_learn_flashcard/Util/ApiPaths.dart';
import 'package:e_learn_flashcard/Util/FetchDataFromAPI.dart';
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
    final String apiUrl = ApiPaths.getCourseListByTeacherIdPath(GlobalData.LoginUser!.id);
    FetchDataFromAPI(apiUrl, setData);
  }

  void setData(List<dynamic> data) {
    setState(() {
      courses = data.map((item) => Course.fromJson(item)).toList();
    });
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
          return Dismissible(
            key: Key(courses[index].courseId), // Key là quan trọng để xác định mục cần xóa
            onDismissed: (direction) {
              // Hàm này được gọi khi người dùng vuốt và xóa mục
              // Thực hiện xóa khóa học ở đây (có thể gọi hàm để gửi yêu cầu xóa API)
              // Sau khi xóa, cập nhật lại danh sách
              // courses.removeAt(index);
            },
            background: Container(
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
            ),
            child: ListTile(
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
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCoursePage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
