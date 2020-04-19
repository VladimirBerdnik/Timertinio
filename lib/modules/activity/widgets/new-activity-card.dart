import 'package:flutter/material.dart';

class NewActivityCard extends StatefulWidget {
  final dynamic _onTap;

  NewActivityCard(this._onTap);

  @override
  _NewActivityCardState createState() => _NewActivityCardState();
}

class _NewActivityCardState extends State<NewActivityCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
          children: <Widget>[
            ListTile(
              trailing: Icon(Icons.add),
              title: Text('Add new...'),
              subtitle: Text('--:--:--', textAlign: TextAlign.right,),
              onTap: widget._onTap,
            )
          ],
        ));
  }
}
