import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wokwi_talkie/components/back_button.dart';
import 'package:wokwi_talkie/constant.dart';
import 'package:wokwi_talkie/models/alarm.dart';

class AlarmsDevice extends StatefulWidget {
  const AlarmsDevice(
      {Key? key,
      required this.selectScreen,
      required this.alarm,
      required this.updateAlarm})
      : super(key: key);

  final Function(int) selectScreen;
  final Alarm alarm;
  final VoidCallback updateAlarm;

  @override
  _AlarmsDeviceState createState() => _AlarmsDeviceState();
}

class _AlarmsDeviceState extends State<AlarmsDevice> {
  bool sw = false;
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
              'Alarm Control',
              style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: double.infinity,
                height: 270,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Container(
                        alignment: AlignmentDirectional.topEnd,
                        child: Switch(
                            value: widget.alarm.enable,
                            onChanged: (val) {
                              setState(() {
                                widget.alarm.enable = val;
                                widget.updateAlarm();
                              });
                            }),
                      ),
                    ),
                    const Icon(
                      FontAwesomeIcons.solidBell,
                      size: 86,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        'Front Door Alarm',
                        style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Turn on to detect intruders',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
