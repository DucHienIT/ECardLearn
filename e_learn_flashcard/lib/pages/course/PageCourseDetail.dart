import 'package:flutter/material.dart';

import '../../model/ModelCourse.dart';

class DetailCoursePage extends StatelessWidget {
  final Course course;

  DetailCoursePage({required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết khóa học'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.courseName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              course.courseDescription,
              style: TextStyle(fontSize: 18),
            ),
            Text('Mã môn học: ${course.topicId}'),
            Text('Mã giáo viên: ${course.teacherId}'),
            Text('Ngày tạo: ${course.createdDate.toLocal()}'),
            Text('Ngày cập nhật: ${course.updatedDate.toLocal()}'),
          ],
        ),
      ),
    );
  }
}
