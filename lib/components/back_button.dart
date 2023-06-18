import 'package:flutter/material.dart';

class CBackButton extends StatelessWidget {
  final VoidCallback onTap;
  const CBackButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 64,
        height: 40,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        child: const Icon(
          Icons.arrow_back,
          size: 24,
        ),
      ),
    );
  }
}
