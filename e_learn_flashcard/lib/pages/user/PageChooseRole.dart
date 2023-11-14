import 'dart:convert';
import 'dart:async';

import 'package:e_learn_flashcard/Util/ApiPaths.dart';
import 'package:e_learn_flashcard/Util/UtilCallApi.dart';
import 'package:e_learn_flashcard/pages/PageMenu.dart';
import 'package:flutter/material.dart';


class ChooseRolePage extends StatefulWidget {
  @override
  _ChooseRolePageState createState() => _ChooseRolePageState();
}

class _ChooseRolePageState extends State<ChooseRolePage> {
  List<String> roles = ["Student", "Teacher"];
  String selectedRole = "";
  final String apiUrl = ApiPaths.getChooseRolePath();

  void sendRole()
  {
    setState(() {
      Map<String, dynamic> data = {
        "userRole": selectedRole
      };
      PostDataFromAPI(apiUrl, data, (){
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => PageMenu(),
        ));
      });
    });
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
              onPressed: sendRole,
              child: Text('Submit'),
            ),

          ),
        ],
      ),
    );
  }
}
