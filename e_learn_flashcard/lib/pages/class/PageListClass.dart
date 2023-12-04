import 'dart:convert';
import 'package:e_learn_flashcard/Util/ApiPaths.dart';
import 'package:e_learn_flashcard/Util/UtilCallApi.dart';
import 'package:e_learn_flashcard/model/ModelCourse.dart';
import 'package:e_learn_flashcard/pages/class/PageAddClass.dart';
import 'package:e_learn_flashcard/pages/class/PageClassDetail.dart';
import 'package:e_learn_flashcard/widget/SearchClassBarWidget.dart';
import 'package:flutter/material.dart';
import '../../Util/AlertManager.dart';
import '../../Util/Define.dart';
import '../../model/ModelClass.dart';
import '../../model/ModelGlobalData.dart';
import 'package:http/http.dart' as http;
import '../../Util/UtilCommon.dart';

class ClassListPage extends StatefulWidget {

  @override
  _ClassListPageState createState() => _ClassListPageState();
}

class _ClassListPageState extends State<ClassListPage> {
  List<MyClass> classes = [];
  final String apiUrl = ApiPaths.getListClassByIdTeacherPath(GlobalData.LoginUser!.id);
  final String apiUrlClassJoin = ApiPaths.getListClassByIdStudentPath(GlobalData.LoginUser!.id);
  bool _isTeacher = UtilCommon.IsTeacher();

  @override
  void initState() {
    super.initState();
    if (_isTeacher){
      FetchDataFromAPI(apiUrl, setData);
    }
    FetchDataFromAPI(apiUrlClassJoin, setData);
  }

  void setData(List<dynamic> data) {
    setState(() {
      classes.addAll(data.map((item) => MyClass.fromJson(item)).toList());
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
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.search),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: SearchClassBarApp(classList: classes),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: classes.length,
          itemBuilder: (context, index) {
            bool isOwner = classes[index].teacherId == GlobalData.LoginUser!.id;
            return Card(
              child: ListTile(
                leading: Icon(Icons.school),
                title: Text(classes[index].className, style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(classes[index].classDescription),
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
                                  text: 'Xóa khóa học này?',
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
