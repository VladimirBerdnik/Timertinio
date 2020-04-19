import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

List<MaterialColor> mainColors = <MaterialColor>[
  Colors.grey,
  Colors.blueGrey,
  Colors.teal,
  Colors.lime,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.deepOrange,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.cyan,
  Colors.brown,
];

class ActivityDialog extends StatefulWidget {
  final String activityName;
  final Color activityColor;

  const ActivityDialog({Key key, this.activityName, this.activityColor}) : super(key: key);

  @override
  _ActivityDialogState createState() => _ActivityDialogState();
}

class _ActivityDialogState extends State<ActivityDialog> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _textFieldController = TextEditingController(text: widget.activityName);
    Color _tempColor;
    Color _newActivityColor = widget.activityColor != null ? widget.activityColor : Colors.blue[100];

    _openColorPicker() async {
      List<ColorSwatch> myPalette = [];

      mainColors.forEach((MaterialColor color) {
        [50, 200, 400].forEach((int intensity) {
          myPalette.add(ColorSwatch(color[intensity].value, <int, Color>{}));
        });
      });
      myPalette.add(ColorSwatch(_newActivityColor.value, <int, Color>{}));

      return showDialog(
          context: context,
          child: AlertDialog(
            contentPadding: const EdgeInsets.all(6.0),
            title: Text("Pick the Activity color"),
            content: MaterialColorPicker(
              colors: myPalette,
              allowShades: false,
              selectedColor: _newActivityColor,
              onMainColorChange: (color) => _tempColor = color,
              onColorChange: (color) => _tempColor = color,
            ),
            actions: [
              FlatButton(child: Text('CANCEL'), onPressed: Navigator.of(context).pop),
              FlatButton(
                child: Text('SUBMIT'),
                onPressed: () {
                  _newActivityColor = _tempColor;
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
    }

    return AlertDialog(
      title: Text('Activity details'),
      content: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: TextField(
                autofocus: true,
                controller: _textFieldController,
                decoration: InputDecoration(hintText: 'Activity name'),
              ),
            ),
            GestureDetector(
              onTap: _openColorPicker,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 16.0,
                // Todo fix color not set in icon
                child: Icon(Icons.color_lens, color: _newActivityColor),
              ),
            )
          ]),
      actions: <Widget>[
        FlatButton(
          child: new Text('CANCEL'),
          onPressed: Navigator.of(context).pop,
        ),
        FlatButton(
          child: new Text('SUBMIT'),
          onPressed: () {
            if (_textFieldController.text.isEmpty) {
              return;
            }

            Navigator.of(context).pop({'name': _textFieldController.text, 'color': _newActivityColor});
          },
        ),
      ],
    );
  }
}
