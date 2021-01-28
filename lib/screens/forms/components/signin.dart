import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/constants.dart';
import 'package:test_app/models/User.dart';
import 'package:test_app/screens/forms/components/form_fields.dart';
import 'package:test_app/screens/home/components/home_screen.dart';
import 'package:validators/validators.dart' as validator;

class SignInForm extends StatelessWidget {
  // final User user = new User();
  final _signInFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String password, email;
    final user = Provider.of<User>(context);
    return Container(
      margin: EdgeInsets.only(top: 100),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Text(
              'Shop App',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            )
          ),
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                'Sign in',
                style: TextStyle(fontSize: 20),
              )),
          Container(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _signInFormKey,
              child: Column(
                children: <Widget>[
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
                    onSaved: (String value) {
                      password = value;
                    },
                  ),
                  Container(
                      height: 50,
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: kPrimaryColor,
                        child: Text('Sign In'),
                        onPressed: () async {
                          if (_signInFormKey.currentState.validate()) {
                            _signInFormKey.currentState.save();
                            // login(usernameController.text, passwordController.text);
                            // print(response);
                            // user.login(user.email,user.password);
                            var response = await user.login(email, password);
                            print(response);
                            // print(response);
                            if(response['status'] == 1) {
                              return Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                return HomeScreen();
                              }));
                            }
                            else {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Sign In error!!!'),
                                  content: Text('Enter username or password is incorrect'),
                                  actions: <Widget>[
                                    FlatButton(
                                        onPressed: () => Navigator.of(context).pop(false),//  We can return any object from here
                                        child: Text('Okay')),
                                  ],
                                ),
                              );
                            }
                          }
                        },
                      )
                  ),

                ],
              ),
            ),
          ),
          // FlatButton(
          //   onPressed: (){
          //     return Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => ForgetPasswordForm(),
          //       ),
          //     );
          //     //forgot password screen
          //   },
          //   textColor: kPrimaryColor,
          //   child: Text('Forgot Password'),
          // ),

          ],
        )
    );
  }
}