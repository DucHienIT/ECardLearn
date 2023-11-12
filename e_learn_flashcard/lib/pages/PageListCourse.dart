import 'package:flutter/material.dart';

import '../model/ModelCourse.dart';
import 'course/PageCourseDetail.dart'; // Đảm bảo import đúng đường dẫn đến model Course

class ListCoursePage extends StatelessWidget {
  final List<Course> courses; // Danh sách khóa học

  ListCoursePage({required this.courses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách khóa học'),
      ),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return ListTile(
            title: Text(course.courseName),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailCoursePage(course: course),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
