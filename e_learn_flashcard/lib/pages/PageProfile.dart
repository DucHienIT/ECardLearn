import 'package:flutter/material.dart';

import 'ToolBar.dart';

class PageProfile extends StatelessWidget {
  const PageProfile({Key? key}) : super(key: key);

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
          const CircleAvatar(
            radius: 100,
            backgroundImage: NetworkImage('https://i.pinimg.com/564x/03/b1/e1/03b1e17ebc96c1ce885c7e89b3a940ba.jpg'),

          ),
          const SizedBox(height: 20),
          const Text(
            'John Doe',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'johndoe@example.com',
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
              // Do something
            },
          ),
          const Divider(),

          const Expanded(
            child: AboutListTile(),

          ),
          MenuBarCustom(

          ),
        ],


      ),
    );
  }
}