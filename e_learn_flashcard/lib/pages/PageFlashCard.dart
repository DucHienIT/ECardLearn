import 'package:flash_card/flash_card.dart';
import 'package:flutter/material.dart';

import '../model/ModelFlashCard.dart';

class PageFlashCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách Flashcard'),
      ),
      body: FlashcardsListView(), // Sử dụng widget FlashcardsListView
    );
  }
}

class FlashcardsListView extends StatelessWidget {
  final List<FlashcardItem> flashcardList = [
    FlashcardItem(
      key: 'House',
      meaning: 'Ngôi nhà',
      phonetic: '/həʊm/',
    ),
    FlashcardItem(
      key: 'School',
      meaning: 'Trường học',
      phonetic: '/skuːl/',
    ),
    // Thêm các flashcard khác ở đây.
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: flashcardList.length,
      itemBuilder: (context, index) {
        return buildFlashcardItem(flashcardList[index]);
      },
    );
  }

  Widget buildFlashcardItem(FlashcardItem flashcard) {
    return FlashCard(
      key: Key(flashcard.key),
      frontWidget: Container(
        height: 100,
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text.rich(TextSpan(
              text: 'Nghĩa:',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              children: [
                TextSpan(
                  text: flashcard.meaning,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            )),
            Text.rich(TextSpan(
              text: 'Phiên âm:',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              children: [
                TextSpan(
                  text: flashcard.phonetic,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            )),
            Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.blue, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(2, 2),
                    spreadRadius: 1,
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.volume_down_sharp,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
      backWidget: Container(
        height: 100,
        width: 100,
        child: Center(
          child: Text(
            flashcard.key,
            style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
      width: 300,
      height: 400,
    );
  }
}
