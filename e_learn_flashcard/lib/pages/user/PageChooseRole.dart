import 'dart:convert';

import 'package:e_learn_flashcard/model/ModelGlobalData.dart';
import 'package:e_learn_flashcard/pages/PageMenu.dart';
import 'package:e_learn_flashcard/pages/user/PageSignIn.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../Util/AlertManager.dart';

class ChooseRolePage extends StatefulWidget {
  @override
  _ChooseRolePageState createState() => _ChooseRolePageState();
}

class _ChooseRolePageState extends State<ChooseRolePage> {
  List<String> roles = ["Student", "Teacher"];
  String selectedRole = "";

  Future<void> sendRoleRequest(String selectedRole) async {

    final String apiUrl = 'http://3.27.242.207/api/Authentication/RequestRole';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'token': GlobalData.Token.toString()
      },
      body: jsonEncode({
        'userRole': selectedRole,
      }),
    );
    if (response.statusCode == 200) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => PageMenu(),
      ));
    }
    else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyAlertDialog(
            message: "Có lỗi xảy ra, vui lòng đăng nhập lại!",
            onAction: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => LoginPage(),
              ));
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chọn Vai Trò'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              children: roles.map((role) {
                return CheckboxListTile(
                  title: Text(role),
                  value: selectedRole == role,
                  onChanged: (bool? value) {
                    setState(() {
                      selectedRole = value == true ? role : "";
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.all(16.0),
                  checkColor: Colors.white, // Màu của dấu tích
                  activeColor: Colors.blue, // Màu nền khi chọn
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                if (selectedRole.isEmpty){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return MyAlertDialog(
                        message: "Vui lòng chọn vai trò!",
                        onAction: () {

                        },
                      );
                    },
                  );
                }
                sendRoleRequest(selectedRole);
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
