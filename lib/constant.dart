import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const bgColor = Color(0xFFF2F5FA);
const primaryColor = Colors.black;
const textColor = Colors.black;

const List<Map<String, dynamic>> rooms = [
  {
    "room": "Kitchen",
    "icon": FontAwesomeIcons.solidLightbulb,
    "m-icon": FontAwesomeIcons.mortarPestle
  },
  {
    "room": "Living Room",
    "icon": FontAwesomeIcons.solidLightbulb,
    "m-icon": FontAwesomeIcons.couch
  },
  {
    "room": "Master Bedroom",
    "icon": FontAwesomeIcons.solidLightbulb,
    "m-icon": FontAwesomeIcons.bed
  },
  {
    "room": "Guest Room",
    "icon": FontAwesomeIcons.solidLightbulb,
    "m-icon": FontAwesomeIcons.bed
  },
];

const List<Map<String, dynamic>> sockets = [
  {"socket": "Socket 1", "icon": FontAwesomeIcons.plug},
  {"socket": "Socket 2", "icon": FontAwesomeIcons.plug},
  {"socket": "Socket 3", "icon": FontAwesomeIcons.plug},
  {"socket": "Socket 4", "icon": FontAwesomeIcons.plug}
];
