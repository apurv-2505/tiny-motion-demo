import 'package:flutter/material.dart';

class AppStyles {
  // Text Styles
  static TextStyle welcomeText(BuildContext context) =>
      Theme.of(context).textTheme.displayLarge!;

  static TextStyle headingText(BuildContext context) =>
      Theme.of(context).textTheme.headlineMedium!;

  static TextStyle normalText(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!;

  // Glassmorphic Input Field
  static Widget glassTextField({
    required TextEditingController controller,
    required String hint,
    bool isEnabled = true,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color.fromARGB(184, 247, 220, 255),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: TextFormField(
          controller: controller,
          enabled: isEnabled,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  // Confirm Button (Blue with White Text)
  static Widget confirmButton({
    required VoidCallback onPressed,
    required String text,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blue),
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
        child: Text(text),
      ),
    );
  }

  // Custom ListTile Widget
  static Widget customListTile({
    required IconData leadingIcon,
    required String title,
    required String subtitle,
    required IconData trailingIcon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 229, 240, 249),
              radius: 24,
              child: Icon(leadingIcon, size: 20, color: Colors.blue),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Icon(trailingIcon, size: 20, color: Colors.grey), // Trailing icon
          ],
        ),
      ),
    );
  }
}
