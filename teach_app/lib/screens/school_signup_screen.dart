import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SchoolSignupScreen extends StatefulWidget {
  @override
  _SchoolSignupScreenState createState() => _SchoolSignupScreenState();
}

class _SchoolSignupScreenState extends State<SchoolSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  // Ajout d'un TextEditingController pour le type d'école
  final TextEditingController _schoolTypeController = TextEditingController();

  Future<void> submitSchoolData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/schools/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': _nameController.text,
        'location': _locationController.text,
        'school_type': _schoolTypeController.text, // Assure-toi que ces champs correspondent à ton modèle Django et serializer
      }),
    );

    if (response.statusCode == 201) {
      print('School data submitted successfully');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('School signed up successfully!')),
      );
    } else {
      print('Failed to submit school data: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign up.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('School Sign Up'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the school name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Location *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the location';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _schoolTypeController,
                decoration: InputDecoration(
                  labelText: 'School Type *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the school type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue), // Couleur d'arrière-plan
                foregroundColor: MaterialStateProperty.all(Colors.white), // Couleur du texte
                ),
                child: Text('Submit'),
                onPressed: submitSchoolData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
