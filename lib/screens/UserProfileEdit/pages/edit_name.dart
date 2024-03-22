import 'package:flutter/material.dart';
import 'package:reefood/components/appbar_widget.dart';
import 'package:reefood/model/user_profile.dart';
import 'package:reefood/services/users/userdb.dart';
import 'package:string_validator/string_validator.dart';


// This class handles the Page to edit the Name Section of the User Profile.
class EditNameFormPage extends StatefulWidget {
  UserProfile myself;
    EditNameFormPage({Key? key , required this.myself}) : super(key: key);

  @override
  EditNameFormPageState createState() {
    return EditNameFormPageState();
  }
}

class EditNameFormPageState extends State<EditNameFormPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set the initial value to the controller
    nameController.text = widget.myself.fullname;
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void updateUserValue() async {
    
    widget.myself.fullname = nameController.text;
    await UserProfileProvider().addUserToFirestore(widget.myself);
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
              width: 330,
              child: const Text(
                "What's Your Name?",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 40, 16, 0),
                  child: SizedBox(
                    height: 100,
                    width: 150,
                    child: TextFormField(
                      // Remove initialValue from TextFormField
                      // initialValue: widget.myself.fullname,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        } else if (value.length <4 || value.length >20) {
                          return 'Name must be between  4 and 2O chacacter';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'Name'),
                      controller: nameController,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 150),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 330,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async{
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        //Result result = await UserProfileProvider().updateUserProfile();
                      updateUserValue();
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
