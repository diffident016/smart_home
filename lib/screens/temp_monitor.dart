import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:wokwi_talkie/components/back_button.dart';
import 'package:wokwi_talkie/components/custom_gauge.dart';
import 'package:wokwi_talkie/constant.dart';
import 'package:wokwi_talkie/models/temp.dart';

class TempMonitor extends StatefulWidget {
  const TempMonitor({Key? key, required this.selectScreen, required this.temp})
      : super(key: key);

  final Function(int) selectScreen;
  final Temp temp;
  @override
  _TempMonitorState createState() => _TempMonitorState();
}

class _TempMonitorState extends State<TempMonitor>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          CBackButton(
            onTap: (() {
              widget.selectScreen(1);
            }),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Text(
              'Temperature Monitor',
              style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  width: double.infinity,
                  height: 245,
                  child: Stack(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 40),
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 200,
                          child: CustomPaint(
                              painter:
                                  CustomGauge(value: widget.temp.temperature))),
                      const Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                            width: 64,
                            child: Center(
                              child: Text(
                                'Heat Index',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            )),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            margin: const EdgeInsets.only(top: 60),
                            child: Text(
                              '${(widget.temp.temperature * 100).round().toString()}\u00B0C',
                              style: const TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            height: 25,
                            margin: const EdgeInsets.only(top: 160),
                            child: const Text(
                              'Temperature',
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  width: double.infinity,
                  height: 245,
                  child: Stack(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 40),
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 200,
                          child: CustomPaint(
                              painter:
                                  CustomGauge(value: widget.temp.humidity))),
                      const Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                            width: 64,
                            child: Center(
                              child: Text(
                                'Currently',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            )),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            margin: const EdgeInsets.only(top: 60),
                            child: Text(
                              '${(widget.temp.humidity * 100).round().toString()}%',
                              style: const TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            height: 25,
                            margin: const EdgeInsets.only(top: 160),
                            child: const Text(
                              'Humidity',
                              style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  )),
            ),
          )
        ],
      )),
    );
  }
}
