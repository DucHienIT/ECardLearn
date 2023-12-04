import 'package:e_learn_flashcard/Util/ApiPaths.dart';
import 'package:e_learn_flashcard/Util/UtilCallApi.dart';
import 'package:e_learn_flashcard/model/ModelClass.dart';
import 'package:e_learn_flashcard/model/ModelUser.dart';
import 'package:flutter/material.dart';

import '../Util/AlertManager.dart';
import '../Util/Define.dart';
import '../model/ModelGlobalData.dart';
import '../model/ModelTest.dart';

class ClassMenuWidget extends StatelessWidget {
  final bool isOwner;
  final List<User> studentList;
  final List<Test> lstTest;

  ClassMenuWidget({required this.isOwner ,required this.studentList, required this.lstTest});
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
                  // TODO: Xử lý khi chọn học sinh
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
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
