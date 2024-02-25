import 'package:flutter/material.dart';
import '../view_models/signup_view_model.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final SignupViewModel _signupViewModel = SignupViewModel();

  bool _passwordVisible = false;

  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 30),
              Text(
                'Create an Tokri Account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          labelText: 'Address',
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _phoneNumberController,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _passwordController,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            // Check if any field is empty
                            if (_firstNameController.text.isEmpty ||
                                _lastNameController.text.isEmpty ||
                                _addressController.text.isEmpty ||
                                _emailController.text.isEmpty ||
                                _phoneNumberController.text.isEmpty ||
                                _passwordController.text.isEmpty) {
                              setState(() {
                                _errorMessage = 'All fields are required';
                              });
                            } else {
                              // Create a map with signup data
                              Map<String, dynamic> signupData = {
                                'firstName': _firstNameController.text,
                                'lastName': _lastNameController.text,
                                'address': _addressController.text,
                                'email': _emailController.text,
                                'phoneNumber': _phoneNumberController.text,
                                'password': _passwordController.text,
                              };

                              await _signupViewModel.signup(signupData);
                              _firstNameController.clear();
                              _lastNameController.clear();
                              _addressController.clear();
                              _emailController.clear();
                              _phoneNumberController.clear();
                              _passwordController.clear();
                              Navigator.pop(context);
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Text('Signup'),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _errorMessage,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account? "),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
