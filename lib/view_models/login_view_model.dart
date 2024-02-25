import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> login(String email, String password) async {
    bool userExists = await checkUserExists(email);

    if (userExists) {
      print('Logging in with email: $email, password: $password');
      if (email.isNotEmpty && password.isNotEmpty) {
        await Future.delayed(Duration(seconds: 2));
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> checkUserExists(String email) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }
}
