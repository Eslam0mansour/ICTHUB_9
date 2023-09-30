import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icthubx/colors.dart';
import 'package:icthubx/cubit/auth_cubit.dart';
import 'package:icthubx/cubit/auth_state.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.scaffold,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
        ),
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
                controller: emailC,
                validator: (value) {
                  if (!value!.contains('@ict')) {
                    return 'must contain @ict';
                  }
                  return null;
                },
                hintText: 'Enter your email',
              ),
              MyFormFiled(
                controller: passwordC,
                validator: (value) {
                  if (value!.length < 6) {
                    return 'password must be 6 ';
                  }
                },
                hintText: 'Enter your password',
              ),
              const Spacer(
                flex: 2,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeLayout(),
                      ),
                      (route) => false,
                    );
                  } else if (state is LoginError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      state.error,
                    )));
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
                    onPressed: state is LoginLoading
                        ? null
                        : () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthCubit>().login(
                                    email: emailC.text,
                                    pass: passwordC.text,
                                  );
                              FocusScope.of(context).unfocus();
                            }
                          },
                    child: state is LoginLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const Text(
                            'Login',
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
              const Spacer(
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Don’t have an account?',
                    style: TextStyle(
                      fontSize: 17,
                      color: AppColors.blackBold,
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
                      'Register Now',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.redK,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
