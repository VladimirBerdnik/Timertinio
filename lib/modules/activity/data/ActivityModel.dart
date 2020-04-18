import 'package:flutter/material.dart';

class Activity {
  final String _name;
  final Color _color;
  Duration _duration = new Duration();
  DateTime _lastStartTime;

  Activity(this._name, this._color);

  String get name => _name;

  Duration get duration => !isStarted() ? _duration : _duration + DateTime.now().difference(_lastStartTime);

  DateTime get lastStartTime => _lastStartTime;

  Color get color => _color;

  bool isStarted() {
    return _lastStartTime != null;
  }

  void start() {
    if (isStarted()) {
      return;
    }

    _lastStartTime = DateTime.now();
  }

  void stop() {
    if (!isStarted()) {
      return;
    }

    _duration = _duration + DateTime.now().difference(_lastStartTime);
    _lastStartTime = null;
  }

  void reset() {
    this._duration = new Duration();
    this._lastStartTime = null;
  }

  toJson() {
    return {
      'name': _name,
      'color': _color.value,
      'duration': _duration.inSeconds,
      'lastStartTime': isStarted() ? _lastStartTime.millisecondsSinceEpoch : null
    };
  }

  static Activity fromJson(json) {
    Activity activity = Activity(json['name'], new Color(json['color'] as int));
    activity._duration = new Duration(seconds: json['duration'] as int);
    activity._lastStartTime =
        json['lastStartTime'] != null ? DateTime.fromMillisecondsSinceEpoch(json['lastStartTime'] as int) : null;

    return activity;
  }
}
