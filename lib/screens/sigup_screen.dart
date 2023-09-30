import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icthubx/colors.dart';
import 'package:icthubx/cubit/auth_cubit.dart';
import 'package:icthubx/cubit/auth_state.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 3,
                ),
                const Text(
                  'Welcome back! Glad to see you, Again!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'UrbanistBold',
                  ),
                ),
                const Spacer(),
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
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is SignupSuccess) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeLayout(),
                        ),
                        (route) => false,
                      );
                    } else if (state is SignupError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.error,
                          ),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: state is SignupLoading
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                context.read<AuthCubit>().signup(
                                      pass: passwordC.text,
                                      email: emailC.text,
                                      phone: phoneC.text,
                                      name: namedC.text,
                                    );
                                FocusScope.of(context).unfocus();
                              }
                            },
                      child: state is SignupLoading
                          ? const Center(child: CircularProgressIndicator())
                          : const Text(
                              'Signup',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                    );
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 29,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: AppColors.divider,
                          thickness: 2,
                        ),
                      ),
                      Text(
                        'Or Login with',
                        style: TextStyle(
                          color: AppColors.hintTextK,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: AppColors.divider,
                          thickness: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset(
                      'images/apple.svg',
                    ),
                    SvgPicture.asset(
                      'images/google.svg',
                    ),
                    SvgPicture.asset(
                      'images/facebook.svg',
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
