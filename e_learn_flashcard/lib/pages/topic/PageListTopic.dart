import 'dart:convert';
import 'package:flutter/material.dart';
import '../../model/ModelGlobalData.dart';
import '../../model/ModelTopic.dart';
import 'PageAddTopic.dart';
import 'PageTopicDetail.dart';
import 'package:http/http.dart' as http;

class ListTopicPage extends StatefulWidget {
  @override
  _ListTopicPageState createState() => _ListTopicPageState();
}

class _ListTopicPageState extends State<ListTopicPage> {
  List<Topic> topics = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
  }

  Future<void> fetchDataFromAPI() async {
    final String apiUrl = 'http://3.27.242.207/api/Topic';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Nếu yêu cầu thành công, giải mã dữ liệu JSON và cập nhật danh sách chủ đề
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        topics = data.map((item) => Topic.fromJson(item)).toList();
      });
    } else {
      print("Loi");
    }
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
