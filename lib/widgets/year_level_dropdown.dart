import 'package:flutter/material.dart';

class YearLevelDropdown extends StatelessWidget {
  final List<String> yearLevels;
  final String selectedItem;
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String>? validator;

  YearLevelDropdown({
    required this.yearLevels,
    required this.selectedItem,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<String>(
        value: selectedItem,
        decoration: InputDecoration(
          labelText: 'YEAR LEVEL',
          border: OutlineInputBorder(),
        ),
        items: yearLevels.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}

List<String> yearLevelsList = [
  '1st Year',
  '2nd Year',
  '3rd Year',
  '4th Year',
  '5th Year',
];
