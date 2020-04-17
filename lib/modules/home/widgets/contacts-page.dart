import 'package:flutter/material.dart';

class ContactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        Card(
          child: ListTile(
            leading: Icon(Icons.email),
            title: Text('пряники@example.com'),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.phone),
            title: Text('+7 (983) 111-22-33'),
            subtitle: Text('Олег'),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.phone),
            title: Text('+7 (983) 789-54-32'),
            subtitle: Text('Виктор'),
          ),
        ),
        Card(child: ListTile(leading: Icon(Icons.assignment_turned_in), title: Text("""
Регистрационный номер декларации о соответствии:
ЕАЭС N RU Д-RU.АЖ37.В.12345/67
        """))),
      ],
    );
  }
}
