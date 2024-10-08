import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocialButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? iconColor; // Optional parameter for icon color
  final Color? labelColor; // Optional parameter for label color

  const SocialButton({
    required this.label,
    required this.icon,
    this.iconColor, // Initialize it as an optional parameter
    this.labelColor, // Initialize it as an optional parameter
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: Icon(
        icon,
        color: iconColor ?? Colors.black, // Use provided color or default to black
      ),
      label: Text(
        label,
        style: TextStyle(color: labelColor ?? Colors.black), // Use provided color or default to black
      ),
      onPressed: () {
        Get.snackbar(label, '$label button pressed',
            snackPosition: SnackPosition.BOTTOM);
      },
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50), // Full width buttons
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Set border radius for rectangular shape
        ),
        side: BorderSide(color: Colors.grey), // Optional: Customize border color
      ),
    );
  }
}
