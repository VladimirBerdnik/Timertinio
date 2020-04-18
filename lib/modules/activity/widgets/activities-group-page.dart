import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:timertinio/modules/activity/data/ActivitiesGroupModel.dart';
import 'package:timertinio/modules/activity/data/ActivityModel.dart';
import 'package:timertinio/modules/activity/widgets/activity-card.dart';
import 'package:timertinio/state/actions.dart';
import 'package:timertinio/state/state.dart';

class ActivitiesGroupPage extends StatefulWidget {
  @override
  _ActivitiesGroupPageState createState() => _ActivitiesGroupPageState();
}

class _ActivitiesGroupPageState extends State<ActivitiesGroupPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _textFieldController = TextEditingController();
    Color _tempColor;
    Color _newActivityColor = Colors.blue[100];
    String _newActivityName;

    _openColorPicker() async {
      return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(6.0),
            title: Text("Pick the Activity color"),
            content: MaterialColorPicker(
              colors: materialColors,
              selectedColor: _newActivityColor,
              onMainColorChange: (color) => setState(() => _tempColor = color),
              onColorChange: (color) => setState(() => _tempColor = color),
            ),
            actions: [
              FlatButton(
                child: Text('CANCEL'),
                onPressed: Navigator.of(context).pop,
              ),
              FlatButton(
                child: Text('SUBMIT'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _newActivityColor = _tempColor;
                  });
                },
              ),
            ],
          );
        },
      );
    }

    _displayDialog(BuildContext context) async {
      return showDialog(
          context: context,
          builder: (context) {
            _textFieldController.text = '';

            return AlertDialog(
              title: Text('New Activity details'),
              content: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _textFieldController,
                        decoration: InputDecoration(hintText: 'Activity name'),
                      ),
                    ),
                    GestureDetector(
                      onTap: _openColorPicker,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 16.0,
                        child: Icon(Icons.color_lens, color: Colors.black),
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
                    Navigator.of(context).pop(true);
                    setState(() {
                      _newActivityName = _textFieldController.text;
                    });
                  },
                ),
              ],
            );
          });
    }

    return StoreConnector<AppState, dynamic>(
        converter: (store) => store,
        builder: (context, store) {
          return Scaffold(
              body: ListView(children: <Widget>[
                ...store.state.activitiesGroup.activities.toList().map((Activity item) => ActivityCard(item))
              ]),
              floatingActionButton: StoreConnector<AppState, ActivitiesGroup>(
                  converter: (store) => store.state.activitiesGroup,
                  builder: (context, ActivitiesGroup activitiesGroup) {
                    return FloatingActionButton(
                        onPressed: () async {
                          if (!await _displayDialog(context)) {
                            return;
                          }

                          if (_newActivityName != null) {
                            store.dispatch(AddActivityAction(_newActivityName, _newActivityColor));
                          }
                        },
                        child: Icon(Icons.alarm_add));
                  }));
        });
  }
}
