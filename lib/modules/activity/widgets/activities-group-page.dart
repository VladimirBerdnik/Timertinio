import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:timertinio/modules/activity/data/ActivityModel.dart';
import 'package:timertinio/modules/activity/widgets/activity-card.dart';
import 'package:timertinio/state/state.dart';

class ActivitiesGroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, dynamic>(
        converter: (store) => store,
        builder: (context, store) {
          return Scaffold(
              body: ListView(children: <Widget>[
            ...store.state.activitiesGroup.activities.toList().map((Activity item) => ActivityCard(item))
            // state.order.getItems
          ]));
        });
  }
}
