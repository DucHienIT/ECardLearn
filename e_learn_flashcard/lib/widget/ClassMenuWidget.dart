import 'package:flutter/material.dart';

class ClassMenuWidget extends StatelessWidget {
  // Danh sách học sinh (đây là dữ liệu giả định, bạn cần thay thế bằng dữ liệu thực tế từ API hoặc nơi khác)
  final List<String> studentList = [
    'Học sinh 1',
    'Học sinh 2',
    'Học sinh 3',
    // Thêm học sinh khác nếu cần
  ];

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
          ListTile(
            title: Text('Học sinh trong lớp'),
            onTap: () {
              // TODO: Hiển thị danh sách học sinh trong lớp
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Danh sách Học sinh trong lớp'),
                    content: Column(
                      children: studentList.map((student) {
                        return ListTile(
                          title: Text(student),
                          // Thêm xử lý khi nhấn vào học sinh
                          onTap: () {
                            // TODO: Xử lý khi chọn học sinh
                            Navigator.pop(context);
                          },
                        );
                      }).toList(),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
