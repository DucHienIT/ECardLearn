import 'package:e_learn_flashcard/Util/ApiPaths.dart';
import 'package:e_learn_flashcard/Util/UtilCallApi.dart';
import 'package:e_learn_flashcard/model/ModelClass.dart';
import 'package:e_learn_flashcard/model/ModelUser.dart';
import 'package:flutter/material.dart';

import '../Util/AlertManager.dart';
import '../model/ModelNotification.dart';
import '../model/ModelTest.dart';
import 'SearchStudentBarWidget.dart';

class ClassMenuWidget extends StatelessWidget {
  final bool isOwner;
  final List<User> studentList;
  final List<Test> lstTest;
  final MyClass thisClass;

  ClassMenuWidget({required this.isOwner, required this.thisClass ,required this.studentList, required this.lstTest});
  String UrlApi = ApiPaths.getStudentJoinTestPath();



  void JoinListStudentToTest(String testId)
  {
    studentList.forEach((element) {
      JoinStudentToTest(element, testId);
    });
  }

  void JoinStudentToTest(User student, String testId)
  {
    Map<String, dynamic> dataBody = {
      'studentId': student.id,
      'testId': testId,
    };
    AddDataFromAPI(UrlApi, dataBody, setData);
  }
  void setData(Map<String, dynamic> data) {
    print("Thêm thành công");
  }

  void addStudentJoinClass(User user)
  {
    String apiUrl = ApiPaths.getStudentJoinClassPath();
    Map<String, dynamic> dataBody = {
      'studentId': user.id,
      'classId': thisClass.classId,
    };
    AddDataFromAPI(apiUrl, dataBody, setJoinData);
    studentList.add(user);
  }
  void setJoinData(Map<String, dynamic> data)
  {
  }
  void removeStudentJoinClass(User user){
    String apiUrl = ApiPaths.getStudentJoinClassIdPath(user.id);
    DeleteDataFromAPI(apiUrl, (){

    });
    studentList.remove(user);
  }
  void addNotiTestForClass(Test test)
  {
    String apiUrl = ApiPaths.getNotificationPath();
    Notifi noti = Notifi(
        notificationTitle: "Thông báo  bài kiểm tra mới",
        notificationContent: "Bài kiểm tra " + test.testName + " được thêm vào lớp.",
        classId: thisClass.classId,
        teacherId: thisClass.teacherId);
    AddDataFromAPI(apiUrl, noti.toJson(), setJoinData);
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ExpansionTile(
            title: Text('Học sinh trong lớp'),
            children: studentList.map((student) {
              return ListTile(
                title: Text(student.name),
                // Thêm xử lý khi nhấn vào học sinh
                onTap: () {
                  Navigator.pop(context);
                },
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Xác nhận xóa học sinh'),
                          content: Text('Bạn có chắc chắn muốn xóa học sinh ${student.name}?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                removeStudentJoinClass(student);
                                Navigator.pop(context); // Close the dialog
                              },
                              child: Text('Xóa'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              child: Text('Hủy'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              );
            }).toList(),
          ),
          isOwner ? ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                    return SearchStudentBarApp(
                      onUserSelected: (User user) {
                        addStudentJoinClass(user);
                        Navigator.pop(context);
                    },
                  );
                },
              );
            },
            child: Text('Thêm học sinh vào lớp'),
          ) : SizedBox(),
          isOwner ? ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Chọn bài kiểm tra cho học sinh:'),
                        SizedBox(height: 16.0),
                        Expanded(
                          child: ListView.builder(
                            itemCount: lstTest.length,
                            itemBuilder: (context, index) {
                              final test = lstTest[index];
                              return Card(
                                elevation: 2.0,
                                margin: EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  title: Text(test.testName),
                                  subtitle: Text(test.testDescription),
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
                                                  text: test.testName,
                                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                ),
                                                TextSpan(
                                                  text: ' cho học sinh kiểm tra.',
                                                  style: TextStyle(fontSize: 18),
                                                ),
                                              ],
                                            ),
                                          ),
                                          onAction: () {
                                            JoinListStudentToTest(test.testId);
                                            addNotiTestForClass(test);
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
            child: Text('Thêm Bài Kiểm Tra'),
          ) : SizedBox(),
        ],

      ),

    );
  }
}
