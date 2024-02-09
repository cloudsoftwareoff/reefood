import 'package:flutter/material.dart';
import 'package:reefood/components/appbar_widget.dart';

class EditDescriptionFormPage extends StatefulWidget {
  final String initialBio;

  EditDescriptionFormPage({required this.initialBio});

  @override
  _EditDescriptionFormPageState createState() =>
      _EditDescriptionFormPageState();
}

class _EditDescriptionFormPageState extends State<EditDescriptionFormPage> {
  final _formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    descriptionController.text = widget.initialBio;
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  void updateUserValue(String description) {
   // user.aboutMeDescription = description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
  height: 250,
  width: 350,
  child: TextFormField(
    controller: descriptionController, // Updated line, remove initialValue
    validator: (value) {
      if (value == null || value.isEmpty || value.length > 200) {
        return 'Please describe yourself but keep it under 200 characters.';
      }
      return null;
    },
    textAlignVertical: TextAlignVertical.top,
    decoration: const InputDecoration(
      alignLabelWithHint: true,
      contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 100),
      hintMaxLines: 3,
      hintText:
          'Write a little bit about yourself. Do you like chatting? Are you a smoker? Do you bring pets with you? Etc.',
    ),
  ),
),

            
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 350,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        updateUserValue(descriptionController.text);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
