import 'package:e_learn_flashcard/model/ModelUser.dart'; // Import ModelUser
import 'package:flutter/material.dart';

import '../../model/ModelGlobalData.dart';
import '../PageMenu.dart';
import 'PageSignIn.dart';
import '../ToolBar.dart';

class PageProfile extends StatelessWidget {
  PageProfile({Key? key}) : super(key: key);

  // Thay thế LoginUser bằng dữ liệu từ GlobalData
  final user = GlobalData.LoginUser;

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
            title: const Text('Danh sách bài học'),
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
            leading: const Icon(Icons.settings),
            title: const Text('Cài đặt'),
            onTap: () {
              // Do something
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Đăng xuất'),
            onTap: () {
              user?.clearUserData();
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
