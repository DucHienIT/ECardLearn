import 'package:e_learn_flashcard/model/ModelClass.dart';
import 'package:e_learn_flashcard/model/ModelCourse.dart';
import 'package:e_learn_flashcard/model/ModelGlobalData.dart';
import 'package:flutter/material.dart';

import '../Util/AlertManager.dart';
import '../Util/ApiPaths.dart';
import '../Util/UtilCallApi.dart';
import '../pages/course/PageCourseDetail.dart';

class SearchClassBarApp extends StatefulWidget {
  final List<MyClass> classList;

  const SearchClassBarApp({required this.classList, Key? key}) : super(key: key);

  @override
  State<SearchClassBarApp> createState() => _SearchClassBarAppState();
}

class _SearchClassBarAppState extends State<SearchClassBarApp> {
  bool isDark = false;
  List<MyClass> classes = [];

  void setData(List<dynamic> data)
  {
    setState(() {
      classes = data.map((item) => MyClass.fromJson(item)).toList();
    });
  }
  void joinClass(String classId)
  {
    String apiUrl = ApiPaths.getStudentJoinClassPath();
    Map<String, dynamic> dataBody = {
      'studentId': GlobalData.LoginUser!.id,
      'classId': classId,
    };
    AddDataFromAPI(apiUrl, dataBody, setJoinData);
  }
  void setJoinData(Map<String, dynamic> data)
  {
    print("Join success");
    Navigator.pop(context);
  }
  List<String> getClassIds(List<MyClass> classes) {
    // Sử dụng map để chuyển đổi từ MyClass sang id và thu được danh sách id
    return classes.map((myClass) => myClass.classId).toList();
  }


  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
        useMaterial3: true,
        brightness: isDark ? Brightness.dark : Brightness.light);

    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        appBar: AppBar(title: const Text('Tìm kiếm lớp học')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SearchAnchor(
                  builder: (BuildContext context, SearchController controller) {
                    return SearchBar(
                      controller: controller,
                      padding: const MaterialStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 16.0)),
                      onTap: () {
                      },
                      onChanged: (value) {
                        classes.clear();
                        final String apiUrl = ApiPaths.getListClassPathByName(value, 1, 100); // Thêm từ khóa vào đường dẫn API
                        FetchDataFromAPI(apiUrl, setData);
                      },
                      leading: const Icon(Icons.search),
                      trailing: <Widget>[
                        Tooltip(
                          message: 'Change brightness mode',
                          child: IconButton(
                            isSelected: isDark,
                            onPressed: () {
                              setState(() {
                                isDark = !isDark;
                              });
                            },
                            icon: const Icon(Icons.wb_sunny_outlined),
                            selectedIcon: const Icon(Icons.brightness_2_outlined),
                          ),
                        )
                      ],
                    );
                  },
                  suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                    return classes.map((MyClass classes)  {
                      return ListTile(
                        title: Text(classes.className),
                        onTap: () {
                          setState(() {
                            controller.closeView(classes.classDescription);
                          });
                        },
                      );
                    });
                  }),
              Expanded(
                child: ListView.builder(
                  itemCount: classes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.school),
                      title: Text(classes[index].className, style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(classes[index].classDescription),
                      onTap: () {
                        showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return MyAlertDialog(
                            title: "Xác nhận",
                            message: RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: [
                                  TextSpan(
                                    text: 'Xác nhận vào lớp ',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  TextSpan(
                                    text: '${classes[index].className}!',
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )
                            ,
                            onAction: () {
                              if(getClassIds(widget.classList).contains(classes[index].classId))
                                {
                                  print("Class joined");
                                  return;
                                }
                              joinClass(classes[index].classId);
                            },
                          );
                        },
                      );
                      },
                    );
                  },
                ),
              ),

            ],

          ),

        ),
      ),
    );
  }
}
