import 'package:cloud_firestore/cloud_firestore.dart';

class SignupViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signup(Map<String, dynamic> signupData) async {
    try {
      await _firestore.collection('users').add(signupData);
      print('Signup data saved to Firestore');
    } catch (e) {
      print('Error saving signup data: $e');
    }
  }
}
