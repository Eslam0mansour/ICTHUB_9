import 'package:flutter/material.dart';

class MyCOl extends StatelessWidget {
  final String txt;
  final Color clr;
  final IconData icon;

  const MyCOl({
    super.key,
    required this.txt,
    required this.clr,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: clr,
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.all(10),
          child: Icon(
            icon,
          ),
        ),
        Text(
          txt,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
