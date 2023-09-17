import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icthubx/screens/home_layout.dart';
import 'package:icthubx/widgets/mtTextFormField.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> signup(
    String email,
    String pass,
  ) async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: pass)
            .then(
          (value) {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeLayout(),
                ),
                (route) => false,
              );
            }
          },
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Sign up',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              MyFormFiled(
                controller: emailC,
                validator: (value) {
                  if (!value!.contains('@ict')) {
                    return 'must contain @ict';
                  }
                },
                hintText: 'email',
              ),
              MyFormFiled(
                controller: passwordC,
                validator: (value) {
                  if (value!.length < 6) {
                    return 'password must be 6 ';
                  }
                },
                hintText: 'password',
              ),
              TextButton(
                onPressed: () {
                  signup(
                    emailC.text,
                    passwordC.text,
                  );
                },
                child: const Text(
                  'Signup',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
