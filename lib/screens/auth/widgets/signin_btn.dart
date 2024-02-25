import 'package:flutter/material.dart';
import 'package:reefood/constant/colors.dart';

class SignInBtn extends StatelessWidget {
  const SignInBtn({
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
            'Sign In',  
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          style: ElevatedButton.styleFrom(
          backgroundColor:scheme.primary, 
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ), 
            fixedSize: Size(230, 52), 
          ),
        )
          
      ),
    );
  }
}
