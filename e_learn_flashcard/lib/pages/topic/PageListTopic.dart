import 'dart:convert';
import 'package:flutter/material.dart';
import '../../Util/FetchDataFromAPI.dart';
import '../../model/ModelGlobalData.dart';
import '../../model/ModelTopic.dart';
import 'PageAddTopic.dart';
import 'PageTopicDetail.dart';
import 'package:http/http.dart' as http;
import '../../Util/ApiPaths.dart';
class ListTopicPage extends StatefulWidget {
  @override
  _ListTopicPageState createState() => _ListTopicPageState();
}

class _ListTopicPageState extends State<ListTopicPage> {
  List<Topic> topics = [];

  @override
  void initState() {
    super.initState();
    final String apiUrl = ApiPaths.getTopicListPath(1, 100);
    FetchDataFromAPI(apiUrl, setData);
  }

  void setData(List<dynamic> data)
  {
    setState(() {
      topics = data.map((item) => Topic.fromJson(item)).toList();
    });
    GlobalData.ListTopic = topics;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách chủ đề'),
      ),
      body: ListView.builder(
        itemCount: topics.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(topics[index].topicName),
            subtitle: Text(topics[index].topicDescription),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopicDetailPage(topic: topics[index]),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Xử lý khi nút được nhấn, ví dụ: điều hướng đến trang thêm Topic
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTopicPage(), // Thay thế AddTopicPage bằng tên trang thêm Topic của bạn
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
