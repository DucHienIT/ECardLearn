import 'dart:convert';
import 'package:e_learn_flashcard/Util/ApiPaths.dart';
import 'package:e_learn_flashcard/Util/UtilCallApi.dart';
import 'package:e_learn_flashcard/model/ModelCourse.dart';
import 'package:e_learn_flashcard/pages/course/PageAddCourse.dart';
import 'package:e_learn_flashcard/pages/course/PageCourseDetail.dart';
import 'package:flutter/material.dart';
import '../../Util/AlertManager.dart';
import '../../model/ModelGlobalData.dart';
import '../../model/ModelTopic.dart';
import 'package:http/http.dart' as http;

class ListCoursePage extends StatefulWidget {
  @override
  _ListCoursePageState createState() => _ListCoursePageState();
}

class _ListCoursePageState extends State<ListCoursePage> {
  List<Course> courses = [];
  final String apiUrl = ApiPaths.getCourseListByTeacherIdPath(GlobalData.LoginUser!.id);

  @override
  void initState() {
    super.initState();
    FetchDataFromAPI(apiUrl, setData);
  }

  void setData(List<dynamic> data) {
    setState(() {
      courses = data.map((item) => Course.fromJson(item)).toList();
    });
  }

  void deleteCourse(int courseIndex){
    final String apiUrlDelete = ApiPaths.getCourseIdPath(courses[courseIndex].courseId);
    DeleteDataFromAPI(apiUrlDelete, (){
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách bài học'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: courses.length,
          itemBuilder: (context, index) {
            bool isOwner = courses[index].teacherId == GlobalData.LoginUser!.id;
            return Card(
              child: ListTile(
                leading: Icon(Icons.book),
                title: Text(courses[index].courseName, style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(courses[index].courseDescription),
                trailing:isOwner ? IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return MyAlertDialog(
                          title: "Xác nhận",
                          message:  RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Xóa khóa học này',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          onAction: () {
                            deleteCourse(index);
                          },
                        );
                      },
                    );
                  },
                ) : null,
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
        backgroundColor: Colors.green,
      ),
    );
  }
}
