import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TermAndCondition extends StatelessWidget {
  const TermAndCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          side: BorderSide(
            color: Colors.green,
            width: 1.5,
          ),
          value: true,
          checkColor: Colors.white,
          activeColor: Colors.green,
          onChanged: (value) {},
        ),
        const SizedBox(width: 8),
        TermText()
        
      ],
    );
  }
}

class TermText extends StatelessWidget {
  const TermText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: 'I agree to the ',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black, // Customize as needed
            ),
            children: [
          TextSpan(
            text: 'Terms',
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Handle 'Terms' link click
                // You can navigate to a page or open a link
              },
          ),
          TextSpan(
            text: ' and the ',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black, // Customize as needed
            ),
          ),
          TextSpan(
            text: 'Conditions',
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Handle 'Conditions' link click
                // You can navigate to a page or open a link
              },
          )
        ]));
  }
}
