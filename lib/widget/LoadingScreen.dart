import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  LoadingScreen({required this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Nội dung của màn hình
        child,

        // Hiển thị loading khi isLoading là true
        isLoading
            ? Container(
          color: Colors.black.withOpacity(0.5),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
            : Container(),
      ],
    );
  }
}
