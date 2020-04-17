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

  @override
  void initState() {
    _activity = widget.activity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: StoreConnector<AppState, Store>(
            converter: (Store store) => store,
            builder: (context, Store store) {
              return FlatButton(
                child: Text(_activity.name + " " + _activity.duration.toString()),
                color: Colors.black12,
                onPressed: () {
                  if (_activity.isStarted()) {
                    store.dispatch(StopActivityAction(_activity));
                  } else {
                    store.dispatch(StartActivityAction(_activity));
                  }
                },
                onLongPress: () {
                  store.dispatch(ResetActivityAction(_activity));
                },
              );
            }));
  }
}
