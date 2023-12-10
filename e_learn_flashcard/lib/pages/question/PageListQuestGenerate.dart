import 'package:flutter/material.dart';
import '../../model/ModelFlashCard.dart';
import 'package:flash_card/flash_card.dart';

class ListQuestionGenerate extends StatefulWidget {
  final List<FlashcardItem> flashcards;

  ListQuestionGenerate({required this.flashcards});

  @override
  _ListQuestionGenerate createState() => _ListQuestionGenerate();
}

class _ListQuestionGenerate extends State<ListQuestionGenerate> {
  int currentQuestionIndex = 0;
  @override
  void initState() {
    super.initState();
  }


  void nextQuestion() {
    setState(() {
      if (currentQuestionIndex < widget.flashcards.length - 1) {
        currentQuestionIndex++;
      }
    });
  }

  void previousQuestion() {
    setState(() {
      if (currentQuestionIndex > 0) {
        currentQuestionIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Bài học trợ lí ảo'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                'Câu hỏi ${widget.flashcards.length == 0 ? 0 : currentQuestionIndex + 1}/${widget.flashcards.length}:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              if (widget.flashcards.isNotEmpty)
                buildFlashcardItem(widget.flashcards[currentQuestionIndex]),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: previousQuestion,
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: nextQuestion,
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
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
              text: 'Đáp án:',
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
            Text.rich(TextSpan(
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
      width: 350,
      height: 500,
    );
  }
}
