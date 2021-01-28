import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/constants.dart';
import 'package:test_app/models/User.dart';
import 'package:test_app/screens/forms/components/form_fields.dart';
import 'package:test_app/screens/forms/components/main_screen.dart';
import 'package:validators/validators.dart' as validator;

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _signUpFormKey = GlobalKey<FormState>();
  // final User user = User();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String username, password, email;
    final user = Provider.of<User>(context);

    // final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 100),
          child: Form(
            key: _signUpFormKey,
            child: Column(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Registration Form',
                      style: TextStyle(fontSize: 20),
                    )),
                MyTextFormField(
                  hintText: 'Full Name',
                  type: TextInputType.text,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Enter your full name';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    username = value;
                    // user.name = value;
                  },
                ),
                MyTextFormField(
                  hintText: 'Email',
                  type: TextInputType.emailAddress,
                  validator: (String value) {
                    if (!validator.isEmail(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    email = value;
                  },
                ),

                MyTextFormField(
                  hintText: 'Password',
                  isPassword: true,
                  type: TextInputType.text,
                  validator: (String value) {
                    if (value.length < 7) {
                      return 'Password should be minimum 7 characters';
                    }
                    _signUpFormKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    password = value;
                  },
                ),

                MyTextFormField(
                  hintText: 'Confirm Password',
                  isPassword: true,
                  type: TextInputType.text,
                  validator: (String value) {
                    if (value.length < 7) {
                      return 'Password should be minimum 7 characters';
                    } else if (password != null && value != password) {
                      return 'Password not matched';
                    }
                    return null;
                  },
                ),
                RaisedButton(
                  color: kPrimaryColor,
                  onPressed: () async {
                    if (_signUpFormKey.currentState.validate()) {
                      _signUpFormKey.currentState.save();
                      var response = await user.createUser(username, email, password);
                      if (response['status'] == 0) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Registration error!!!'),
                              content: Text(response['message']),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () => Navigator.of(context).pop(false),//  We can return any object from here
                                    child: Text('Okay')),
                              ],
                            ));
                      }
                      else {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Registration success!!!'),
                              content: Text(response['message']),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () => Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (BuildContext context) => MainScreen()),
                                      ModalRoute.withName('/signin'),
                                    ),//  We can return any object from here
                                    child: Text('Okay')),
                              ],
                            )
                        );
                      }
                    }
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}