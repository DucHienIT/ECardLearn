import 'dart:convert';
import 'package:e_learn_flashcard/Util/ApiPaths.dart';
import 'package:e_learn_flashcard/model/ModelTopic.dart';
import 'package:e_learn_flashcard/pages/class/PageListClass.dart';
import 'package:e_learn_flashcard/pages/course/PageListCourse.dart';
import 'package:flutter/material.dart';
import '../../Util/UtilCallApi.dart';
import '../../model/ModelGlobalData.dart';
import 'package:http/http.dart' as http;

import '../LoadingScreen.dart';

class AddClassPage extends StatefulWidget {
  @override
  _AddClassPageState createState() => _AddClassPageState();
}

class _AddClassPageState extends State<AddClassPage> {
  TextEditingController courseNameController = TextEditingController();
  TextEditingController courseDescriptionController = TextEditingController();

  bool isLoading = false; // Add a loading indicator flag


  void sendAddClassRequest()
  {
    final String apiUrl = ApiPaths.getClassPath();
    Map<String, dynamic> data = {
      'className': courseNameController.text,
      'classDescription': courseDescriptionController.text,
      'teacherId': GlobalData.LoginUser!.id,
    };
    AddDataFromAPI(apiUrl, data, setData);
  }
  void setData(Map<String, dynamic> data) {
    Navigator.pushReplacement (
      context,
      MaterialPageRoute(
        builder: (context) => ClassListPage(),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      isLoading: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Thêm Lớp Học'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: courseNameController,
                decoration: InputDecoration(labelText: 'Tên Lớp Học'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: courseDescriptionController,
                decoration: InputDecoration(labelText: 'Mô tả Lớp Học'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Call the function to send the add course request when the "Thêm" button is pressed
                  sendAddClassRequest();
                },
                child: Text('Thêm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
