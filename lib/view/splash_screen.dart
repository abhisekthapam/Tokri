import 'package:flutter/material.dart';
import 'dart:async';

import 'food_menu_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      // After 5 seconds, navigate to the main page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FoodMenuPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Your splash screen content here
            Text(
              'Welcome to Tokri!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(), // Loading indicator
          ],
        ),
      ),
    );
  }
}
