import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isPassword;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(
        color: Color.fromARGB(255, 34, 34, 34),
      ),
      decoration: InputDecoration(
        prefixIcon:
            Icon(isPassword ? Icons.lock_outline : Icons.person_outlined),
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.grey),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 44, 192, 163), width: 2.0),
        ),
      ),
    );
  }
}
