import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Are you a Teacher or a School?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue), // Couleur d'arrière-plan
                foregroundColor: MaterialStateProperty.all(Colors.white), // Couleur du texte
              ),
              child: Text('Teacher'),
              onPressed: () {
                Navigator.of(context).pushNamed('/signup-teacher'); 
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue), // Couleur d'arrière-plan
                foregroundColor: MaterialStateProperty.all(Colors.white), // Couleur du texte
              ),
              child: Text('School'),
              onPressed: () {
                // Logique pour s'inscrire en tant qu'école
              },
            ),
          ],
        ),
      ),
    );
  }
}
