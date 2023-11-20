import 'package:e_learn_flashcard/Util/ApiPaths.dart';
import 'package:e_learn_flashcard/Util/UtilCallApi.dart';
import 'package:e_learn_flashcard/model/ModelGlobalData.dart';
import 'package:e_learn_flashcard/pages/user/PageProfile.dart';
import 'package:flutter/material.dart';

import '../../Util/AlertManager.dart';
import '../../model/ModelChangePassword.dart'; // Thay đổi đường dẫn phù hợp

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  void changePassword() {
    // Tạo một đối tượng ChangePasswordModel từ dữ liệu người dùng nhập vào
    ChangePasswordModel changePasswordModel = ChangePasswordModel(
      email: GlobalData.LoginUser!.email,
      password: passwordController.text,
      newPassword: newPasswordController.text,
      confirmationNewPassword: confirmNewPasswordController.text,
    );
    String apiUrl = ApiPaths.getCourseInClassPath();
    PostDataFromAPI(apiUrl, changePasswordModel.toJson(), onCallBack);
  }
  void onCallBack(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyAlertDialog(
          title: "Thông báo",
          message:  RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                  text: 'Đổi mật khẩu thành công!',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          onAction: () {
            Navigator.pushReplacement (
              context,
              MaterialPageRoute(
                builder: (context) => PageProfile(),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đổi Mật Khẩu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Mật Khẩu Hiện Tại'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            TextField(
              controller: newPasswordController,
              decoration: InputDecoration(labelText: 'Mật Khẩu Mới'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            TextField(
              controller: confirmNewPasswordController,
              decoration: InputDecoration(labelText: 'Xác Nhận Mật Khẩu Mới'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                changePassword();
              },
              child: Text('Đổi Mật Khẩu'),
            ),
          ],
        ),
      ),
    );
  }
}
