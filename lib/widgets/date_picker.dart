import 'package:flutter/material.dart';

class DatePickerField extends FormField<DateTime> {
  DatePickerField({
    Key? key,
    required ValueChanged<DateTime> onChanged,
    required String placeholder,
    FormFieldValidator<DateTime>? validator,
  }) : super(
          key: key,
          validator: validator,
          builder: (FormFieldState<DateTime> state) {
            return _DatePickerFieldContent(
              state: state,
              onChanged: onChanged,
              placeholder: placeholder,
            );
          },
        );
}

class _DatePickerFieldContent extends StatefulWidget {
  final FormFieldState<DateTime> state;
  final ValueChanged<DateTime> onChanged;
  final String placeholder;

  const _DatePickerFieldContent({
    Key? key,
    required this.state,
    required this.onChanged,
    required this.placeholder,
  }) : super(key: key);

  @override
  _DatePickerFieldContentState createState() => _DatePickerFieldContentState();
}

class _DatePickerFieldContentState extends State<_DatePickerFieldContent> {
  String _selectedDateText = '';
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _selectedDateText = _selectedDate.toString().substring(0, 10);
        widget.state.didChange(_selectedDate);
        widget.onChanged(_selectedDate!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          readOnly: true,
          onTap: () => _selectDate(context),
          decoration: InputDecoration(
            labelText: widget.placeholder,
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.calendar_today),
            errorText: widget.state.errorText,
          ),
          controller: TextEditingController(text: _selectedDateText),
        ),
      ],
    );
  }
}
