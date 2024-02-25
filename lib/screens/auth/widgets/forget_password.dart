import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0, 0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
        child: ElevatedButton(
            onPressed: () { 
              print('Button pressed ...');
            },
            child: Text(
              'Forgot Password',
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                color: Color(0xFF101213),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder( 
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Colors.white, 
                  width: 2,
                ),
              ),
              fixedSize: Size(230, 44), // Optional if you want to enforce size
            ),
          )
          
      ),
    );
  }
}
