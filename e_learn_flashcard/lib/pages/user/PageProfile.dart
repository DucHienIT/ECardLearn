import 'package:e_learn_flashcard/Util/ApiPaths.dart';
import 'package:e_learn_flashcard/Util/UtilCallApi.dart';
import 'package:e_learn_flashcard/model/ModelUser.dart'; // Import ModelUser
import 'package:e_learn_flashcard/pages/user/PageChangePassword.dart';
import 'package:flutter/material.dart';

import '../../model/ModelGlobalData.dart';
import '../PageMenu.dart';
import 'PageSignIn.dart';
import '../../widget/ToolBar.dart';

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
            radius: 100,
            backgroundImage: NetworkImage(user!.avatarUri), // Sử dụng avatarUri từ dữ liệu User
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
            leading: const Icon(Icons.book),
            title: const Text('Danh sách lớp học'),
            onTap: () {
              // Do something
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Bài học yêu thích'),
            onTap: () {
              // Do something
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
