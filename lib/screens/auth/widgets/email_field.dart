import 'package:flutter/material.dart';
import 'package:reefood/constant/colors.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController? controller;
  const EmailTextField({super.key, required this.controller});
  String? _validateEmail(String? value) {
    // Check if the email is empty
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }

    // Check if the email is in a valid format
    String emailRegex =
        r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-zA-Z]{2,})$';
    RegExp regex = RegExp(emailRegex);

    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    // Return null if the email is valid
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
        child: SizedBox(
          width: double.infinity,
          child: TextFormField(
            controller: controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return 'Enter a valid email';
              }
              return null;
            },

            autofocus: true,
            autofillHints: const [AutofillHints.email],
            keyboardType: TextInputType.emailAddress, // Standard keyboard type
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              color: Color(0xFF101213),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: const TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                color: Color(0xFF57636C),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFE0E3E7),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: scheme.primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFFF5963),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFFF5963),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.all(24),
            ),
          ),
        ));
  }
}
