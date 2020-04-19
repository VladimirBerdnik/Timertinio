import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:timertinio/modules/activity/data/ActivityModel.dart';
import 'package:timertinio/state/actions.dart';
import 'package:timertinio/state/state.dart';

class ActivityCard extends StatefulWidget {
  final Activity _activity;

  ActivityCard(this._activity);

  @override
  State<StatefulWidget> createState() => ActivityCardState();
}

class ActivityCardState extends State<ActivityCard> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store>(
        converter: (Store store) => store,
        builder: (context, Store store) {
          return Card(
              color: widget._activity.color,
              child: Column(
                children: <Widget>[
                  ListTile(
                    trailing: Icon(widget._activity.isStarted() ? Icons.pause : Icons.play_arrow),
                    title: Text(widget._activity.name),
                    subtitle: Text(widget._activity.duration.toString().split('.').first, textAlign: TextAlign.right),
                    onTap: () {
                      if (widget._activity.isStarted()) {
                        store.dispatch(StopActivityAction(widget._activity));
                      } else {
                        store.dispatch(StartActivityAction(widget._activity));
                      }
                    },
                  )
                ],
              ));
        });
  }
}
