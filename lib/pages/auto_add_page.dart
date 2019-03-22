import 'package:cash_cockpit/core/autoadd.dart';
import 'package:cash_cockpit/core/data/data_provider.dart';
import 'package:flutter/material.dart';

class AutoAddPage extends StatefulWidget {

  final DataProvider dataProvider;
  AutoAdd autoAdd;
  final bool editMode;

  AutoAddPage(this.autoAdd, this.editMode, this.dataProvider);

  @override
  State<StatefulWidget> createState() {
    return _AutoAddPageState();
  }

}

class _AutoAddPageState extends State<AutoAddPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("AutoAddPage"),
    );
  }
}