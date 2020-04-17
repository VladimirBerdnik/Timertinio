import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:timertinio/modules/activity/data/ActivityModel.dart';
import 'package:timertinio/state/actions.dart';
import 'package:timertinio/state/state.dart';

class ActivityCard extends StatefulWidget {
  ActivityCard(this.activity);

  final Activity activity;

  @override
  State<StatefulWidget> createState() => ActivityCardState();
}

class ActivityCardState extends State<ActivityCard> {
  Activity _activity;
  Timer timer;

  @override
  void initState() {
    _activity = widget.activity;
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      // State is set to render fresh data in timer
      this.setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: StoreConnector<AppState, Store>(
            converter: (Store store) => store,
            builder: (context, Store store) {
              return Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(_activity.isStarted() ? Icons.pause : Icons.play_arrow),
                    title: Text(_activity.name),
                    subtitle: Text(_activity.duration.toString().split('.').first),
                    trailing: IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          store.dispatch(RemoveActivityAction(_activity));
                        }),
                    onTap: () {
                      if (_activity.isStarted()) {
                        store.dispatch(StopActivityAction(_activity));
                      } else {
                        store.dispatch(StartActivityAction(_activity));
                      }
                    },
                    onLongPress: () {
                      store.dispatch(ResetActivityAction(_activity));
                    },
                  )
                ],
              );
            }));
  }
}
