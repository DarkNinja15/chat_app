import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  final TextInputType textInputType;
  final String hintText;
  final String labelText;
  final bool obscure;
  final Icon icon;
  final TextEditingController textEditingController;
  const TextForm({
    Key? key,
    required this.textInputType,
    required this.hintText,
    required this.labelText,
    required this.icon,
    required this.textEditingController,
    this.obscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      shadowColor: Colors.purple.shade100,
      color: Colors.transparent,
      elevation: 25,
      child: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          prefixIcon: icon,
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
        validator: (value) {
          if (textInputType == TextInputType.emailAddress) {
            if (value!.isEmpty) {
              return 'Enter email';
            }
            if (!value.endsWith('.com')) {
              return 'Invalid email';
            }
          } else if (textInputType == TextInputType.text) {
            if (value!.isEmpty) {
              return 'Enter password';
            }
            if (value.length < 6) {
              return 'Password too short';
            }
          }
        },
        onSaved: (value) {},
      ),
    );
  }
}

class Shared {
  navigate(BuildContext context, Widget Function() widget) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: ((context) => widget()),
      ),
    );
  }
}
