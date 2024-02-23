import 'package:flutter/material.dart';
import 'package:tokri_sem_three/view/splash_screen.dart';

void main() {
  runApp(TokriApp());
}

class TokriApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tokri App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Use SplashScreen as the initial route
      debugShowCheckedModeBanner: false, // Set to false to remove the debug banner
    );
  }
}
