import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TeacherSignupScreen extends StatefulWidget {
  @override
  _TeacherSignupScreenState createState() => _TeacherSignupScreenState();
}

class _TeacherSignupScreenState extends State<TeacherSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _hourlyRateController = TextEditingController();
  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'US'); // IsoCode par défaut pour l'exemple


  // Une liste des options d'expérience
  final List<String> _experienceOptions = [
    "0-1 years", "1-3 years", "3-7 years", "7+ years"
  ];

  String? _selectedExperience;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _phoneNumberController.dispose();
    _hourlyRateController.dispose();
    super.dispose();
  }

  Future<void> submitTeacherData(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/professors/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'first_name': _firstNameController.text,
        'last_name': _lastNameController.text,
        'age': int.tryParse(_ageController.text),  // Assure-toi que cela ne renvoie pas null
        'years_of_experience': _selectedExperience,
        'phone_number': _phoneNumber.phoneNumber,  // Vérifie la manière dont tu accèdes à cette valeur
        'hourly_rate': double.tryParse(_hourlyRateController.text),
      }),
    );

    if (response.statusCode == 201) {
      // Handle success
      print('Teacher data submitted successfully');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Teacher signed up successfully!')),
      );
    } else {
      // Handle failure
      print('Failed to submit teacher data: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign up.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Sign Up'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _firstNameController, // Ajoute ceci
                decoration: InputDecoration(
                  labelText: 'First Name *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(
                  labelText: 'Age *',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Years of Experience *',
                  border: OutlineInputBorder(),
                ),
                items: _experienceOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedExperience = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your years of experience';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  _phoneNumber = number;
                },
                selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.DROPDOWN,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: TextStyle(color: Colors.black),
                initialValue: _phoneNumber,
                textFieldController: _phoneNumberController,
                formatInput: false,
                keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                inputBorder: OutlineInputBorder(),
                onSaved: (PhoneNumber number) {
                  _phoneNumber = number;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _hourlyRateController,
                decoration: InputDecoration(
                  labelText: 'Hourly Rate (optional)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue), // Couleur d'arrière-plan
                foregroundColor: MaterialStateProperty.all(Colors.white), // Couleur du texte
                ),
                child: Text('Submit'),
                onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Processing Data')),
                  );
                  await submitTeacherData(context); // Assure-toi que cette fonction accepte `context`
                }
              },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
