import 'package:flutter/material.dart';
import 'package:icthubx/screens/screen_2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Screen2(
                      textG: counter.toString(),
                    ),
                  ),
                );
              },
              child: const Text(
                'screen two',
              ),
            )
          ],
        ),
      ),
    );
  }
}
