import 'package:flutter/material.dart';
import '../pages/PageAddFlashCard.dart';
import '../pages/PageFlashCard.dart';
import '../pages/user/PageProfile.dart';

class MainMenuWidget extends StatelessWidget {
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
            title: Text('Danh sách Flashcard'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PageFlashCard()),
              );
            },
          ),
          ListTile(
            title: Text('Thêm Flashcard'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PageAddFlashCard()),
              );
            },
          ),
          ListTile(
            title: Text('Hồ sơ'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PageProfile()),
              );
            },
          ),
        ],
      ),
    );
  }
}
