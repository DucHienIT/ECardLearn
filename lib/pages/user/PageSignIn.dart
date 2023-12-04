import 'package:e_learn_flashcard/Util/ApiPaths.dart';
import 'package:e_learn_flashcard/model/ModelGlobalData.dart';
import 'package:e_learn_flashcard/pages/user/PageChooseRole.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../Util/AlertManager.dart';
import '../../model/ModelUser.dart';
import '../../widget/LoadingScreen.dart';
import '../PageMenu.dart';
import 'PageSignUp.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> signIn() async {
    final String apiUrl = ApiPaths.getLoginPath();
    final String email = emailController.text;
    final String password = passwordController.text;
    setState(() {
      _isLoading = true; // Kết thúc tác vụ, ẩn màn hình loading
    }); // Bắt đầu tác vụ, hiển thị màn hình loading
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json', // Đặt loại nội dung là JSON
      },
      body: jsonEncode({
        'email': email,
        'password': password,
        'rememberMe': true,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false; // Kết thúc tác vụ, ẩn màn hình loading
      });

      final user = User.fromJson(json.decode(response.body)["user"] as Map<String, dynamic>);
      user.saveUserData(user);
      GlobalData.LoginUser = user;
      GlobalData.Token = json.decode(response.body)["token"];
      GlobalData.saveData("token", GlobalData.Token.toString());
      print(GlobalData.Token);
      if (user.roles != null && user.roles.isNotEmpty) {
        // Navigate to PageChooseRole
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => PageMenu(),
        ));
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return MyAlertDialog(
              title: "Bạn chưa chọn vai trò!",
              message:  RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Tiến hành',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              onAction: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => ChooseRolePage(),
                ));
              },
            );
          },
        );
      }
    } else {
      setState(() {
        _isLoading = false; // Kết thúc tác vụ, ẩn màn hình loading
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyAlertDialog(
            title: "Sai email hoặc mật khẩu!",
            message: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: 'Nhập lại!',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            onAction: () {

            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
      isLoading: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Đăng nhập'),
          backgroundColor: Colors.purple, // Đặt màu nền của thanh tiêu đề
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Đăng nhập',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email, color: Colors.purple),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                    prefixIcon: Icon(Icons.lock, color: Colors.purple),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: signIn,
                  child: Text(
                    'Đăng nhập',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple, // Đặt màu nền của nút
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // Chuyển đến trang đăng ký, thay thế đường dẫn bằng đường dẫn đến trang đăng ký của bạn.
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => SignUpPage(),
                    ));
                  },
                  child: Text('Chưa có tài khoản? Đăng ký ngay'),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
