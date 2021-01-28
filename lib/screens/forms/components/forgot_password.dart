import 'package:flutter/material.dart';
import 'package:test_app/constants.dart';
import 'package:test_app/models/User.dart';
import 'package:test_app/screens/forms/components/form_fields.dart';
import 'package:test_app/screens/forms/components/signup.dart';

class ForgetPasswordForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final User user = User();
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(fontSize: 20),
                      )),
                  MyTextFormField(
                    hintText: 'Email',
                    type: TextInputType.emailAddress,
                    // validator: (String value) {
                    //   if (!validator.isEmail(value)) {
                    //     return 'Please enter a valid email';
                    //   }
                    //   return null;
                    // },
                    onSaved: (String value) {
                      user.email = value;
                    },
                  ),
                  RaisedButton(
                    color: kPrimaryColor,
                    onPressed: () async {

                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        user.fotgetPassword();
                      }
                    },
                    child: Text(
                      'Reset Password',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  FlatButton(
                    textColor: kPrimaryColor,
                    child: Text(
                      'Don\'t have account?',
                    ),
                    onPressed: () {
                      return Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpForm(),
                        ),
                      );
                      //signup screen
                    },
                  ),
                  FlatButton(
                    textColor: kPrimaryColor,
                    child: Text(
                      'Already have an account?',
                    ),
                    onPressed: () {
                      return Navigator.pop(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpForm(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    ));
  }
}