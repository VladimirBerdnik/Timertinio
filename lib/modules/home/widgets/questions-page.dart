import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timertinio/modules/home/data/QuestionModel.dart';
import 'package:timertinio/modules/home/data/QuestionsRepository.dart';

class QuestionsPage extends StatefulWidget {
  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  List<Question> questions = QuestionsRepository.fetchAll();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ...questions.toList().map((question) => Card(
              child: ExpansionTile(
                title: new Text(question.question),
                leading: Icon(Icons.help_outline),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Text(question.answer),
                      alignment: AlignmentDirectional.topStart,
                    ),
                  ),
                ],
              ),
            ))
      ],
    );
  }
}
