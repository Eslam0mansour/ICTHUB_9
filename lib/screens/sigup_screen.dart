import 'package:cloud_firestore/cloud_firestore.dart';
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
  TextEditingController namedC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;
  Future<void> signup({
    required String email,
    required String pass,
    required String name,
    required String phone,
  }) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: pass)
            .then(
          (value) {
            if (value.user != null) {
              saveUserData(
                email,
                pass,
                name,
                phone,
                value.user!.uid,
              ).then((value) {
                if (value) {
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
              });
            }
          },
        );
      } catch (e) {
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

  Future<bool> saveUserData(
    String email,
    String pass,
    String name,
    String phone,
    String uid,
  ) async {
    try {
      FirebaseFirestore.instance.collection('users').doc(uid).set({
        'userName': name,
        'userEmail': email,
        'userPass': pass,
        'userPhone': phone,
        'uid': uid,
        'image': '',
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      print(e);
      return false;
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
                controller: namedC,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'name must be not empty';
                  }
                  return null;
                },
                hintText: 'name',
                prefixIcon: const Icon(
                  Icons.person,
                ),
              ),
              MyFormFiled(
                controller: emailC,
                validator: (value) {
                  if (!value!.contains('@ict')) {
                    return 'must contain @ict';
                  }
                  return null;
                },
                hintText: 'email',
                prefixIcon: const Icon(
                  Icons.email,
                ),
              ),
              MyFormFiled(
                controller: passwordC,
                validator: (value) {
                  if (value!.length < 6) {
                    return 'password must be 6 ';
                  }
                  return null;
                },
                hintText: 'password',
                prefixIcon: const Icon(
                  Icons.password,
                ),
              ),
              MyFormFiled(
                controller: phoneC,
                validator: (value) {
                  if (value!.length < 11) {
                    return 'phone must be 11 number ';
                  }
                  return null;
                },
                hintText: 'phone',
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(
                  Icons.phone,
                ),
              ),
              TextButton(
                onPressed: isLoading
                    ? null
                    : () {
                        signup(
                          pass: passwordC.text,
                          email: emailC.text,
                          phone: phoneC.text,
                          name: namedC.text,
                        );
                        FocusScope.of(context).unfocus();
                      },
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : const Text(
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
