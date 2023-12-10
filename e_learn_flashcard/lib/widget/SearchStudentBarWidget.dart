import 'package:e_learn_flashcard/model/ModelClass.dart';
import 'package:e_learn_flashcard/model/ModelCourse.dart';
import 'package:e_learn_flashcard/model/ModelGlobalData.dart';
import 'package:flutter/material.dart';

import '../Util/AlertManager.dart';
import '../Util/ApiPaths.dart';
import '../Util/UtilCallApi.dart';
import '../model/ModelUser.dart';
import '../pages/course/PageCourseDetail.dart';

class SearchStudentBarApp extends StatefulWidget {

  final void Function(User user) onUserSelected;
  SearchStudentBarApp({required this.onUserSelected});
  @override
  State<SearchStudentBarApp> createState() => _SearchStudentBarAppState();
}

class _SearchStudentBarAppState extends State<SearchStudentBarApp> {
  bool isDark = false;
  List<User> users = [];

  void setData(List<dynamic> data)
  {
    setState(() {
      users = data.map((item) => User.fromJson(item)).toList();
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
        appBar: AppBar(title: const Text('Tìm kiếm học sinh')),
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
                        users.clear();
                        final String apiUrl = ApiPaths.getUser('',value); // Thêm từ khóa vào đường dẫn API
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
                    return users.map((User classes)  {
                      return ListTile(
                        title: Text(classes.name),
                        onTap: () {
                          setState(() {
                            controller.closeView(classes.email);
                          });
                        },
                      );
                    });
                  }),
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.school),
                      title: Text(users[index].name, style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(users[index].email),
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
                                      text: 'Xác nhận thêm học sinh này vào lớp ',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    TextSpan(
                                      text: '${users[index].name}!',
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                              ,
                              onAction: () {
                                widget.onUserSelected(users[index]);
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
