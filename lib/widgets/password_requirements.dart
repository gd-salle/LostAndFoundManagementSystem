import 'package:flutter/material.dart';

class PasswordCriteria extends StatelessWidget {
  final bool hasLowercase;
  final bool hasUppercase;
  final bool hasNumber;
  final bool hasSpecial;
  final bool hasMinLength;

  const PasswordCriteria({
    Key? key,
    required this.hasLowercase,
    required this.hasUppercase,
    required this.hasNumber,
    required this.hasSpecial,
    required this.hasMinLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(hasLowercase ? Icons.check_circle : Icons.radio_button_unchecked, color: hasLowercase ? Colors.green : Colors.red),
            SizedBox(width: 8),
            Text('One lowercase character'),
          ],
        ),
        Row(
          children: [
            Icon(hasUppercase ? Icons.check_circle : Icons.radio_button_unchecked, color: hasUppercase ? Colors.green : Colors.red),
            SizedBox(width: 8),
            Text('One uppercase character'),
          ],
        ),
        Row(
          children: [
            Icon(hasNumber ? Icons.check_circle : Icons.radio_button_unchecked, color: hasNumber ? Colors.green : Colors.red),
            SizedBox(width: 8),
            Text('One number'),
          ],
        ),
        Row(
          children: [
            Icon(hasSpecial ? Icons.check_circle : Icons.radio_button_unchecked, color: hasSpecial ? Colors.green : Colors.red),
            SizedBox(width: 8),
            Text('One special character'),
          ],
        ),
        Row(
          children: [
            Icon(hasMinLength ? Icons.check_circle : Icons.radio_button_unchecked, color: hasMinLength ? Colors.green : Colors.red),
            SizedBox(width: 8),
            Text('8 characters minimum'),
          ],
        ),
      ],
    );
  }
}
