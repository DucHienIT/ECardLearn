import 'dart:convert';
import 'dart:ffi';
import 'package:e_learn_flashcard/model/ModelTest.dart';
import 'package:flutter/material.dart';
import '../../Util/ApiPaths.dart';
import '../../Util/UtilCallApi.dart';
import '../../model/ModelCourse.dart';
import 'package:intl/intl.dart';
import '../../model/ModelGlobalData.dart';
import '../../widget/LoadingScreen.dart';

class AddTestPage extends StatefulWidget {
  @override
  _AddTestPageState createState() => _AddTestPageState();
}

class _AddTestPageState extends State<AddTestPage> {

  TextEditingController testNameController = TextEditingController();
  TextEditingController testDescriptionController = TextEditingController();
  TextEditingController testStartController = TextEditingController();
  TextEditingController testEndController = TextEditingController();
  TextEditingController durationController = TextEditingController();

  bool _isLoading = false;
  List<Course>? listCourse = [];
  late Course selectedCourse = Course.defaultCourse();

  final String apiUrl = ApiPaths.getCourseListByTeacherIdPath(GlobalData.LoginUser!.id);

  @override
  void initState() {
    super.initState();
    FetchDataFromAPI(apiUrl, setData);
  }

  void setData(List<dynamic> data) {
    setState(() {
      listCourse = data.map((item) => Course.fromJson(item)).toList();
      selectedCourse = listCourse![0];
    });
  }
  // Hàm xử lý thêm bài kiểm tra
  void addTest() {
    _isLoading = true;
    Test newTest = Test(
        testId: '',
        testName: testNameController.text,
        testDescription: testDescriptionController.text,
        testStart: DateTime.parse(testStartController.text),
        testEnd: DateTime.parse(testEndController.text),
        duration: int.parse(durationController.text),
        courseId: selectedCourse.courseId);

    String apiAddTestUrl = ApiPaths.getTestPath();
    AddDataFromAPI(apiAddTestUrl, newTest.toJson(), setTestData);
  }
  void setTestData(Map<String, dynamic> data) {
    setState(() {
      _isLoading = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      isLoading: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Thêm Bài Kiểm Tra'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Thêm các trường nhập liệu cho bài kiểm tra
              TextField(
                controller: testNameController,
                decoration: InputDecoration(
                  labelText: 'Tên Bài Kiểm Tra',
                  prefixIcon: Icon(Icons.drive_file_rename_outline),  // Add this line
                ),
              ),

              SizedBox(height: 20),
              TextField(
                controller: testDescriptionController,
                decoration: InputDecoration(
                    labelText: 'Mô Tả Bài Kiểm Tra',
                    prefixIcon: Icon(Icons.description)
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: testStartController,
                decoration: InputDecoration(
                  labelText: 'Thời gian bắt đầu',
                  prefixIcon: Icon(Icons.timer),
                ),
                onTap: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2025),
                  );
                  if (pickedDate != null) {
                    final TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      DateTime pickedDateTime = DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );
                      //String formattedDateTime = DateFormat('dd/MM/yyyy HH:mm:ss').format(pickedDateTime);
                      testStartController.text = pickedDateTime.toIso8601String();
                    }
                  }
                },
              ),
              SizedBox(height: 20),
              TextField(
                controller: testEndController,
                decoration: InputDecoration(
                  labelText: 'Thời gian kết thúc',
                  prefixIcon: Icon(Icons.timer),
                ),
                onTap: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2025),
                  );
                  if (pickedDate != null) {
                    final TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      DateTime pickedDateTime = DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );
                      //String formattedDateTime = DateFormat('dd/MM/yyyy HH:mm:ss').format(pickedDateTime);
                      //testEndController.text = formattedDateTime;
                      testEndController.text = pickedDateTime.toIso8601String();
                    }
                  }
                },
              ),
              SizedBox(height: 20),
              TextField(
                controller: durationController,
                decoration: InputDecoration(labelText: 'Tổng thời gian (phút)',
                    prefixIcon: Icon(Icons.countertops)),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              if (listCourse != null && listCourse!.isNotEmpty)
                DropdownButtonFormField<Course>(
                  value: selectedCourse,
                  onChanged: (newValue) {
                    setState(() {
                      selectedCourse = newValue!;
                    });
                  },
                  items: listCourse!.map<DropdownMenuItem<Course>>((Course course) {
                    return DropdownMenuItem<Course>(
                      value: course,
                      child: Text(course.courseName),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                      labelText: 'Chọn Bài Học',
                      prefixIcon: Icon(Icons.document_scanner)
                  ),
                ),
              SizedBox(height: 20),

              // Thêm nút "Thêm" để xử lý thêm bài kiểm tra
              ElevatedButton(
                onPressed: () {
                  addTest();
                },
                child: Text('Thêm Bài Kiểm Tra'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
