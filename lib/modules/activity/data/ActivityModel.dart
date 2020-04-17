class Activity {
  final String _name;
  Duration _duration = new Duration();
  DateTime _lastStartTime;

  Activity(this._name);

  String get name => _name;

  Duration get duration => !isStarted() ? _duration : _duration + DateTime.now().difference(_lastStartTime);

  DateTime get lastStartTime => _lastStartTime;

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
      'duration': _duration.inSeconds,
      'lastStartTime': isStarted() ? _lastStartTime.millisecondsSinceEpoch : null
    };
  }

  static Activity fromJson(json) {
    Activity activity = Activity(json['name']);
    activity._duration = new Duration(seconds: json['duration'] as int);
    activity._lastStartTime =
        json['lastStartTime'] != null ? DateTime.fromMillisecondsSinceEpoch(json['lastStartTime'] as int) : null;

    return activity;
  }
}
