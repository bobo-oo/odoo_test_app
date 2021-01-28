import 'package:flutter/material.dart';
import 'package:test_app/constants.dart';
import 'package:test_app/screens/forms/components/signin.dart';
import 'package:test_app/screens/forms/components/signup.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
        children: [
          SignInForm(),
          Container(
              child: Column(
                children: <Widget>[
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
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              )
          ),

        ],
      ),
    );

  }
}