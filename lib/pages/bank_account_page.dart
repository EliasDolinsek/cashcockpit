import 'package:flutter/material.dart';

import '../core/data/data_provider.dart';
import '../core/bank_account.dart';

class BankAccountPage extends StatefulWidget {
  final DataProvider dataProvider;
  BankAccount bankAccount;
  final bool editMode;

  BankAccountPage(this.bankAccount, this.editMode, this.dataProvider);

  @override
  State<StatefulWidget> createState() {
    return _BankAccountPageState();
  }
}

class _BankAccountPageState extends State<BankAccountPage> {
  final _key = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _name;
  double _balance;

  TextEditingController _nameController;
  TextEditingController _balanceController;

  Function _onBankAccountChanged;
  Function _onBankAccountRemoved;

  @override
  void initState() {
    super.initState();
    _setupTextController();
    _onBankAccountChanged = (updatedBankAccount) {
      if (widget.bankAccount.id == updatedBankAccount.id) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(
                "Updated values because bank account got edited on another device")));
        setState(() {
          widget.bankAccount = updatedBankAccount;
          _setupTextController();
        });
      }
    };

    _onBankAccountRemoved = (removedBankAccount) {
      if (widget.bankAccount.id == removedBankAccount.id) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Bank account got deleted"),
                  content: Text(
                      "${widget.bankAccount.name} got deleted on another device"),
                  actions: <Widget>[
                    MaterialButton(
                      child: Text("Close"),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ));
      }
    };

    widget.dataProvider.onBankAccountChanged.add(_onBankAccountChanged);
    widget.dataProvider.onBankAccountRemoved.add(_onBankAccountRemoved);
  }

  void _setupTextController() {
    _nameController = TextEditingController(
        text: widget.editMode ? widget.bankAccount.name : "");
    _balanceController =
        TextEditingController(text: widget.bankAccount.balance.toString());
  }

  @override
  void dispose() {
    super.dispose();
    widget.dataProvider.onBankAccountChanged.remove(_onBankAccountChanged);
    widget.dataProvider.onBankAccountRemoved.remove(_onBankAccountRemoved);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(widget.bankAccount.name),
        ),
        body: Form(
          key: _key,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Name"),
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return "Please enter a name";
                    }
                  },
                  onSaved: (value) {
                    _name = value;
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _balanceController,
                  enabled: widget.bankAccount.balanceEnabled,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Balance"),
                  validator: (value) {
                    try {
                      _balance = double.parse(value);
                    } on Exception {
                      return "Please enter a valid balance";
                    }
                  },
                  onSaved: (value) {
                    _balance = double.parse(value);
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                SwitchListTile(
                  value: widget.bankAccount.balanceEnabled,
                  title: Text("Enable Goal"),
                  onChanged: (value) {
                    setState(
                      () {
                        widget.bankAccount.balanceEnabled = value;
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                ButtonBar(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        if (_key.currentState.validate()) {
                          _key.currentState.save();

                          widget.bankAccount.name = _name;
                          widget.bankAccount.balance = _balance;

                          if (widget.editMode) {
                            widget.dataProvider.onBankAccountChanged
                                .remove(_onBankAccountChanged);
                            widget.dataProvider
                                .addBankAccount(widget.bankAccount);
                          } else {
                            widget.dataProvider
                                .addBankAccount(widget.bankAccount);
                          }

                          Navigator.pop(context);
                        }
                      },
                      child: widget.editMode
                          ? Text(
                              "Save",
                              style: TextStyle(color: Colors.white),
                            )
                          : Text(
                              "Create",
                              style: TextStyle(color: Colors.white),
                            ),
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
