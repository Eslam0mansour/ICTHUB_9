import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'counter: $counter',
              style: const TextStyle(
                fontSize: 30,
                color: Colors.green,
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  counter++;
                });
              },
              child: Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.5,
                color: Colors.red,
                alignment: Alignment.center,
                child: Text(
                  'add${MediaQuery.sizeOf(context).height}\n${MediaQuery.sizeOf(context).width}',
                  style: const TextStyle(fontSize: 30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
