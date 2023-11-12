import 'package:flutter/material.dart';

import '../../model/ModelClass.dart';
import 'PageClassDetail.dart';

class ClassListPage extends StatelessWidget {
  final List<MyClass> classes;

  ClassListPage({required this.classes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách lớp học'),
      ),
      body: ListView.builder(
        itemCount: classes.length,
        itemBuilder: (context, index) {
          final myClass = classes[index];
          return ListTile(
            title: Text(myClass.className),
            subtitle: Text(myClass.classDescription),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ClassDetailPage(myClass: myClass),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
