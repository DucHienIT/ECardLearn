import 'package:e_learn_flashcard/model/ModelUser.dart';

import '../main.dart';
import 'ModelTopic.dart';

class GlobalData{
  static String? Token;
  static User? LoginUser;
  static List<Topic>? ListTopic;

  static void saveData(String keyLocal, String data) async {
    await storage.write(key: keyLocal, value: data);
  }
  static Future<String?> LoadDataFromLocal(String keyLocal) async
  {
    String? data = await storage.read(key: keyLocal);
    return data;
  }
}