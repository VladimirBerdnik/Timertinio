import 'package:flutter/material.dart';

class Activity {
  final String _name;
  final Color _color;
  final int _priority;
  Duration _duration = new Duration();
  DateTime _lastStartTime;

  Activity(this._name, this._priority, this._color);

  String get name => _name;

  int get priority => _priority;

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
      'priority': _priority,
      'lastStartTime': isStarted() ? _lastStartTime.millisecondsSinceEpoch : null
    };
  }

  static Activity fromJson(json) {
    final int priority = json['priority'] != null ? json['priority'] as int : 0;
    final String name = json['name'];
    final Color color = new Color(json['color'] as int);
    final Duration duration = new Duration(seconds: json['duration'] as int);
    final DateTime lastStartTime =
        json['lastStartTime'] != null ? DateTime.fromMillisecondsSinceEpoch(json['lastStartTime'] as int) : null;

    Activity activity = Activity(name, priority, color);
    activity._duration = duration;
    activity._lastStartTime = lastStartTime;

    return activity;
  }
}
