class Alarm {
  bool enable;
  bool alert;

  Alarm({this.enable = false, this.alert = false});

  static Alarm fromJson(Map json) =>
      Alarm(alert: json['alert'], enable: json['enable']);
}
