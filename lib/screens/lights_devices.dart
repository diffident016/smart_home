import 'package:flutter/material.dart';
import 'package:wokwi_talkie/components/back_button.dart';
import 'package:wokwi_talkie/components/control_switch.dart';
import 'package:wokwi_talkie/constant.dart';
import 'package:wokwi_talkie/models/lights.dart';

class LightsDevices extends StatefulWidget {
  const LightsDevices(
      {Key? key,
      required this.selectScreen,
      required this.lights,
      required this.updateLights})
      : super(key: key);

  final Function(int) selectScreen;
  final Lights lights;
  final VoidCallback updateLights;

  @override
  _LightsDevicesState createState() => _LightsDevicesState();
}

class _LightsDevicesState extends State<LightsDevices> {
  @override
  void initState() {
    super.initState();
  }

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
              widget.selectScreen(0);
            }),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Text(
              'Light Controls',
              style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
              itemCount: rooms.length,
              shrinkWrap: true,
              itemBuilder: ((context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 7.5),
                  child: ControlSwitch(
                      label: rooms[index]['room'],
                      icon: rooms[index]['icon'],
                      value: widget.lights.lights[index],
                      onTap: (val) {
                        setState(() {
                          widget.lights.lights[index] = val;
                          widget.updateLights();
                        });
                      }),
                );
              }))
        ],
      )),
    );
  }
}
