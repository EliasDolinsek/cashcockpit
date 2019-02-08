import 'package:flutter/material.dart';
import '../tools/auth.dart';

class SignInOptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 48.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 32.0,
            ),
            Text(
              "CashCockpit",
              style: TextStyle(fontFamily: "Roboto", fontSize: 48.0),
              textAlign: TextAlign.center,
            ),
            Text(
              "by Donlinsek App",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: "Roboto"),
            ),
            Expanded(
              child: Container(),
            ),
            Text(
              "If you already have an CashCockpit Account you can…",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontFamily: "Roboto-Black"),
            ),
            SizedBox(
              height: 8,
            ),
            RaisedButton(
              child: Text("SIGN IN"),
              onPressed: () {
                Navigator.of(context).pushNamed("/sign_in");
              },
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
            ),
            SizedBox(
              height: 56.0,
            ),
            Text(
              "…if not and you want to use all features…",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontFamily: "Roboto-Black"),
            ),
            SizedBox(
              height: 8,
            ),
            RaisedButton(
              child: Text("SIGN UP"),
              onPressed: () {
                Navigator.of(context).pushNamed("/sign_up");
              },
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
            ),
            SizedBox(
              height: 56.0,
            ),
            Text(
              "…or just…",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontFamily: "Roboto-Black"),
            ),
            MaterialButton(
              child: Text("CONTINUE ANONYMOUSLY"),
              onPressed: () {
                _showConfirmContinueAnonymouslyDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmContinueAnonymouslyDialog(BuildContext context){
    showDialog(context: context, builder: (BuildContext context) => AlertDialog(title: Text("Continue Anonymously"), content: Text("You won't be able to use some features if you continue anonymously!"),actions: <Widget>[
      MaterialButton(
        child: Text("Cancel"),
        onPressed: () => Navigator.pop(context),
      ),
      MaterialButton(
        child: Text("Continue Anonymously"),
        onPressed: (){
          Auth().signInAnonymously().whenComplete((){
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, "/main");
          });
        },
      )
    ],));
  }
}
