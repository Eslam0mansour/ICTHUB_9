import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icthubx/cubit/app_cubit.dart';
import 'package:icthubx/obesrver.dart';
import 'package:icthubx/screens/home_layout.dart';
import 'package:icthubx/screens/login_screen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    BlocProvider(
      create: (context) => AppCubit()..getProductsData(),
      child: ICTAPP(),
    ),
  );
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
