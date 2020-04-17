import 'package:timertinio/modules/activity/data/ActivityModel.dart';

class StartActivityAction {
  final Activity activity;

  StartActivityAction(this.activity);
}

class StopActivityAction {
  final Activity activity;

  StopActivityAction(this.activity);
}

class ResetActivityAction {
  final Activity activity;

  ResetActivityAction(this.activity);
}
