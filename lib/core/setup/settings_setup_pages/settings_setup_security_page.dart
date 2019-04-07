import 'package:cash_cockpit/core/data/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class SettingsSetupSecurityPage extends StatelessWidget {
  final DataProvider _dataProvider;

  SettingsSetupSecurityPage(this._dataProvider);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SECURITY",
              style: TextStyle(fontSize: 48),
            ),
            Text(
              "Setup your prefered security settings",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            SizedBox(
              height: 32.0,
            ),
            Expanded(
              child: _PasswordSettings(_dataProvider),
            ),
            SizedBox(
              height: 32.0,
            ),
          ],
        ),
      ),
    );
  }
}

class _PasswordSettings extends StatefulWidget {
  final DataProvider dataProvider;

  _PasswordSettings(this.dataProvider);

  @override
  State<StatefulWidget> createState() {
    return _PasswordSettingsState();
  }
}

class _PasswordSettingsState extends State<_PasswordSettings> {
  bool _pinEntered = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              CheckboxListTile(
                value: widget.dataProvider.settings.pinRequiredForLogin,
                onChanged: (value) {
                  setState(() {
                    _setPinRequiredForLogin(value);
                  });
                },
                title: Text("Pin required for login"),
                subtitle: Text(
                    "To protecct your data from other persons you can set a pin"),
              ),
              SizedBox(
                height: 32.0,
              ),
              Visibility(
                visible: widget.dataProvider.settings.pinRequiredForLogin,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Pin for login",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    PinCodeTextField(
                      isCupertino: false,
                      hasTextBorderColor: Theme.of(context).primaryColor,
                      onTextChanged: (value) {
                        _setPinForLogin(int.parse(value));
                        setState(() {
                          _pinEntered = value.length >= 4;
                        });
                      },
                      maxLength: 4,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("BACK"),
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.white,
            ),
            SizedBox(
              width: 8.0,
            ),
            RaisedButton(
              child: Text(
                "FINISH",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: _pinEntered || !widget.dataProvider.settings.pinRequiredForLogin
                  ? () {
                      Navigator.pushReplacementNamed(context, "/main");
                    }
                  : null,
              color: Theme.of(context).primaryColor,
            )
          ],
        )
      ],
    );
  }

  void _setPinRequiredForLogin(bool pinRequiredForLogin) {
    var settings = widget.dataProvider.settings;
    settings.pinRequiredForLogin = pinRequiredForLogin;
    widget.dataProvider.changeSettings(settings);
  }

  void _setPinForLogin(int pin) {
    var settings = widget.dataProvider.settings;
    settings.pin = pin;
    widget.dataProvider.changeSettings(settings);
  }
}
