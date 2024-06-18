import 'package:flutter/material.dart';

class DepartmentDropdown extends StatelessWidget {
  final List<String> departments;
  final String selectedItem;
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String>? validator;

  DepartmentDropdown({
    required this.departments,
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
          labelText: 'DEPARTMENT',
          border: OutlineInputBorder(),
        ),
        items: departments.map((String value) {
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

List<String> departmentsList = [
  'Arts & Sciences',
  'Business & Accountancy',
  'Computer Studies',
  'Criminal Justice Education',
  'Education',
  'Engineering & Architecture',
  'Nursing',
  // 'Elementary',
  // 'Junior Highschool',
  // 'Senior Highschool',
];
