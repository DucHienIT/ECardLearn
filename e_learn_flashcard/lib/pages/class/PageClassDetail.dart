import 'package:flutter/material.dart';

import '../../model/ModelClass.dart';
import '../../widget/ClassMenuWidget.dart';
import '../../widget/MainMenuWidget.dart';

class ClassDetailPage extends StatelessWidget {
  final MyClass myClass;

  ClassDetailPage({required this.myClass});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết lớp học'),
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: ClassMenuWidget(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Tên lớp học: ${myClass.className}'),
            Text('Mô tả: ${myClass.classDescription}'),
            Text('Giáo viên: ${myClass.teacherId}'),
            Text('Người tạo: ${myClass.createdUserId}'),
            Text('Ngày tạo: ${myClass.createdDate.toLocal()}'),
            Text('Người cập nhật: ${myClass.updatedUserId}'),
            Text('Ngày cập nhật: ${myClass.updatedDate.toLocal()}'),
          ],
        ),
      ),
    );
  }
}
