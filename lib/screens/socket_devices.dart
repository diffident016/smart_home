import 'package:flutter/material.dart';
import 'package:wokwi_talkie/components/back_button.dart';
import 'package:wokwi_talkie/components/control_switch.dart';
import 'package:wokwi_talkie/constant.dart';
import 'package:wokwi_talkie/models/sockets.dart';

class SocketDevices extends StatefulWidget {
  const SocketDevices(
      {Key? key,
      required this.selectScreen,
      required this.sockets,
      required this.setSockets})
      : super(key: key);

  final Function(int) selectScreen;
  final Sockets sockets;
  final VoidCallback setSockets;

  @override
  _SocketDevicesState createState() => _SocketDevicesState();
}

class _SocketDevicesState extends State<SocketDevices> {
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
              'Socket Controls',
              style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
              itemCount: sockets.length,
              shrinkWrap: true,
              itemBuilder: ((context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 7.5),
                  child: ControlSwitch(
                      label: sockets[index]['socket'],
                      icon: sockets[index]['icon'],
                      value: widget.sockets.sockets[index],
                      onTap: (val) {
                        setState(() {
                          widget.sockets.sockets[index] = val;
                          widget.setSockets();
                        });
                      }),
                );
              }))
        ],
      )),
    );
  }
}
