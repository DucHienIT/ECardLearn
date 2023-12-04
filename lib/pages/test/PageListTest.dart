import 'dart:convert';
import 'package:e_learn_flashcard/Util/ApiPaths.dart';
import 'package:e_learn_flashcard/Util/UtilCallApi.dart';
import 'package:e_learn_flashcard/model/ModelTest.dart';
import 'package:e_learn_flashcard/pages/test/PageAddTest.dart';
import 'package:e_learn_flashcard/widget/LoadingScreen.dart';
import 'package:flutter/material.dart';
import '../../Util/AlertManager.dart';

import '../../model/ModelGlobalData.dart';
import 'PageTestDetail.dart';

class TestListPage extends StatefulWidget {

  @override
  _TestListPageState createState() => _TestListPageState();
}

class _TestListPageState extends State<TestListPage> {
  List<Test> tests = [];
  final String apiUrl = ApiPaths.getTestBySizePath(1, 100);
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchDataTest();
  }

  void fetchDataTest() async{
    isLoading = true;
    tests = [];
    final String apiUrl = ApiPaths.getTestByUserIdPath(GlobalData.LoginUser!.id);
    FetchDataFromAPI(apiUrl, setListTestData);
    final String apiUrl2 = ApiPaths.getTestByStudentIdPath(GlobalData.LoginUser!.id);
    FetchDataFromAPI(apiUrl2, setListTestData);
  }
  void setListTestData(List<dynamic> data) {
    setState(() {
      tests.addAll(data.map((item) => Test.fromJson(item)).toList());
      isLoading = false;
    });
  }

  void deleteCourse(String id){
    final String apiUrlDelete = ApiPaths.getTestIdPath(id);
    DeleteDataFromAPI(apiUrlDelete, (){
      fetchDataTest();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen
      (
        isLoading: isLoading,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Danh sách bài kiểm tra của bạn'),
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
                                deleteCourse(tests[index].testId);
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
                          builder: (context) => DetailTestPage(test: tests[index]),
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
                  builder: (context) => AddTestPage(),
                ),
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
          ),
        )
    );
  }
}
