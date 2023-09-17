import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:icthubx/screens/home_layout.dart';
import 'package:icthubx/screens/login_screen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ICTAPP());
}

class ICTAPP extends StatelessWidget {
  ICTAPP({super.key});

  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: user != null ? const HomeLayout() : const LoginScreen(),
    );
  }
}
