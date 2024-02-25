import 'package:flutter/material.dart';

class PasswordModel {
  final TextEditingController passwordController;
  final FocusNode passwordFocusNode;
  bool passwordVisibility;

  // Constructor to initialize
  PasswordModel({
    required this.passwordController,
    required this.passwordFocusNode,
    this.passwordVisibility = false, // Initially hidden
  });

  // Example validator function (you'll need your specific logic here)
  String? passwordControllerValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 8) { 
      return 'Password must be at least 8 characters';
    }
    return null; // Indicates valid input
  }
}
