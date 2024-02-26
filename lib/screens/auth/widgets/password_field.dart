import 'package:flutter/material.dart';
import 'package:reefood/constant/colors.dart';
import 'package:reefood/model/password.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController? controller;
  const PasswordField({super.key,
  required this.controller
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  late PasswordModel _model;

  @override
  void initState() {
    super.initState();
    _model = PasswordModel(
      passwordController: TextEditingController(),
      passwordFocusNode: FocusNode(),
    );
  }

  //dispose of resources:
  @override
  void dispose() {
    _model.passwordController.dispose();
    _model.passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            // For background and border
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _model.passwordFocusNode,
            autofillHints: const [AutofillHints.password],
            obscureText: !_model
                .passwordVisibility, // Assuming _model.passwordVisibility exists
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              color: Color(0xFF101213),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              labelText: 'Password',
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
                borderSide: const BorderSide(
                  color: Color(0xFFFF5963),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(24),
              suffixIcon: IconButton(
                // Visibility toggle
                icon: Icon(
                  _model.passwordVisibility
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: const Color(0xFF57636C),
                ),
                onPressed: () => setState(
                  () => _model.passwordVisibility = !_model.passwordVisibility,
                ),
              ),
            ),
            //validator: _model.passwordControllerValidator.asValidator(context), // May need adjustment
          ),
        ));
  }
}
