import 'package:flutter/material.dart';

class WelcomeNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.ac_unit, // Replace this with your app's icon
              size: 100.0,
              color: Colors.blue,
            ),
            SizedBox(height: 20.0),
            Text(
              'Welcome to My App', // Replace this with your app's name or description
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in lorem eget mauris pharetra lobortis sit amet et elit.',
              style: TextStyle(
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to the next screen
              },
              child: Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
