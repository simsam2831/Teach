import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _schoolNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String _accountType = 'Teacher';
  String _selectedExperience = '0-1 years';
  final List<String> _experienceOptions = ["0-1 years", "1-3 years", "3-7 years", "7+ years"];

  Future<void> signUpUser() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Error'),
          content: Text('Passwords do not match.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        ),
      );
      return;
    }

    var signUpData = {
      'username': _usernameController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
      'account_type': _accountType,
    };

    if (_accountType == 'Teacher') {
      signUpData.addAll({
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'age': _ageController.text,
        'yearsOfExperience': _selectedExperience,
      });
    } else if (_accountType == 'School') {
      signUpData.addAll({
        'schoolName': _schoolNameController.text,
        'address': _addressController.text,
      });
    }

    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/users/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(signUpData),
    );

    if (response.statusCode == 201) {
      // Success
      Navigator.of(context).pop();
    } else {
      // Failure
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Signup Failed'),
          content: Text('Failed to sign up.'),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ToggleButtons(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Teacher', style: TextStyle(color: _accountType == 'Teacher' ? Colors.white : Colors.blue)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('School', style: TextStyle(color: _accountType == 'School' ? Colors.white : Colors.blue)),
                  ),
                ],
                isSelected: [_accountType == 'Teacher', _accountType == 'School'],
                onPressed: (int index) {
                  setState(() {
                    _accountType = index == 0 ? 'Teacher' : 'School';
                  });
                },
                color: Colors.blue,
                selectedColor: Colors.white,
                fillColor: Colors.blue,
                borderRadius: BorderRadius.circular(4),
              ),
              SizedBox(height: 24.0),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              if (_accountType == 'Teacher') ...[
                SizedBox(height: 16.0),
                TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _ageController,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16.0),
                DropdownButtonFormField(
                  value: _selectedExperience,
                  decoration: InputDecoration(
                    labelText: 'Years of Experience',
                    border: OutlineInputBorder(),
                  ),
                  items: _experienceOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedExperience = newValue!;
                    });
                  },
                ),
              ] else if (_accountType == 'School') ...[
                SizedBox(height: 16.0),
                TextField(
                  controller: _schoolNameController,
                  decoration: InputDecoration(
                    labelText: 'School Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
              SizedBox(height: 24.0),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                child: Text('Sign Up'),
                onPressed: signUpUser,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
