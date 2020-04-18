import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:timertinio/modules/activity/data/ActivitiesGroupModel.dart';
import 'package:timertinio/modules/activity/data/ActivityModel.dart';
import 'package:timertinio/modules/activity/widgets/activity-card.dart';
import 'package:timertinio/modules/activity/widgets/activity-dialog.dart';
import 'package:timertinio/state/actions.dart';
import 'package:timertinio/state/state.dart';

class ActivitiesGroupPage extends StatefulWidget {
  @override
  _ActivitiesGroupPageState createState() => _ActivitiesGroupPageState();
}

class _ActivitiesGroupPageState extends State<ActivitiesGroupPage> {
  @override
  Widget build(BuildContext context) {
    _openActivityDialog(BuildContext context, [String activityName, Color activityColor]) async {
      return showDialog(
          context: context,
          builder: (context) {
            return ActivityDialog(activityName: activityName, activityColor: activityColor);
          });
    }

    Widget slideRightBackground() {
      return Container(
        color: Colors.blue,
        child: Align(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 20),
              Icon(Icons.edit, color: Colors.white),
              Text(
                " Edit",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          alignment: Alignment.centerLeft,
        ),
      );
    }

    Widget slideLeftBackground() {
      return Container(
        color: Colors.red,
        child: Align(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(Icons.delete, color: Colors.white),
              Text(
                " Delete",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                textAlign: TextAlign.right,
              ),
              SizedBox(width: 20),
            ],
          ),
          alignment: Alignment.centerRight,
        ),
      );
    }

    return StoreConnector<AppState, dynamic>(
        converter: (store) => store,
        builder: (context, store) {
          return Scaffold(
              body: ListView(children: <Widget>[
                ...store.state.activitiesGroup.activities.toList().map((Activity item) => Dismissible(
                      secondaryBackground: slideLeftBackground(),
                      background: slideRightBackground(),
                      key: Key(item.name),
                      child: ActivityCard(item),
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.endToStart) {
                          final bool res = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text("Are you sure you want to delete ${item.name}?"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Cancel", style: TextStyle(color: Colors.black)),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    FlatButton(
                                      child: Text("Delete", style: TextStyle(color: Colors.red)),
                                      onPressed: () {
                                        store.dispatch(RemoveActivityAction(item));
                                        // Trigger re-rendering
                                        setState(() {});
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                          return res;
                        } else {
                          dynamic result = await _openActivityDialog(context, item.name, item.color);
                          if (result != null) {
                            store.dispatch(EditActivityAction(item, result['name'], 0, result['color']));
                          }

                          return false;
                        }
                      },
                    )),
              ]),
              floatingActionButton: StoreConnector<AppState, ActivitiesGroup>(
                  converter: (store) => store.state.activitiesGroup,
                  builder: (context, ActivitiesGroup activitiesGroup) {
                    return FloatingActionButton(
                        onPressed: () async {
                          dynamic result = await _openActivityDialog(context);
                          if (result != null) {
                            store.dispatch(AddActivityAction(result['name'], 0, result['color']));
                          }
                        },
                        child: Icon(Icons.alarm_add));
                  }));
        });
  }
}
