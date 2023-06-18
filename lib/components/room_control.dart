import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wokwi_talkie/constant.dart';

class RoomControl extends StatefulWidget {
  const RoomControl(
      {Key? key,
      required this.icon,
      required this.label,
      required this.switches,
      required this.calls})
      : super(key: key);

  final IconData icon;
  final String label;
  final List<bool> switches;
  final List<Function(bool)> calls;

  @override
  _RoomControlState createState() => _RoomControlState();
}

class _RoomControlState extends State<RoomControl> {
  bool expand = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: double.infinity,
        height: expand ? 160 : 70,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ListTile(
            leading: Icon(
              widget.icon,
              color: Colors.black,
            ),
            title: Text(
              widget.label,
              style: const TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            trailing: GestureDetector(
              onTap: () {
                setState(() {
                  expand = !expand;
                });
              },
              child: Icon(
                expand
                    ? FontAwesomeIcons.chevronUp
                    : FontAwesomeIcons.chevronDown,
                size: 18,
                color: Colors.black,
              ),
            ),
            dense: true,
            horizontalTitleGap: 1,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          ),
          if (expand) _switches(widget.switches, widget.calls)
        ]),
      ),
    );
  }

  Widget _switches(List<bool> switches, List<Function(bool)> onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 45, top: 5, bottom: 5, right: 15),
            child: SizedBox(
              height: 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Lights',
                      style: TextStyle(fontSize: 14, color: textColor)),
                  Switch(value: switches[0], onChanged: onTap[0])
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 45, top: 5, bottom: 5, right: 15),
            child: SizedBox(
              height: 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Fan',
                      style: TextStyle(fontSize: 14, color: textColor)),
                  Switch(value: switches[1], onChanged: onTap[1])
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
