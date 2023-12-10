import 'package:e_learn_flashcard/model/ModelAchievement.dart';
import 'package:e_learn_flashcard/model/ModelUser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Util/ApiPaths.dart';
import '../Util/UtilCallApi.dart';
import '../main.dart';
import 'ModelTopic.dart';

class GlobalData{
  static String? Token;
  static User? LoginUser;
  static List<Topic>? ListTopic;
  static int? CountLoginApp;
  static List<Achievement>? ListAchivement;

  static void saveData(String keyLocal, String data) async {
    await storage.write(key: keyLocal, value: data);
  }
  static Future<String?> LoadDataFromLocal(String keyLocal) async
  {
    String? data = await storage.read(key: keyLocal);
    return data;
  }
  static Future<void> updateLoginCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastLoginDate = prefs.getString('lastLoginDate');
    // Get the current date
    DateTime now = DateTime.now();
    String currentDate = '${now.year}-${now.month}-${now.day}';
    int loginCount = prefs.getInt('loginCount') ?? 0;

    if (lastLoginDate != currentDate) {
      loginCount++;
      prefs.setInt('loginCount', loginCount);
      prefs.setString('lastLoginDate', currentDate);
    }
    CountLoginApp = loginCount;
  }
}