import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icthubx/screens/home_layout.dart';
import 'package:icthubx/screens/sigup_screen.dart';
import 'package:icthubx/widgets/mtTextFormField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  Future<void> login({
    required String email,
    required String pass,
  }) async {
    if (formKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: pass)
            .then(
          (value) {
            if (value.user != null) {
              setState(() {
                isLoading = false;
              });
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
      } on FirebaseException catch (e) {
        setState(() {
          isLoading = false;
        });
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
              MyFormFiled(
                controller: emailC,
                validator: (value) {},
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
                  login(
                    email: emailC.text,
                    pass: passwordC.text,
                  );
                  FocusScope.of(context).unfocus();
                },
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupScreen(),
                    ),
                  );
                },
                child: const Text(
                  'You dont have an account',
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
