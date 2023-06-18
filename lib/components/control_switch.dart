import 'package:flutter/material.dart';

import '../constant.dart';

class ControlSwitch extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool value;
  final Function(bool) onTap;

  const ControlSwitch(
      {Key? key,
      required this.label,
      required this.icon,
      required this.value,
      required this.onTap})
      : super(key: key);

  @override
  _ControlSwitchState createState() => _ControlSwitchState();
}

class _ControlSwitchState extends State<ControlSwitch> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          horizontalTitleGap: 1,
          dense: true,
          leading: Icon(
            widget.icon,
            color: Colors.black,
            size: 25,
          ),
          title: Text(
            widget.label,
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
          trailing: Switch(value: widget.value, onChanged: widget.onTap),
        ),
      ),
    );
  }
}
