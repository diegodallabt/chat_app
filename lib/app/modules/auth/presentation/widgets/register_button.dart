import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final Color backgroundColor;
  final Color textColor;
  final EdgeInsets? padding;

  const RegisterButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              padding: padding,
              backgroundColor: backgroundColor,
              foregroundColor: textColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            child: const Text(
              'Cadastrar',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          );
  }
}
