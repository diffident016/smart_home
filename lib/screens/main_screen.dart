import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wokwi_talkie/api/services.dart';
import 'package:wokwi_talkie/constant.dart';
import 'package:wokwi_talkie/models/alarm.dart';
import 'package:wokwi_talkie/models/lights.dart';
import 'package:wokwi_talkie/models/sockets.dart';
import 'package:wokwi_talkie/models/temp.dart';
import 'package:wokwi_talkie/screens/alarms_device.dart';
import 'package:wokwi_talkie/screens/homepage.dart';
import 'package:wokwi_talkie/screens/lights_devices.dart';
import 'package:wokwi_talkie/screens/notifications.dart';
import 'package:wokwi_talkie/screens/rooms.dart';
import 'package:wokwi_talkie/screens/settings.dart';
import 'package:wokwi_talkie/screens/socket_devices.dart';
import 'package:wokwi_talkie/screens/temp_monitor.dart';
import 'package:wokwi_talkie/screens/voice_assistant.dart';

import '../models/fans.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final refDataInstance = FirebaseDatabase.instance.ref('smart_home');

  late StreamSubscription<DatabaseEvent> _dataSubscription;
  late DatabaseReference _dataRef;

  Lights lights = Lights();
  Sockets sockets = Sockets();
  Fans fans = Fans();
  Temp temp = Temp();
  Alarm alarm = Alarm();

  void selectScreen(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    getData();
  }

  void getData() async {
    _dataRef = FirebaseDatabase.instance.ref('smart_home');

    _dataSubscription = _dataRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        final data = (event.snapshot.value as Map)['data'];
        print(data);

        lights = Lights.fromJson(data['lights']);
        fans = Fans.fromJson(data['fans']);
        temp = Temp.fromJson(data['temp_monitor']);
        alarm = Alarm.fromJson(data['alarm']);
        sockets = Sockets.fromJson(data['sockets']);
      });
    }, onError: (Object o) {
      final error = o as FirebaseException;
      setState(() {
        print(error);
      });
    });
  }

  void updateLights() {
    Services.setLight(lights);
  }

  void updateSockets() {
    Services.setSocket(sockets);
  }

  void updateAlarm() {
    Services.setAlarm(alarm);
  }

  void updateFans() {
    Services.setFans(fans);
  }

  @override
  void dispose() {
    super.dispose();
    _dataSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: IndexedStack(index: currentIndex, children: [
          Homepage(
            selectScreen: selectScreen,
            lights: lights,
            setLights: updateLights,
          ),
          Settings(),
          LightsDevices(
            selectScreen: selectScreen,
            lights: lights,
            updateLights: updateLights,
          ),
          SocketDevices(
            selectScreen: selectScreen,
            sockets: sockets,
            setSockets: updateSockets,
          ),
          AlarmsDevice(
            selectScreen: selectScreen,
            alarm: alarm,
            updateAlarm: updateAlarm,
          ),
          TempMonitor(
            selectScreen: selectScreen,
            temp: temp,
          ),
          Rooms(
            selectScreen: selectScreen,
            lights: lights,
            fans: fans,
            setLights: updateLights,
            setFans: updateFans,
          ),
          VoiceAssistant(
            selectScreen: selectScreen,
            updateLights: updateLights,
            updateFans: updateFans,
            updateSocket: updateSockets,
            lights: lights,
            fans: fans,
            sockets: sockets,
          )
        ]),
        bottomNavigationBar: CurvedNavigationBar(
          color: Colors.white,
          backgroundColor: bgColor,
          buttonBackgroundColor: Colors.transparent,
          height: 55,
          index: currentIndex > 1 ? 0 : currentIndex,
          onTap: (index) {
            FocusManager.instance.primaryFocus?.unfocus();
            selectScreen(index);
          },
          items: const [
            Icon(FontAwesomeIcons.house),
            Icon(FontAwesomeIcons.gear),
          ],
        ));
  }
}
