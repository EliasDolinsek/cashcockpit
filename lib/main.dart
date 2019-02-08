import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_auth/firebase_auth.dart';

import './pages/main_page.dart';
import './pages/sign_in_option_page.dart';
import './pages/sign_in_page.dart';
import './pages/sign_up_page.dart';

void main(){
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(new CashCockpit());
  });
}

class CashCockpit extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.deepPurpleAccent
      ),
      routes: {
        "/main":(BuildContext context) => MainPage(),
        "/sign_in_options":(BuildContext context) => SignInOptionPage(),
        "/sign_in":(BuildContext context) => SignInPage(),
        "/sign_up":(BuildContext context) => SignUpPage(),
      },
      home: MainPage(),
    );
  }
}
