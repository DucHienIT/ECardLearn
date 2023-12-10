import 'package:e_learn_flashcard/Util/ApiPaths.dart';
import 'package:e_learn_flashcard/Util/UtilCallApi.dart';
import 'package:e_learn_flashcard/Util/UtilCommon.dart';
import 'package:e_learn_flashcard/pages/class/PageListClass.dart';
import 'package:e_learn_flashcard/pages/course/PageListCourse.dart';
import 'package:e_learn_flashcard/pages/user/PageChangePassword.dart';
import 'package:flutter/material.dart';

import '../../model/ModelGlobalData.dart';
import 'PageSignIn.dart';

class PageProfile extends StatelessWidget {
  PageProfile({Key? key}) : super(key: key);

  // Thay thế LoginUser bằng dữ liệu từ GlobalData
  final user = GlobalData.LoginUser;

  void Logout()
  {
    final String apiLogout = ApiPaths.getLogoutPath();
    FetchDataFromAPI(apiLogout, (p0) => null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cá nhân'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blue,
            child: Text(UtilCommon.getInitials(GlobalData.LoginUser!.name),
              style: TextStyle(
                fontSize: 24.0,  // Đặt kích thước font của bạn ở đây
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            user!.name, // Sử dụng name từ dữ liệu User
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            user!.email, // Sử dụng email từ dữ liệu User
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.class_sharp),
            title: const Text('Danh sách lớp học'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClassListPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Danh sách bài học'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListCoursePage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.password),
            title: const Text('Đổi mật khẩu'),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => ChangePasswordPage(),
              ));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Đăng xuất'),
            onTap: () {
              user?.clearUserData();
              Logout();
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => LoginPage(),
              ));
            },
          ),
          const Divider(),
          Expanded(
            child: AboutListTile(),
          ),
        ],
      ),
    );
  }
}
