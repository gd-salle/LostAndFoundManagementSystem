import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../services/item_report_api.dart';
import '../models/item.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/top_design.dart';
import '../widgets/bottom_design.dart';
import '../widgets/background_image.dart';
import '../widgets/header.dart';
import '../widgets/date_picker.dart';
import '../routes/app_routes.dart';

class FoundItemForm extends StatefulWidget {
  @override
  _FoundItemFormState createState() => _FoundItemFormState();
}

class _FoundItemFormState extends State<FoundItemForm> {
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController itemConditionController = TextEditingController();
  final TextEditingController timeFoundController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController reporterNameController = TextEditingController();
  final TextEditingController contactNoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Add this key
  final _contactNumberFormatter = MaskTextInputFormatter(mask: '09##-###-####', filter: {"#": RegExp(r'[0-9]')});

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        timeFoundController.text = picked.format(context);
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final item = Item(
        itemName: itemNameController.text,
        date: dateController.text,
        itemCondition: itemConditionController.text,
        time: timeFoundController.text,
        location: locationController.text,
        reporterName: reporterNameController.text,
        contactNo: contactNoController.text,
        reportType: 'FOUND',
        status: 'UNCLAIMED',
      );

      ItemReportApi itemReportApi = ItemReportApi();

      try {
        bool success = await itemReportApi.reportFoundItem(item);

        if (success) {
          _showDialog('Success','Your found item report has been successfully submitted.');
          _resetForm();
        } else {
          _showDialog('Error', 'There was an error submitting your report. Please try again.');
        }
      } catch (e) {
        print('Exception during form submission: $e');
        _showDialog('Error', 'An unexpected error occurred. Please try again later.');
      }
    }
  }

  void _resetForm() {
    itemNameController.clear();
    dateController.clear();
    itemConditionController.clear();
    timeFoundController.clear();
    locationController.clear();
    reporterNameController.clear();
    contactNoController.clear();
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // void _showSnackBar(String message) {
  //   _scaffoldKey.currentState?.showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //       duration: Duration(seconds: 2),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign scaffold key here
      body: Stack(
        children: [
          BackgroundImage(),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TopDesign(),
                  Header(),
                  SizedBox(height: 20),
                  Text(
                    'REPORT FOUND ITEM FORM',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: itemNameController,
                            decoration: InputDecoration(
                              labelText: 'ITEM NAME',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter item name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          DatePickerField(
                            onChanged: (DateTime selectedDate) {
                              dateController.text = selectedDate.toString().substring(0, 10);
                            },
                            placeholder: 'DATE',
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a date';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: itemConditionController,
                            decoration: InputDecoration(
                              labelText: 'ITEM CONDITION',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter item condition';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () => _selectTime(context),
                            child: AbsorbPointer(
                              child: TextFormField(
                                controller: timeFoundController,
                                decoration: InputDecoration(
                                  labelText: 'TIME FOUND',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter time found';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: locationController,
                            decoration: InputDecoration(
                              labelText: 'LOCATION',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter location';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: reporterNameController,
                            decoration: InputDecoration(
                              labelText: 'REPORTER NAME',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter reporter name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: contactNoController,
                            decoration: InputDecoration(
                              labelText: 'CONTACT NO',
                              border: OutlineInputBorder(),
                            ),
                            inputFormatters: [_contactNumberFormatter], // Apply formatter
                            keyboardType: TextInputType.number,
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
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: _submitForm,
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
                                  Navigator.pushNamed(context, AppRoutes.home);
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
}
