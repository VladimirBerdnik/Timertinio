import 'package:timertinio/modules/activity/data/ActivitiesGroupModel.dart';
import 'package:timertinio/modules/activity/data/ActivityModel.dart';
import 'package:timertinio/state/actions.dart';
import 'package:timertinio/state/state.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(activitiesGroupReducer(state.activitiesGroup, action));
}

ActivitiesGroup activitiesGroupReducer(ActivitiesGroup activitiesGroup, action) {
  if (action is StartActivityAction) {
    return startActivityReducer(activitiesGroup, action);
  } else if (action is StopActivityAction) {
    return stopActivityReducer(activitiesGroup, action);
  } else if (action is ResetActivityAction) {
    return resetActivityReducer(activitiesGroup, action);
  } else if (action is AddActivityAction) {
    return addActivityReducer(activitiesGroup, action);
  } else if (action is RemoveActivityAction) {
    return removeActivityReducer(activitiesGroup, action);
  }

  return activitiesGroup;
}

ActivitiesGroup startActivityReducer(ActivitiesGroup activitiesGroup, StartActivityAction action) {
  activitiesGroup.startActivity(action.activity);

  return activitiesGroup;
}

ActivitiesGroup stopActivityReducer(ActivitiesGroup activitiesGroup, StopActivityAction action) {
  activitiesGroup.stopActivity(action.activity);

  return activitiesGroup;
}

ActivitiesGroup resetActivityReducer(ActivitiesGroup activitiesGroup, ResetActivityAction action) {
  activitiesGroup.resetActivity(action.activity);

  return activitiesGroup;
}

ActivitiesGroup addActivityReducer(ActivitiesGroup activitiesGroup, AddActivityAction action) {
  activitiesGroup.add(new Activity(action.name, action.priority, action.color));

  return activitiesGroup;
}

ActivitiesGroup removeActivityReducer(ActivitiesGroup activitiesGroup, RemoveActivityAction action) {
  activitiesGroup.remove(action.activity);

  return activitiesGroup;
}
