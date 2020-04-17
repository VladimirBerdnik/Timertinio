import 'package:timertinio/modules/activity/data/ActivityModel.dart';

class ActivitiesGroup {
  List<Activity> _items = [];

  ActivitiesGroup();

  void add(Activity activity) {
    this._items.add(activity);
  }


  List<Activity> get activities => _items;

  Activity getActivity(Activity activity) {
    return _items.firstWhere((Activity item) => item.name == activity.name);
  }

  void startActivity(Activity activity) {
    getActivity(activity).start();
  }

  void stopActivity(Activity activity) {
    getActivity(activity).stop();
  }

  void resetActivity(Activity activity) {
    getActivity(activity).reset();
  }

  toJson() {
    List serializedItems = [];
    _items.forEach((Activity activity) {
      serializedItems.add(activity.toJson());
    });

    return {'groupItems': serializedItems};
  }

  static ActivitiesGroup fromJson(json) {
    ActivitiesGroup activitiesGroup = ActivitiesGroup();
    (json['groupItems'] as List).forEach((value) {
      activitiesGroup.add(Activity.fromJson(value));
    });

    return activitiesGroup;
  }
}
