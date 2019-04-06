import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/sing_up_toolbox.dart';

import '../../tools/auth.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: _SignInInputs(),
      ),
    );
  }
}

class _SignInInputs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignInInputsState();
  }
}

class _SignInInputsState extends State<_SignInInputs> {
  final _key = GlobalKey<FormState>();
  String _email, _password;
  String _errorMessage;
  bool _signInProcessActive = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: ListView(
        children: <Widget>[
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "E-Mail"),
            validator: (value) {
              if (!RegExp(
                      "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$")
                  .hasMatch(value)) {
                return "Enter a valid E-Mail address";
              }
            },
            onSaved: (value) {
              _email = value;
            },
          ),
          SizedBox(
            height: 16,
          ),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.text,
            obscureText: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: "Password"),
            onSaved: (value) {
              _password = value;
            },
          ),
          Visibility(
            visible: _errorMessage != null,
            maintainSize: false,
            child: Padding(
              padding: EdgeInsets.only(top: 16, bottom: 8),
              child: Text(
                _errorMessage == null ? "" : _errorMessage,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          RaisedButton(
            child: Text("SIGN IN"),
            onPressed: _signInProcessActive
                ? null
                : () {
                    if (_key.currentState.validate()) {
                      _key.currentState.save();
                      _signInUser();
                      setState(() {
                        _signInProcessActive = true;
                      });
                    }
                  },
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
          ),
          MaterialButton(
            child: Text("RESET PASSWORD"),
            onPressed: () {
              if (_key.currentState.validate()) {
                _key.currentState.save();
                FirebaseAuth.instance
                    .sendPasswordResetEmail(email: _email)
                    .whenComplete(() {
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("Password reset email got send")));
                });
              }
            },
          )
        ],
      ),
    );
  }

  void _signInUser() async {
    try {
      await Auth().signInUser(_email, _password);
      Navigator.pushReplacementNamed(context, "/main");
    } catch (e) {
      if (e is PlatformException) {
        setState(() {
          _errorMessage = SignUpToolbox.getErrorMessageOfErrorCode(e.code);
          _signInProcessActive = false;
        });
      }
    }
  }
}
