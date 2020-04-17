class Activity {
  final String _name;
  double _duration = 0.0;
  DateTime _lastStartTime;

  Activity(this._name);

  String get name => _name;

  double get duration => _duration + (isStarted() ? DateTime.now().difference(_lastStartTime).inSeconds : 0);

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

    _duration += DateTime.now().difference(_lastStartTime).inSeconds;
  }

  void reset() {
    this._duration = 0.0;
    this._lastStartTime = null;
  }

  toJson() {
    return {
      'name': _name,
      'duration': _duration,
      'lastStartTime': _lastStartTime.millisecondsSinceEpoch,
    };
  }

  static Activity fromJson(json) {
    Activity activity = Activity(json['name']);
    activity._duration = json['duration'] as double;
    activity._lastStartTime = DateTime.fromMillisecondsSinceEpoch(json['lastStartTime'] as int);
  }
}
