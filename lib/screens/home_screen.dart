import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Welcome Back,',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              'images/img.png',
            ),
            const MyCont(
              textK: 'Get Start',
              widthK: 200,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyCont(
                  textK: 'Sign up',
                  widthK: 100,
                ),
                SizedBox(
                  width: 30,
                ),
                MyCont(
                  textK: 'login',
                  widthK: 100,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyCont extends StatelessWidget {
  final String textK;

  final double widthK;

  const MyCont({super.key, required this.textK, required this.widthK});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthK,
      height: 70,
      color: const Color(0xff4A1EC7),
      alignment: Alignment.center,
      child: Text(
        textK,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
