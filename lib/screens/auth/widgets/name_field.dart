import 'package:flutter/material.dart';
import 'package:reefood/constant/colors.dart';

class NameField extends StatelessWidget {
  final TextEditingController? controller;
  const NameField({
    super.key,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
      child:
      SizedBox(
          width: double.infinity,
          child: TextFormField( 
            controller: controller,

          autofocus: true,
          autofillHints:const [AutofillHints.name],
          keyboardType: TextInputType.text,  
          style:const TextStyle( 
            fontFamily: 'Plus Jakarta Sans',
            color: Color(0xFF101213), 
                        fontSize: 14, 
        fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
          labelText: 'Full Name',
          labelStyle:const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            color: Color(0xFF57636C), 
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:const BorderSide(
              color: Color(0xFFE0E3E7),
              width: 2,
            ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:scheme.primary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide:const BorderSide(
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
          )
          
    );
  }
}
