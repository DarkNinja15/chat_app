import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  final TextInputType textInputType;
  final String hintText;
  final String labelText;
  final bool obscure;
  const TextForm({
    Key? key,
    required this.textInputType,
    required this.hintText,
    required this.labelText,
    this.obscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        hintStyle: const TextStyle(
          color: Colors.purpleAccent,
        ),
        labelStyle: const TextStyle(
          color: Colors.purpleAccent,
          fontWeight: FontWeight.bold,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            25.0,
          ),
          borderSide: const BorderSide(
            color: Colors.purpleAccent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            25.0,
          ),
          borderSide: const BorderSide(
            color: Colors.purpleAccent,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            25.0,
          ),
        ),
      ),
      keyboardType: textInputType,
      obscureText: obscure,
    );
  }
}
