import 'package:flutter/material.dart';
import 'package:wokwi_talkie/components/back_button.dart';
import 'package:wokwi_talkie/components/room_control.dart';
import 'package:wokwi_talkie/constant.dart';
import 'package:wokwi_talkie/models/fans.dart';
import 'package:wokwi_talkie/models/lights.dart';

class Rooms extends StatefulWidget {
  const Rooms(
      {Key? key,
      required this.selectScreen,
      required this.lights,
      required this.fans,
      required this.setLights,
      required this.setFans})
      : super(key: key);

  final Function(int) selectScreen;
  final Lights lights;
  final Fans fans;
  final VoidCallback setLights;
  final VoidCallback setFans;

  @override
  _RoomsState createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            'Rooms',
            style: TextStyle(
                fontFamily: 'Rubik', fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ListView.builder(
            itemCount: rooms.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 7.5),
                child: RoomControl(
                  calls: [
                    (val) {
                      setState(() {
                        widget.lights.lights[index] = val;
                        widget.setLights();
                      });
                    },
                    (val) {
                      setState(() {
                        widget.fans.fans[index] = val;
                        widget.setFans();
                      });
                    }
                  ],
                  label: rooms[index]['room'],
                  icon: rooms[index]['m-icon'],
                  switches: [
                    widget.lights.lights[index],
                    widget.fans.fans[index]
                  ],
                ),
              );
            }),
      ])),
    );
  }
}
