import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/ModelGlobalData.dart';

Future<void> FetchDataFromAPI(String apiUrl, Function(List<dynamic>) onAction) async {
  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${GlobalData.Token}',
    },
  );

  if (response.statusCode == 200) {
    onAction(json.decode(response.body));
  } else {
    print(response.statusCode);
  }
}
Future<void> FetchObjectFromAPI(String apiUrl, Function(Object) onAction) async {
  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${GlobalData.Token}',
    },
  );

  if (response.statusCode == 200) {
    onAction(json.decode(response.body));
  } else {
    print(response.body);
  }
}

Future<void>  PostDataFromAPI(String apiUrl, Map<String, dynamic> dataBody, VoidCallback onAction) async {
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${GlobalData.Token}',
    },
    body: jsonEncode(dataBody),
  );

  if (response.statusCode == 200) {
    print(response.body);
    onAction();
  } else {
    print(response.statusCode);
    print(response.body);
  }
}
Future<void> AddDataFromAPI(String apiUrl, Map<String, dynamic> dataBody, Function(Map<String, dynamic>) onAction) async {
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${GlobalData.Token}',
    },
    body: jsonEncode(dataBody),
  );

  if (response.statusCode == 201) {
    print(response.body);
    if (onAction != null) {
      onAction(json.decode(response.body));
    }
  } else {
    print(response.body);
  }
}

Future<void>  UpdateDataFromAPI(String apiUrl, Map<String, dynamic> dataBody) async {
  final response = await http.put(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${GlobalData.Token}',
    },
    body: jsonEncode(dataBody),
  );
  print(jsonEncode(dataBody));
  if (response.statusCode == 200) {
    print('Succes');
    print(response.body);
  } else {
    print(response.body);
  }
}


Future<void> DeleteDataFromAPI(String apiUrl, VoidCallback onAction) async {
  final response = await http.delete(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${GlobalData.Token}',
    },
  );

  if (response.statusCode == 204) {
    if (onAction != null) {
      onAction();
    }
  } else {
    print(response.body);
  }
}
Future<String> GenerateChatResponse(_userInputController) async {
  final String apiKey = "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";
  final String apiUrl = "https://api.openai.com/v1/chat/completions";

  final Map<String, dynamic> requestBody = {
    "model": "gpt-3.5-turbo-0613",
    "messages": [
      {"role": "user", "content": _userInputController},
    ],
    "functions":[
      {
        'name': 'createObject',
        'parameters': {
          'type': 'object',
          'properties': {
            'additionalList': {
              'type': 'array',
              'items': {
                'type': 'object',
                'properties': {
                  'question': {
                    'type': 'string'
                  },
                  'answer': {
                    'type': 'string',
                  }
                },
              }
            }
          },
          'required': ['additionalList','question', 'answer']
        }
      }
    ],
    "function_call": {'name': 'createObject'}
  };

  final http.Response response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey",
    },
    body: jsonEncode(requestBody),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final String chatResponse = responseData['choices'][0]['message']['function_call']['arguments'];
    return chatResponse;
  } else {
    throw Exception('Failed to generate chat response');
  }
}

