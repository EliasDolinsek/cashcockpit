import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../core/data/data_provider.dart';

class MainPage extends StatelessWidget {
  final DataProvider dataProvider = DataProvider();

  void _showSignInOptionsPageIfUserIsNotAuthenticated(
      BuildContext context) async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();

    if (user == null) {
      Navigator.pushReplacementNamed(context, "/sign_in_options");
    } else {
      print("Signed in as ${user.email}");
    }
  }

  @override
  Widget build(BuildContext context) {
    _showSignInOptionsPageIfUserIsNotAuthenticated(context);

    return Scaffold(
      body: Text("MainPage"),
    );
  }
}
