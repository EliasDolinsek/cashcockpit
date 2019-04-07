import 'package:cash_cockpit/core/data/data_provider.dart';
import 'package:cash_cockpit/core/settings/settings.dart';
import 'package:cash_cockpit/core/setup/settings_setup_pages/settings_setup_currency_page.dart';
import 'package:flutter/material.dart';

class SettingsSetupStartPage extends StatelessWidget {
  final DataProvider _dataProvider;

  SettingsSetupStartPage(this._dataProvider);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColorDark,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 64.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Welcome",
                style: TextStyle(color: Colors.white, fontSize: 48),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Bevore you can use CashCockpit, you have to setup some things!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  _setupSettingsInDatabase();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SettingsSetupCurrencyPage(_dataProvider)));
                },
                child: Text("START NOW"),
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _setupSettingsInDatabase() {
    if (_dataProvider.settings == null) {
      _dataProvider.setSettings(Settings(
          saveImageLocallyOnly: true,
          centSeparatorSymbol: Settings.SEPARATOR_POINT,
          thousandSeparatorSymbol: Settings.SEPARATOR_COMMA,
          pin: 0000,
          currencyISOCode: "USD",
          pinRequiredForLogin: false,
          saveDataOnFirebase: false));
    }
  }
}
