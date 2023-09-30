import 'package:flutter/material.dart';
import 'package:icthubx/colors.dart';

class MyFormFiled extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  Widget? prefixIcon;
  TextInputType? keyboardType;
  final void Function(String)? onChanged;

  MyFormFiled({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.prefixIcon,
    this.keyboardType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: AppColors.border,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Colors.blue,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: AppColors.border,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: AppColors.border,
            ),
          ),
          fillColor: AppColors.formText,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppColors.hintText,
            fontSize: 17,
            fontFamily: 'Urbanist',
          ),
          prefixIcon: prefixIcon,
        ),
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}
