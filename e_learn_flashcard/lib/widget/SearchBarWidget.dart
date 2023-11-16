import 'package:e_learn_flashcard/model/ModelCourse.dart';
import 'package:flutter/material.dart';

import '../Util/ApiPaths.dart';
import '../Util/UtilCallApi.dart';
import '../model/ModelGlobalData.dart';
import '../pages/course/PageCourseDetail.dart';

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  bool isDark = false;
  List<Course> courses = [];
  void setData(List<dynamic> data)
  {
    print("jj");
    setState(() {
      courses = data.map((item) => Course.fromJson(item)).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
        useMaterial3: true,
        brightness: isDark ? Brightness.dark : Brightness.light);

    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        appBar: AppBar(title: const Text('Tìm kiếm khóa học')),
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
                        courses.clear();
                        final String apiUrl = ApiPaths.getCourseListPathByName(value, 1, 10); // Thêm từ khóa vào đường dẫn API
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
                return courses.map((Course course)  {
                  return ListTile(
                    title: Text(course.courseName),
                    onTap: () {
                      setState(() {
                        controller.closeView(course.courseName);
                      });
                    },
                  );
                });
              }),
              Expanded(
                child: ListView.builder(
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.book),
                      title: Text(courses[index].courseName, style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(courses[index].courseDescription),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailCoursePage(course: courses[index]),
                          ),
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
