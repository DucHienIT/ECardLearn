import 'package:flutter/material.dart';
import '../../model/ModelTopic.dart';

class TopicDetailPage extends StatelessWidget {
  final Topic topic;

  TopicDetailPage({required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết chủ đề'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tên chủ đề: ${topic.topicName}'),
            Text('Mô tả: ${topic.topicDescription}'),
            Text('Người tạo: ${topic.createdUserId}'),
            Text('Ngày tạo: ${topic.createdDate.toString()}'),
            Text('Người cập nhật: ${topic.updatedUserId}'),
            Text('Ngày cập nhật: ${topic.updatedDate.toString()}'),
          ],
        ),
      ),
    );
  }
}
