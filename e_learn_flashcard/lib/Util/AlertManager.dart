import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final String message;
  final VoidCallback? onAction; // Callback function

  MyAlertDialog({required this.message, this.onAction}); // Constructor

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Thông báo'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Đóng'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (onAction != null) {
              onAction!(); // Gọi callback function nếu nó được cung cấp
            }
          },
          child: Text('Thực hiện'),
        ),
      ],
    );
  }
}
