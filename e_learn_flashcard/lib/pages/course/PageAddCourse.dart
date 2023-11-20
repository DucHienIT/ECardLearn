import 'dart:convert';
import 'package:e_learn_flashcard/Util/ApiPaths.dart';
import 'package:e_learn_flashcard/model/ModelTopic.dart';
import 'package:e_learn_flashcard/pages/course/PageListCourse.dart';
import 'package:flutter/material.dart';
import '../../Util/UtilCallApi.dart';
import '../../model/ModelGlobalData.dart';
import 'package:http/http.dart' as http;

import '../../widget/LoadingScreen.dart';

class AddCoursePage extends StatefulWidget {
  @override
  _AddCoursePageState createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  TextEditingController courseNameController = TextEditingController();
  TextEditingController courseDescriptionController = TextEditingController();

  List<Topic>? listTopic = [];
  late Topic selectedTopic = listTopic![0];
  bool isLoading = false; // Add a loading indicator flag

  @override
  void initState() {
    super.initState();
    // Initialize selectedTopic with the first topic from the list
    fetchDataFromAPI();
  }

  Future<void> fetchDataFromAPI() async {
    setState(() {
      isLoading = true; // Set loading to true before making the request
    });

    try {
      final String apiUrl = ApiPaths.getTopicListPath(1, 100);
      await FetchDataFromAPI(apiUrl, setData);
    } finally {
      setState(() {
        isLoading = false; // Set loading to false when the request is complete
      });
    }
  }

  void setData(List<dynamic> data) {
    setState(() {
      listTopic = data.map((item) => Topic.fromJson(item)).toList();
    });
    GlobalData.ListTopic = listTopic;
  }

  Future<void> sendAddCourseRequest() async {
    final String apiUrl = ApiPaths.getCoursePath();

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GlobalData.Token}',
        },
        body: jsonEncode({
          'courseName': courseNameController.text,
          'courseDescription': courseDescriptionController.text,
          'topicId': selectedTopic.topicId,
          'teacherId': GlobalData.LoginUser!.id,
        }),
      );

      if (response.statusCode == 201) {
        Navigator.pushReplacement (
          context,
          MaterialPageRoute(
            builder: (context) => ListCoursePage(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.statusCode.toString()),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      // Handle connection or other errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      isLoading: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Thêm Bài Học'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: courseNameController,
                decoration: InputDecoration(labelText: 'Tên Bài Học'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: courseDescriptionController,
                decoration: InputDecoration(labelText: 'Mô tả Bài Học'),
              ),
              SizedBox(height: 20),
              if (listTopic != null && listTopic!.isNotEmpty)
                DropdownButtonFormField<Topic>(
                  value: selectedTopic,
                  onChanged: (newValue) {
                    setState(() {
                      selectedTopic = newValue!;
                    });
                  },
                  items: listTopic!.map<DropdownMenuItem<Topic>>((Topic topic) {
                    return DropdownMenuItem<Topic>(
                      value: topic,
                      child: Text(topic.topicName),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Chọn Chủ Đề',
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Call the function to send the add course request when the "Thêm" button is pressed
                  sendAddCourseRequest();
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
