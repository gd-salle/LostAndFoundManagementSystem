import 'package:flutter/material.dart';
import '../widgets/top_design.dart';
import '../widgets/bottom_design.dart';
import '../widgets/background_image.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/header.dart';
import '../services/claim_report_api.dart';
import '../models/claim_report.dart';
import '../models/item.dart';
import '../widgets/date_picker.dart';
import '../widgets/year_level_dropdown.dart';
import '../widgets/department_dropdown.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../routes/app_routes.dart';

class TurnOverForm extends StatefulWidget {
  final Item item;

  TurnOverForm({required this.item});

  @override
  _TurnOverFormState createState() => _TurnOverFormState();
}

class _TurnOverFormState extends State<TurnOverForm> {
  final _formKey = GlobalKey<FormState>();

  String recipientName = '';
  DateTime? date;
  String contactNo = '';
  String yearLevel = '1st Year';
  String department = 'Arts & Sciences';
  String address = '';

  // Input formatter for contact number
  final _contactNumberFormatter = MaskTextInputFormatter(mask: '09##-###-####', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundImage(),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TopDesign(),
                  Header(),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'CLAIM ITEM FORM',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 20),
                          _buildTextFormField('RECIPIENT NAME', (value) => recipientName = value),
                          _buildDatePickerField(),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'CONTACT NO',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [_contactNumberFormatter],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your contact number';
                              }

                              // Define the pattern that matches the mask '09##-###-####'
                              final RegExp _phoneNumberRegExp = RegExp(r'^[0-9]{2}[0-9]{2}-[0-9]{3}-[0-9]{4}$');

                              // Check if the value matches the pattern
                              if (!_phoneNumberRegExp.hasMatch(value)) {
                                return 'Please enter a valid contact number (09XX-XXX-YYYY)';
                              }

                              return null;
                            },
                            onSaved: (value) => contactNo = value!,
                          ),
                          SizedBox(height: 10),
                          YearLevelDropdown(
                            yearLevels: yearLevelsList,
                            selectedItem: yearLevel,
                            onChanged: (value) {
                              setState(() {
                                yearLevel = value!;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select YEAR LEVEL';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          DepartmentDropdown(
                            departments: departmentsList,
                            selectedItem: department,
                            onChanged: (value) {
                              setState(() {
                                department = value!;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select DEPARTMENT';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          _buildTextFormField('ADDRESS', (value) => address = value),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    _submitForm();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                ),
                                child: Text(
                                  'SUBMIT',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context); // Cancels and pops the current route
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  backgroundColor: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                ),
                                child: Text(
                                  'CANCEL',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  BottomDesign(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField(String label, Function(String) onSaved) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
        onSaved: (value) => onSaved(value!),
      ),
    );
  }

  Widget _buildDatePickerField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: DatePickerField(
        placeholder: 'DATE',
        onChanged: (selectedDate) {
          date = selectedDate;
        },
        validator: (value) {
          if (value == null) {
            return 'Please select a date';
          }
          return null;
        },
      ),
    );
  }

void _submitForm() async {
  if (date == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please select a date')),
    );
    return;
  }

  ClaimReport claimReport = ClaimReport(
    recipientName: recipientName,
    date: date!.toIso8601String(),
    contactNo: contactNo,
    yearLevel: yearLevel,
    department: department,
    address: address,
    itemReportId: widget.item.id,
  );

  bool success = await ClaimReportApi().submitClaimReport(claimReport);

  if (success) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success!'),
          content: Text('Claim report submitted successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushNamed(context, AppRoutes.announcementReports); // Navigate back to the previous screen
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to submit claim report.')),
    );
  }
}

}
