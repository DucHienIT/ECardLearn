import 'dart:convert';

import 'package:e_learn_flashcard/model/ModelGlobalData.dart';
import 'package:e_learn_flashcard/pages/course/PageListCourse.dart';
import 'package:e_learn_flashcard/pages/topic/PageListTopic.dart';
import 'package:e_learn_flashcard/pages/user/PageChooseRole.dart';
import 'package:flutter/material.dart';
import '../model/ModelClass.dart';
import '../widget/MainMenuWidget.dart';
import 'class/PageListClass.dart'; // Import your class list page

class PageMenu extends StatelessWidget {
  final TextEditingController keywordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trang chủ'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: MainMenuWidget(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20), // Add spacing
            MainMenuCard(
              title: 'Quản lý lớp', // Menu category 1
              onTap: () {
                final List<MyClass> classes = [
                  MyClass(
                    className: 'Lớp học A',
                    classDescription: 'Lớp học mô tả A',
                    teacherId: 'GV001',
                    createdUserId: 'User001',
                    createdDate: DateTime.now(),
                    updatedUserId: 'User001',
                    updatedDate: DateTime.now(),
                  ),
                  MyClass(
                    className: 'Lớp học B',
                    classDescription: 'Lớp học mô tả B',
                    teacherId: 'GV002',
                    createdUserId: 'User002',
                    createdDate: DateTime.now(),
                    updatedUserId: 'User002',
                    updatedDate: DateTime.now(),
                  ),
                ];
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClassListPage(classes: classes)),
                );
              },
            ),
            SizedBox(height: 20), // Add spacing
            MainMenuCard(
              title: 'Danh sách chủ đề', // Menu category 2
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListTopicPage()),
                );
              },
            ),
            SizedBox(height: 20), // Add spacing
            MainMenuCard(
              title: 'Danh sách bài học', // Menu category 2
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListCoursePage()),
                );
              },
            ),
            SizedBox(height: 20), // Add spacing
            MainMenuCard(
              title: 'Test', // Menu category 2
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChooseRolePage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MainMenuCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  MainMenuCard({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20), // Thêm lề ngang
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // Thêm khung
        borderRadius: BorderRadius.circular(10), // Bo góc khung
      ),
      child: Card(
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
