import 'package:flutter/material.dart';
import 'package:e_learn_flashcard/Util/UtilCommon.dart';
import 'package:e_learn_flashcard/model/ModelGlobalData.dart';
import 'package:e_learn_flashcard/pages/question/PageGenerateQuestion.dart';
import 'package:e_learn_flashcard/pages/topic/PageListTopic.dart';
import 'package:e_learn_flashcard/Util/ApiPaths.dart';
import 'package:e_learn_flashcard/Util/UtilCallApi.dart';
import 'package:e_learn_flashcard/widget/MainMenuWidget.dart';
import 'package:e_learn_flashcard/widget/SearchCourseBarWidget.dart';
import 'Achievement/PageAchievement.dart';
import 'Admin/PageUserManagement.dart';
import '../model/ModelAchievement.dart';

class PageMenu extends StatefulWidget {
  @override
  _PageMenuState createState() => _PageMenuState();
}

class _PageMenuState extends State<PageMenu> {
  final TextEditingController keywordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadListAchievement();
  }

  Future<void> loadListAchievement() async {
    final String apiUrl = ApiPaths.getListAchivementPath(1, 100);
    FetchDataFromAPI(apiUrl, setListTestData);
  }

  void setListTestData(List<dynamic> data) {
    GlobalData.ListAchivement = data.map((item) => Achievement.fromJson(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trang chủ'),
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.account_balance_wallet),
              onPressed: () => {
                if(GlobalData.ListAchivement != null)
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AchievementPage())
                )
              },
            ),
          ),
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.search),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: MainMenuWidget(),
      endDrawer: SearchCourseBarApp(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20), // Add spacing
            MainMenuCard(
              title: 'Tạo bài học với trợ lý ảo', // Menu category 2
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FlashCardGenerate()),
                );
              },
            ),
            SizedBox(height: 20), // Add spacing
            MainMenuCard(
              title: 'Tìm bài học theo chủ đề', // Menu category 2
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListTopicPage()),
                );
              },
            ),
            SizedBox(height: 20),
            MainMenuCard(
              permis: UtilCommon.IsAdmin(),
              title: 'Quản lý tài khoản người dùng', // Menu category 2
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserManagementPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MainMenuCard extends StatelessWidget {
  final bool? permis;
  final String title;
  final VoidCallback onTap;

  MainMenuCard({this.permis, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return (permis ?? true) ? Container(
      margin: EdgeInsets.symmetric(horizontal: 20), // Thêm lề ngang
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue), // Thêm khung
        borderRadius: BorderRadius.circular(10), // Bo góc khung
      ),
      child: Card(
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: onTap,
        ),
      ),
    ) : Container();
  }
}
