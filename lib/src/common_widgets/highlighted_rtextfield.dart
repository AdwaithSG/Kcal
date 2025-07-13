import 'package:flutter/material.dart';

class HighlightRoundTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Widget prefixIcon;
  final FormFieldValidator<String>? validator;

  const HighlightRoundTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return TextFormField(
      style: TextStyle(
          color:
          const Color.fromARGB(255, 0, 0, 0)),
      validator: validator,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: labelText,
          labelStyle: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(screenHeight * 0.03),
        ),
        filled: true,
        fillColor: Color.fromARGB(0, 3, 3, 3),
        hintStyle:
        TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
        contentPadding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.03,
            horizontal: screenHeight * 0.08),
      ),
    );
  }
}
