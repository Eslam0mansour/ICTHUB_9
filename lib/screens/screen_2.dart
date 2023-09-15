import 'package:flutter/material.dart';

class Screen2 extends StatelessWidget {
  final String textG;
  const Screen2({
    super.key,
    required this.textG,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textG,
              style: const TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
