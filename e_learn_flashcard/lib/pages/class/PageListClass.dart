import 'dart:convert';
import 'package:e_learn_flashcard/Util/ApiPaths.dart';
import 'package:e_learn_flashcard/Util/UtilCallApi.dart';
import 'package:e_learn_flashcard/model/ModelCourse.dart';
import 'package:e_learn_flashcard/pages/class/PageAddClass.dart';
import 'package:e_learn_flashcard/pages/class/PageClassDetail.dart';
import 'package:e_learn_flashcard/pages/course/PageAddCourse.dart';
import 'package:e_learn_flashcard/pages/course/PageCourseDetail.dart';
import 'package:flutter/material.dart';
import '../../Util/AlertManager.dart';
import '../../model/ModelClass.dart';
import '../../model/ModelGlobalData.dart';
import 'package:http/http.dart' as http;

class ClassListPage extends StatefulWidget {

  @override
  _ClassListPageState createState() => _ClassListPageState();
}

class _ClassListPageState extends State<ClassListPage> {
  List<MyClass> classes = [];
  final String apiUrl = ApiPaths.getListClassByIdTeacherPath(GlobalData.LoginUser!.id);

  @override
  void initState() {
    super.initState();
    FetchDataFromAPI(apiUrl, setData);
  }

  void setData(List<dynamic> data) {
    setState(() {
      classes = data.map((item) => MyClass.fromJson(item)).toList();
    });
  }

  void deleteCourse(int courseIndex){
    final String apiUrlDelete = ApiPaths.getClassIdPath(classes[courseIndex].classId);
    DeleteDataFromAPI(apiUrlDelete, (){
      Navigator.pop(context);
    });
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
          itemCount: classes.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Icon(Icons.book),
                title: Text(classes[index].className, style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(classes[index].classDescription),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return MyAlertDialog(
                          title: "Thông báo",
                          message: "Xóa khóa học này?",
                          onAction: () {
                            deleteCourse(index);
                          },
                        );
                      },
                    );
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClassDetailPage(myClass: classes[index]),
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
              builder: (context) => AddClassPage(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
