import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatelessWidget {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset('assets/images/logo.png'),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              child: Text('Login'),
              onPressed: () async {
                // URL de l'endpoint d'authentification
                final url = Uri.parse('http://127.0.0.1:8000/api/token/');

                // Envoie une requête POST à l'endpoint
                final response = await http.post(
                  url,
                  headers: {'Content-Type': 'application/json'},
                  body: json.encode({
                    'username': _emailController.text,
                    'password': _passwordController.text,
                  }),
                );

                if (response.statusCode == 200) {
                  // Si la connexion réussit, naviguer vers une nouvelle page ou faire quelque chose d'autre
                  print('Connexion réussie');
                  Navigator.of(context).pushReplacementNamed('/home'); // Assure-toi d'avoir une route '/home'
                } else {
                  // Si la connexion échoue, afficher une erreur
                  print('Échec de la connexion');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Échec de la connexion')),
                  );
                }
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Text color
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), // Background color
              ),
            ),

            TextButton(
              child: Text("Sign up"),
              onPressed: () {
                Navigator.of(context).pushNamed('/signup'); 
              },
            ),
          ],
        ),
      ),
    );
  }
}
