import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../model/ModelFlashCard.dart';

class PageAddFlashCard extends StatefulWidget {
  @override
  _PageAddFlashCardState createState() => _PageAddFlashCardState();
}

class _PageAddFlashCardState extends State<PageAddFlashCard> {
  final _formKey = GlobalKey<FormBuilderState>();
  FlashcardItem? _flashcard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm Flashcard'),
        backgroundColor: Colors.teal, // Thay đổi màu nền của app bar
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: <Widget>[
              FormBuilderTextField(
                name: 'key',
                decoration: InputDecoration(
                  labelText: 'Key',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.vpn_key),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              SizedBox(height: 20),
              FormBuilderTextField(
                name: 'meaning',
                decoration: InputDecoration(
                  labelText: 'Meaning',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.translate),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              SizedBox(height: 20),
              FormBuilderTextField(
                name: 'phonetic',
                decoration: InputDecoration(
                  labelText: 'Phonetic',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.record_voice_over),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.saveAndValidate()) {
                    var formInputs = _formKey.currentState!.value;
                    _flashcard = FlashcardItem(
                      key: formInputs['key'],
                      meaning: formInputs['meaning'],
                      phonetic: formInputs['phonetic'],
                    );
                    // TODO: Handle saving the flashcard
                  }
                },
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal, // Thay đổi màu nền của nút
                  onPrimary: Colors.white, // Thay đổi màu văn bản của nút
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
