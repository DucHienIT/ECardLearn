import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final String title;
  final RichText message;
  final VoidCallback? onAction;

  MyAlertDialog({required this.title, required this.message, this.onAction,});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(title, style: TextStyle(color: Colors.blueAccent)),
      content: message,
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Đóng', style: TextStyle(color: Colors.blueAccent)),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (onAction != null) {
              onAction!();
            }
          },
          child: Text('Thực hiện', style: TextStyle(color: Colors.blueAccent)),
        ),
      ],
    );
  }
}
