import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:timertinio/modules/activity/data/ActivitiesGroupModel.dart';
import 'package:timertinio/modules/activity/data/ActivityModel.dart';
import 'package:timertinio/modules/activity/widgets/activity-card.dart';
import 'package:timertinio/state/actions.dart';
import 'package:timertinio/state/state.dart';

class ActivitiesGroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _textFieldController = TextEditingController();

    _displayDialog(BuildContext context) async {
      _textFieldController.text = '';

      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Enter new Activity details'),
              content: TextField(
                controller: _textFieldController,
                decoration: InputDecoration(hintText: 'Activity name'),
              ),
              actions: <Widget>[
                FlatButton(
                  child: new Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(_textFieldController.text);
                  },
                ),
                FlatButton(
                  child: new Text('CANCEL'),
                  onPressed: () {
                    Navigator.of(context).pop(null);
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
                          String result = await _displayDialog(context);

                          if (result != null) {
                            store.dispatch(AddActivityAction(result));
                          }
                        },
                        child: Icon(Icons.alarm_add));
                  }));
        });
  }
}
