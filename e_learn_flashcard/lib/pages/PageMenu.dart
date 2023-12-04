import 'dart:convert';

import 'package:e_learn_flashcard/Util/UtilCommon.dart';
import 'package:e_learn_flashcard/model/ModelGlobalData.dart';
import 'package:e_learn_flashcard/pages/course/PageListCourse.dart';
import 'package:e_learn_flashcard/pages/question/PageGenerateQuestion.dart';
import 'package:e_learn_flashcard/pages/test/PageListTest.dart';
import 'package:e_learn_flashcard/pages/topic/PageListTopic.dart';
import 'package:e_learn_flashcard/pages/user/PageChooseRole.dart';
import 'package:flutter/material.dart';
import '../model/ModelClass.dart';
import '../widget/MainMenuWidget.dart';
import '../widget/SearchCourseBarWidget.dart';
import 'class/PageListClass.dart'; // Import your class list page

class PageMenu extends StatelessWidget {
  final TextEditingController keywordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trang chủ'),
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.search),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
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
      endDrawer: SearchCourseBarApp(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20), // Add spacing
            MainMenuCard(
              title: 'Quản lý lớp', // Menu category 1
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClassListPage()),
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
              title: 'Danh sách bài kiểm tra', // Menu category 2
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TestListPage()),
                );
              },
            ),
            SizedBox(height: 20), // Add spacing
            MainMenuCard(
              permis: UtilCommon.IsTeacher(),
              title: 'Tạo bài học với trợ lý ảo', // Menu category 2
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FlashCardGenerate()),
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
  final bool? permis;
  final String title;
  final VoidCallback onTap;

  MainMenuCard({this.permis, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return (permis ?? true) ? Container(
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
    ) : Container();
  }
}
