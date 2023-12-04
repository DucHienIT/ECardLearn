import 'package:e_learn_flashcard/model/ModelGlobalData.dart';
import 'package:e_learn_flashcard/widget/LoadingScreen.dart';
import 'package:flutter/material.dart';

import '../../Util/AlertManager.dart';
import '../../Util/ApiPaths.dart';
import '../../Util/UtilCallApi.dart';
import '../../model/ModelClass.dart';
import '../../model/ModelCourse.dart';
import '../../model/ModelTest.dart';
import '../../model/ModelUser.dart';
import '../../widget/ClassMenuWidget.dart';
import '../course/PageCourseDetail.dart';

class ClassDetailPage extends StatefulWidget {
  final MyClass myClass;

  ClassDetailPage({required this.myClass});

  @override
  _ClassDetailPageState createState() => _ClassDetailPageState();
}

class _ClassDetailPageState extends State<ClassDetailPage> {
  List<Course> lstCourses = [];
  List<User> lstStudent = [];
  List<Test> lstTest = [];
  late MyClass thisClass = new MyClass.defaultClass();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchDataClass();
    fetchDataCourse();
    fetchDataStudent();
    fetchDataTest();
    print(widget.myClass.classId);
  }

  void fetchDataCourse() async {
    _isLoading = true;
    final String apiUrl = ApiPaths.getCourseListByTeacherIdPath(GlobalData.LoginUser!.id);
    FetchDataFromAPI(apiUrl, setDataCourse);
  }
  void fetchDataClass() async {
    _isLoading = true;
    final String apiUrl = ApiPaths.getClassIdPath(widget.myClass.classId);
    FetchObjectFromAPI(apiUrl, setClassData);
  }
  void fetchDataStudent() async{
    final String apiUrl = ApiPaths.GetStudentByClassIdPath(widget.myClass.classId);
    FetchDataFromAPI(apiUrl, setListStudentData);
  }
  void fetchDataTest() async{
    final String apiUrl = ApiPaths.getTestByUserIdPath(GlobalData.LoginUser!.id);
    FetchDataFromAPI(apiUrl, setListTestData);
  }

  void setClassData(Object data) {
    setState(() {
      thisClass = MyClass.fromJson(data as Map<String, dynamic>);
    });
    _isLoading = false;
  }
  void setDataCourse(List<dynamic> data) {
    setState(() {
      lstCourses = data.map((item) => Course.fromJson(item)).toList();
    });
    _isLoading = false;
  }
  void setListStudentData(List<dynamic> data) {
    setState(() {
      lstStudent = data.map((item) => User.fromJson(item)).toList();
    });
  }
  void setListTestData(List<dynamic> data) {
    setState(() {
      lstTest = data.map((item) => Test.fromJson(item)).toList();
    });
  }

  void addCourseIntoClass(String courseId){
    _isLoading = true;
    final String apiUrl = ApiPaths.getCourseInClassPath();
    Map<String, dynamic> data = {
      'courseId': courseId,
      'classId': widget.myClass.classId,
    };
    AddDataFromAPI(apiUrl, data, setCourseData);
  }
  void setCourseData(Map<String, dynamic> data) {
    setState(() {
      fetchDataClass();
    });
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
        isLoading: _isLoading,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.myClass.className),
            actions: <Widget>[
              Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.people),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
              ),
            ],
          ),
          endDrawer: ClassMenuWidget(isOwner: GlobalData.LoginUser!.id == thisClass.teacherId ,
              studentList: lstStudent, lstTest: lstTest),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 16.0),
                Text('Danh sách bài học:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8.0),
                Expanded(
                  child: thisClass.courses != null && thisClass.courses!.isNotEmpty
                      ? ListView.builder(
                    itemCount: thisClass.courses!.length,
                    itemBuilder: (context, index) {
                      final course = thisClass.courses![index];
                      return ListTile(
                        leading: Icon(Icons.book),
                        title: Text(thisClass.courses![index].courseName, style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(thisClass.courses![index].courseDescription),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailCoursePage(course: thisClass.courses![index]),
                            ),
                          );
                        },
                      );
                    },
                  )
                      : Center(
                    child: Text('Không có bài học.'),
                  ),
                ),
              ],
            ),
          ),
           floatingActionButton: widget.myClass.teacherId == GlobalData.LoginUser!.id ? FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Chọn khóa học để thêm vào lớp:'),
                        SizedBox(height: 16.0),
                        Expanded(
                          child: ListView.builder(
                            itemCount: lstCourses.length,
                            itemBuilder: (context, index) {
                              final course = lstCourses[index];
                              return Card(
                                elevation: 2.0,
                                margin: EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  title: Text(course.courseName),
                                  subtitle: Text(course.courseDescription),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return MyAlertDialog(
                                          title: "Xác nhận",
                                          message: RichText(
                                            text: TextSpan(
                                              style: DefaultTextStyle.of(context).style,
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: 'Thêm ',
                                                  style: TextStyle(fontSize: 18),
                                                ),
                                                TextSpan(
                                                  text: course.courseName,
                                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                ),
                                                TextSpan(
                                                  text: ' vào lớp.',
                                                  style: TextStyle(fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onAction: () {
                                            addCourseIntoClass(course.courseId);
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
          ) : null,
        ));
  }
}
