import 'package:e_learn_flashcard/Util/LocalDataManager.dart';
import 'package:e_learn_flashcard/pages/PageMenu.dart';
import 'package:e_learn_flashcard/pages/user/PageSignIn.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'model/ModelGlobalData.dart';
import 'model/ModelUser.dart';

final storage = new FlutterSecureStorage();

Future<void> readUserData() async {
  String? userData = await LocalDataManager.LoadDataFromLocal('userData');

  if (userData != null) {
    Map<String, dynamic> userMap = jsonDecode(userData);
    GlobalData.LoginUser = User.fromJson(userMap);
    GlobalData.Token = await LocalDataManager.LoadDataFromLocal('token');
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcards App',
      home: FutureBuilder(
        future: readUserData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return GlobalData.LoginUser == null ? LoginPage() : PageMenu();
            }
          }
        },
      ),
    );
  }
}
