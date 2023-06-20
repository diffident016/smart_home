import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wokwi_talkie/components/control_switch.dart';
import 'package:wokwi_talkie/constant.dart';
import 'package:wokwi_talkie/models/lights.dart';
import 'package:wokwi_talkie/screens/alarms_device.dart';
import 'package:wokwi_talkie/screens/lights_devices.dart';
import 'package:wokwi_talkie/screens/rooms.dart';
import 'package:wokwi_talkie/screens/socket_devices.dart';
import 'package:wokwi_talkie/screens/temp_monitor.dart';
import 'package:wokwi_talkie/screens/voice_assistant.dart';

class Homepage extends StatefulWidget {
  const Homepage(
      {Key? key,
      required this.selectScreen,
      required this.lights,
      required this.setLights})
      : super(key: key);

  final Function(int) selectScreen;
  final Lights lights;
  final VoidCallback setLights;

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Padding(
            padding: const EdgeInsets.only(top: 40, left: 25, right: 25),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: double.infinity,
                      height: 95,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/bg.png'),
                              fit: BoxFit.cover)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Welcome to your',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Roboto',
                                      color: textColor,
                                    )),
                                Text('SMART HOME!',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: textColor,
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            Image.asset(
                              'assets/images/logo.png',
                              width: 55,
                              height: 55,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Devices',
                      style: TextStyle(color: textColor, fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _buildDevices(
                            size, 'Lights', FontAwesomeIcons.solidLightbulb,
                            () {
                          widget.selectScreen(2);
                        }),
                        _buildDevices(size, 'Sockets', FontAwesomeIcons.plug,
                            () {
                          widget.selectScreen(3);
                        })
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _buildDevices(
                            size, 'Alarms', FontAwesomeIcons.solidBell, () {
                          widget.selectScreen(4);
                        }),
                        _buildDevices(size, 'Temperature',
                            FontAwesomeIcons.temperatureFull, () {
                          widget.selectScreen(5);
                        })
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Rooms',
                          style: TextStyle(color: textColor, fontSize: 15),
                        ),
                        GestureDetector(
                          onTap: () {
                            widget.selectScreen(6);
                          },
                          child: const Text(
                            'See all',
                            style: TextStyle(
                                color: textColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w100),
                          ),
                        )
                      ],
                    ),
                  ),
                  ListView.builder(
                      itemCount: 2,
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: ControlSwitch(
                              label: rooms[index]['room'],
                              icon: rooms[index]['icon'],
                              value: widget.lights.lights[index],
                              onTap: (val) {
                                setState(() {
                                  widget.lights.lights[index] = val;
                                  widget.setLights();
                                });
                              }),
                        );
                      })),
                  Expanded(
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          widget.selectScreen(7);
                        },
                        child: Material(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(48),
                          child: Container(
                            width: 52,
                            height: 52,
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: const Icon(FontAwesomeIcons.microphone),
                          ),
                        ),
                      ),
                    ),
                  )
                ])),
      ),
    );
  }

  Widget _buildRooms(
      String label, IconData icon, bool value, Function(bool) onChange) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 24),
            horizontalTitleGap: 1,
            dense: true,
            leading: Icon(
              icon,
              color: Colors.black,
              size: 25,
            ),
            title: Text(
              label,
              style: const TextStyle(
                  color: textColor,
                  fontFamily: 'Rubik',
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Controls',
              style: TextStyle(fontSize: 12),
            ),
            trailing: Switch(
              value: value,
              onChanged: onChange,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDevices(
      Size size, String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        child: SizedBox(
          height: 110,
          width: (size.width / 2) - 40,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: primaryColor,
                    size: 30,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    label,
                    style: const TextStyle(
                        color: textColor,
                        fontFamily: 'Rubik',
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
