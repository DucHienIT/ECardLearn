import '../main.dart';

class LocalDataManager{

  static void saveData(String keyLocal, String data) async {
    await storage.write(key: keyLocal, value: data);
  }
  static Future<String?> LoadDataFromLocal(String keyLocal) async
  {
    String? data = await storage.read(key: keyLocal);
    return data;
  }
}