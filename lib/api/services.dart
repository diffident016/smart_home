import 'package:firebase_database/firebase_database.dart';
import 'package:wokwi_talkie/models/alarm.dart';
import 'package:wokwi_talkie/models/fans.dart';
import 'package:wokwi_talkie/models/lights.dart';
import 'package:wokwi_talkie/models/sockets.dart';

class Services {
  static setLight(Lights lights) {
    final dataRef = FirebaseDatabase.instance.ref('smart_home/data/lights');

    dataRef.update(lights.toJson());
  }

  static setSocket(Sockets sockets) {
    final dataRef = FirebaseDatabase.instance.ref('smart_home/data/sockets');

    dataRef.update(sockets.toJson());
  }

  static setAlarm(Alarm alarm) {
    final dataRef = FirebaseDatabase.instance.ref('smart_home/data/alarm');

    dataRef.update({"enable": alarm.enable});
  }

  static setFans(Fans fans) {
    final dataRef = FirebaseDatabase.instance.ref('smart_home/data/fans');

    dataRef.update(fans.toJson());
  }
}
