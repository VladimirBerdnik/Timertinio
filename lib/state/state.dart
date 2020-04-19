import 'dart:convert';

import 'package:timertinio/modules/activity/data/ActivitiesGroupModel.dart';

class AppState {
  final ActivitiesGroup activitiesGroup;

  AppState(this.activitiesGroup);

  static AppState emptyState() {
    ActivitiesGroup activitiesGroup = ActivitiesGroup();

    return AppState(activitiesGroup);
  }

  static AppState fromJson(dynamic json) => AppState(ActivitiesGroup.fromJson(jsonDecode(json['activitiesGroup'])));

  dynamic toJson() => {'activitiesGroup': jsonEncode(activitiesGroup.toJson())};
}
