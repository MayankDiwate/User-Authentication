import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget({
    super.key,
    required this.validate,
    required this.prefixIcon,
    this.sufficIcon = const Icon(Icons.circle, size: 0),
    this.obscureText = false,
    required this.controller,
    required this.hintText,
    required this.keyboardType,
    this.length = 100,
  });

  late String? Function(String?)? validate;
  final Icon prefixIcon;
  late Widget sufficIcon;
  bool obscureText;
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final int length;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(fontSize: 20),
      validator: (value) => validate!(value),
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: [LengthLimitingTextInputFormatter(length)],
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: sufficIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
