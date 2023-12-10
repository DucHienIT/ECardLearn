import 'package:flutter/material.dart';
import 'package:achievement_view/achievement_view.dart';

import '../../model/ModelAchievement.dart';
import '../../model/ModelGlobalData.dart';

class AchievementPage extends StatelessWidget {
  final List<Achievement>? achievements = GlobalData.ListAchivement;

  final List<Color> achievementColors = [
    Colors.grey,
    Colors.brown,
    Colors.amberAccent,
    Colors.blueGrey,
  ];

  @override
  Widget build(BuildContext context) {
    int? countLoginApp = GlobalData.CountLoginApp;

    return Scaffold(
      body: Center(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: achievements?.length,
          itemBuilder: (context, index) {
            if (achievements![index].dayRequirement <= countLoginApp!) {
              return Container(
                margin: EdgeInsets.all(8.0),
                width: 350,
                child: Card(
                  color: achievementColors[index % achievementColors.length],
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 16.0),
                        Text(
                          achievements![index].achievementName,
                          style: TextStyle(
                            fontSize: 28.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          achievements![index].achievementDescription,
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 80.0),
                        Icon(
                          Icons.star, // Thay thế bằng icon phù hợp với thành tựu của bạn
                          color: Colors.white, // Màu của icon
                          size: 48.0, // Kích thước của icon
                        ),
                      ],
                    ),
                    contentPadding: EdgeInsets.all(16.0),
                    onTap: () => showAchievement(context, achievements![index]),
                  ),
                ),
              );
            } else {
              // Return an empty container for achievements that don't meet the requirement
              return Container();
            }
          },
        ),
      ),
    );
  }

  void showAchievement(BuildContext context, Achievement achievement) {
    AchievementView(
      title: achievement.achievementName,
      subTitle: achievement.achievementDescription,
      isCircle: false,
      listener: (status) => print('Achievement status: $status'),
    ).show(context);
  }
}
