import 'dart:convert';
import 'package:flutter/material.dart';
import '../../Util/UtilCallApi.dart';
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
      body: GridView.builder(
        itemCount: topics.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
        ),
        itemBuilder: (context, index) {
          return Card(
            color: Colors.lightBlue[50], // This will change the color of your items
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 1), // This will add a border to your items
              borderRadius: BorderRadius.circular(10), // This will round the corners of your items
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TopicDetailPage(topic: topics[index]),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    topics[index].topicName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // This will change the color of your text
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTopicPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
