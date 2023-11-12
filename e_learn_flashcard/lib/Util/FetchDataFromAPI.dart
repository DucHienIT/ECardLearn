import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;

import '../model/ModelGlobalData.dart';

Future<void> FetchDataFromAPI(String apiUrl, Function(List<dynamic>) onAction) async {
  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'token': GlobalData.Token.toString(),
    },
  );

  if (response.statusCode == 200) {
    onAction(json.decode(response.body));
  } else {
    print(response.body);
  }
}