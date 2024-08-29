import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/home/app_colors.dart';

typedef MyValidator = String? Function(String?);
class CustomTextFormField extends StatelessWidget {
  String label;
  MyValidator Validator;
  TextInputType keyboardType;
  TextEditingController controller;
  bool obscureText;
  CustomTextFormField({required this.label,required this.Validator,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 2
            ),
          ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  color: AppColors.primaryColor,
                  width: 2
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  color: AppColors.redColor,
                  width: 2
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  color: AppColors.redColor,
                  width: 2
              ),
            ),
            labelText: label,
        ),
        validator: Validator,
        keyboardType: keyboardType,
        controller: controller,
        obscureText: obscureText,
      ),
    );
  }
}
