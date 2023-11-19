import 'package:e_learn_flashcard/model/ModelUser.dart';
import 'package:flutter/material.dart';

class ClassMenuWidget extends StatelessWidget {
  final List<User> studentList;

  ClassMenuWidget({required this.studentList});

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
        ],
      ),
    );
  }
}
