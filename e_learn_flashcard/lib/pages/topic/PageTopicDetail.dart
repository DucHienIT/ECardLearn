import 'package:e_learn_flashcard/Util/ApiPaths.dart';
import 'package:e_learn_flashcard/Util/UtilCallApi.dart';
import 'package:e_learn_flashcard/model/ModelCourse.dart';
import 'package:e_learn_flashcard/pages/course/PageCourseDetail.dart';
import 'package:flutter/material.dart';
import '../../model/ModelTopic.dart';

class TopicDetailPage extends StatefulWidget {
  final Topic topic;
  TopicDetailPage({required this.topic});
  @override
  _TopicDetailPageState createState() => _TopicDetailPageState();
}

class _TopicDetailPageState extends State<TopicDetailPage> {

  List<Course> courses = [];

  @override
  void initState() {
    super.initState();
    final String apiUrl = ApiPaths.getCourseListByTopicIdPath(widget.topic.topicId);
    FetchDataFromAPI(apiUrl, setData);
  }

  void setData(List<dynamic> data) {
    setState(() {
      courses = data.map((item) => Course.fromJson(item)).toList();
    });
  }

  void deleteCourse(int courseIndex){
    final String apiUrlDelete = ApiPaths.getCoursePath(courses[courseIndex].courseId);
    DeleteDataFromAPI(apiUrlDelete, (){
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách khóa học'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: courses.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Icon(Icons.book),
                title: Text(courses[index].courseName, style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(courses[index].courseDescription),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailCoursePage(course: courses[index]),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
