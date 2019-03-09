import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../layouts/database_layout.dart';

import '../core/data/data_provider.dart';

class MainPage extends StatefulWidget {

  final DataProvider dataProvider;

  MainPage(this.dataProvider);

  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {

  int _currentIndex = 0;

  List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _children = [
      Text("Cockpit"),
      Text("History"),
      Text("Statistics"),
      DatabaseLayout(widget.dataProvider),
      Text("Settings"),
    ];
  }

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
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              'Cockpit',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('History',
                style: TextStyle(color: Theme.of(context).primaryColor)),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.trending_up,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('Statistics',
                style: TextStyle(color: Theme.of(context).primaryColor)),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.data_usage,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('Database',
                style: TextStyle(color: Theme.of(context).primaryColor)),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('Settings',
                style: TextStyle(color: Theme.of(context).primaryColor)),
          ),
        ],
      ),
    );
  }
}
