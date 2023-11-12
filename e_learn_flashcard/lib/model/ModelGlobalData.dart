

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:e_learn_flashcard/model/ModelUser.dart';

import '../main.dart';

class GlobalData{
  static String? Token;
  static User? LoginUser;

  static void saveData(String keyLocal, String data) async {
    await storage.write(key: keyLocal, value: data);
  }
  static Future<String?> LoadDataFromLocal(String keyLocal) async
  {
    String? data = await storage.read(key: keyLocal);
    return data;
  }
}