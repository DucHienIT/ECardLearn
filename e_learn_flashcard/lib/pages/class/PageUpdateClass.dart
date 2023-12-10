import 'dart:convert';
import 'package:e_learn_flashcard/Util/ApiPaths.dart';
import 'package:e_learn_flashcard/model/ModelClass.dart';
import 'package:e_learn_flashcard/model/ModelTopic.dart';
import 'package:e_learn_flashcard/pages/class/PageListClass.dart';
import 'package:e_learn_flashcard/pages/course/PageListCourse.dart';
import 'package:flutter/material.dart';
import '../../Util/UtilCallApi.dart';
import '../../model/ModelGlobalData.dart';
import 'package:http/http.dart' as http;

import '../../widget/LoadingScreen.dart';

class UpdateClassPage extends StatefulWidget {
  final MyClass thisClass;
  UpdateClassPage({required this.thisClass});
  @override
  _UpdateClassPageState createState() => _UpdateClassPageState();
}

class _UpdateClassPageState extends State<UpdateClassPage> {
  TextEditingController courseNameController = TextEditingController();
  TextEditingController courseDescriptionController = TextEditingController();

  bool isLoading = false; // Add a loading indicator flag
  @override
  void initState() {
    super.initState();
    setupOldData();
  }
  void setupOldData(){
    courseNameController.text = widget.thisClass.className;
    courseDescriptionController.text = widget.thisClass.classDescription;
  }

  void sendAddClassRequest()
  {
    final String apiUrl = ApiPaths.getClassIdPath(widget.thisClass.classId);
    Map<String, dynamic> data = {
      'classId': widget.thisClass.classId,
      'className': courseNameController.text,
      'classDescription': courseDescriptionController.text,
      'teacherId': GlobalData.LoginUser!.id,
    };
    UpdateDataFromAPI(apiUrl, data);
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
                  Navigator.pop(context);
                  Navigator.pushReplacement (
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClassListPage(),
                    ),
                  );
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
