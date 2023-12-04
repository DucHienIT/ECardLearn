import 'package:e_learn_flashcard/widget/LoadingScreen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dart_openai/dart_openai.dart';

import '../../model/ModelFlashCard.dart';
import 'PageListQuestGenerate.dart';

class FlashCardGenerate extends StatefulWidget {
  @override
  _FlashCardGenerate createState() => _FlashCardGenerate();
}

class _FlashCardGenerate extends State<FlashCardGenerate> {
  final _nameController = TextEditingController();
  final _numberQuestionController = TextEditingController();
  bool _isLoading = false;
  Future<List<FlashcardItem>> _generateChatResponse(_userInputController) async {
    final String apiKey = "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";
    final String apiUrl = "https://api.openai.com/v1/chat/completions";

    setState(() {
      _isLoading = true;
    });
    final Map<String, dynamic> requestBody = {
      "model": "gpt-3.5-turbo-0613",
      "messages": [
        {"role": "user", "content": _userInputController},
      ],
      "functions":[
        {
          'name': 'createCatObject',
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
            'required': ['additionalList', 'question', 'answer']
          }
        }
      ],
      "function_call": {'name': 'createCatObject'}
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
      String chatResponse = responseData['choices'][0]['message']['function_call']['arguments'];
      Map<String, dynamic> jsonData = jsonDecode(chatResponse);
      List<Map<String, dynamic>> additionalList = List.from(jsonData['additionalList']);

      List<FlashcardItem> flashCards = [];
      for (var entry in additionalList) {
        String question = utf8.decode(entry['question'].codeUnits) as String? ?? '';
        String answer = utf8.decode(entry['answer'].codeUnits) as String? ?? '';
        flashCards.add(FlashcardItem(key: question, meaning:answer, phonetic: ''));
      }
      setState(() {
        _isLoading = false;
      });
      return flashCards;
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to generate chat response');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingScreen(
        isLoading: _isLoading,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Tạo bài học với trợ lý ảo'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Chủ đề',
                      prefixIcon: Icon(Icons.topic)),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _numberQuestionController,
                  decoration: InputDecoration(labelText: 'Số câu hỏi (<20)',
                      prefixIcon: Icon(Icons.countertops)),
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  onPressed: () async {
                    String theme = _nameController.text;
                    int number = int.parse(_numberQuestionController.text);
                    if (number > 20)
                      number = 20;
                    List<FlashcardItem> flashcards = await _generateChatResponse("Tạo ra $number câu hỏi có chủ đề: $theme");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListQuestionGenerate(flashcards: flashcards)),
                    );
                  },
                  child: Text('Thêm'),
                ),
              ],
            ),
          ),
        )
    );
  }
}
