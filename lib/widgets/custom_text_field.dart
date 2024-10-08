import 'package:flutter/material.dart';
import '../themes/theme.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final String? hintBelowText; // Optional hint text below the field
  final bool obscureText;
  final bool showHintBelow;
  final Color? labelColor; // Optional color for the label text
  final Color? hintColor; // Optional color for the hint text
  final Color? textColor; // Optional color for the text input
  final double borderRadius; // Border radius for rounded corners
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? errorText; // Optional error text
  final TextInputType inputType; // Input type for keyboard
  final bool isReadOnly; // Read-only state for the text field

  const CustomTextField({
    Key? key,
    required this.label,
    required this.hintText,
    this.hintBelowText, // Optional parameter for additional hint text
    this.obscureText = false,
    this.showHintBelow = false,
    this.labelColor, // Optional color for the label text
    this.hintColor, // Optional color for the hint text
    this.textColor, // Optional color for the text input
    this.borderRadius = 8.0, // Default border radius
    required this.controller,
    this.focusNode,
    this.errorText, // Add error text
    this.inputType = TextInputType.text, // Default input type
    this.isReadOnly = false, // Default is editable
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: labelColor ?? Colors.black, // Use provided color or default to black
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          focusNode: focusNode, // Set focusNode
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: hintColor ?? Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: AppTheme.dividerColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(color: Colors.black),
            ),
            errorText: errorText, // Display error text if any
          ),
          obscureText: obscureText,
          style: TextStyle(color: textColor ?? Colors.black),
          keyboardType: inputType, // Use the specified input type
          readOnly: isReadOnly, // Make it read-only if specified
        ),
        if (showHintBelow || hintBelowText != null) // Display custom hint text below the field
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              showHintBelow ? "Must be at least 6 characters" : hintBelowText!,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
      ],
    );
  }
}
