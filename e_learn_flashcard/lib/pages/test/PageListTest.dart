import 'dart:convert';
import 'package:e_learn_flashcard/Util/ApiPaths.dart';
import 'package:e_learn_flashcard/Util/UtilCallApi.dart';
import 'package:e_learn_flashcard/model/ModelCourse.dart';
import 'package:e_learn_flashcard/model/ModelTest.dart';
import 'package:e_learn_flashcard/pages/class/PageAddClass.dart';
import 'package:e_learn_flashcard/pages/class/PageClassDetail.dart';
import 'package:e_learn_flashcard/pages/course/PageAddCourse.dart';
import 'package:e_learn_flashcard/pages/course/PageCourseDetail.dart';
import 'package:e_learn_flashcard/pages/test/PageAddTest.dart';
import 'package:flutter/material.dart';
import '../../Util/AlertManager.dart';
import '../../model/ModelClass.dart';
import '../../model/ModelGlobalData.dart';
import 'package:http/http.dart' as http;

class TestListPage extends StatefulWidget {

  @override
  _TestListPageState createState() => _TestListPageState();
}

class _TestListPageState extends State<TestListPage> {
  List<Test> tests = [];
  final String apiUrl = ApiPaths.getTestPath();

  @override
  void initState() {
    super.initState();
    FetchDataFromAPI(apiUrl, setData);
  }

  void setData(List<dynamic> data) {
    setState(() {
      tests = data.map((item) => Test.fromJson(item)).toList();
    });
  }

  void deleteCourse(int courseIndex){
    /*final String apiUrlDelete = ApiPaths.getClassIdPath(tests[courseIndex].classId);
    DeleteDataFromAPI(apiUrlDelete, (){
      Navigator.pop(context);
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách lớp học của bạn'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: tests.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Icon(Icons.edit_document),
                title: Text(tests[index].testName, style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(tests[index].testDescription),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return MyAlertDialog(
                          title: "Thông báo",
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
                ),
                onTap: () {

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
              builder: (context) => AddTestPage(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
