import 'package:cash_cockpit/core/currency/currency.dart';
import 'package:cash_cockpit/core/data/data_provider.dart';
import 'package:cash_cockpit/core/settings/settings.dart';
import 'package:cash_cockpit/core/setup/settings_setup_pages/settings_setup_data_management.dart';
import 'package:cash_cockpit/core/setup/settings_setup_pages/settings_setup_security_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsSetupCurrencyPage extends StatelessWidget {
  final DataProvider _dataProvider;

  SettingsSetupCurrencyPage(this._dataProvider);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 64),
        child: Column(
          children: <Widget>[
            Text(
              "CURRENCY",
              style: TextStyle(fontSize: 48),
            ),
            Text(
              "Select your prefered currency",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            SizedBox(
              height: 32.0,
            ),
            Expanded(
              child: _CurrencyAndFormattingSelection(_dataProvider),
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
                    "NEXT",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _showNextPage(context);
                  },
                  color: Theme.of(context).primaryColor,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showNextPage(BuildContext context) async {
    var user = await FirebaseAuth.instance.currentUser();
    if (user.isAnonymous) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsSetupSecurityPage(_dataProvider)));
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SettingsSetupDataManagement(_dataProvider),
        ),
      );
    }
  }
}

class _CurrencyAndFormattingSelection extends StatefulWidget {
  final DataProvider dataProvider;

  _CurrencyAndFormattingSelection(this.dataProvider);

  @override
  State<StatefulWidget> createState() {
    return _CurrencyAndFormattingSelectionState();
  }
}

class _CurrencyAndFormattingSelectionState
    extends State<_CurrencyAndFormattingSelection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          _getCurrencyExampleText(),
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 32.0,
        ),
        Wrap(
            spacing: 16,
            children: Currency.getDefaultCurrencies()
                .map((c) => _getChoiceChipOfCurrency(c))
                .toList()),
        SizedBox(
          height: 32.0,
        ),
        Text(
          "Select your prefered currency formation",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        SizedBox(
          height: 32.0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("Thousand separation: "),
                  _getThousandSeparationChips()
                ],
              ),
              SizedBox(
                height: 24.0,
              ),
              Column(
                children: <Widget>[
                  Text("Decimal separation: "),
                  _getCentSeparationChips()
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _getChoiceChipOfCurrency(Currency c) => ChoiceChip(
        selectedColor: Theme.of(context).primaryColor,
        label: Text(
          c.isoCode,
          style: TextStyle(color: _getTextColorForCurrencyChip(c)),
        ),
        selected: _isCurrencySelected(c.isoCode),
        onSelected: (value) {
          if (value) {
            setState(() {
              var settings = widget.dataProvider.settings;
              settings.currencyISOCode = c.isoCode;

              widget.dataProvider.changeSettings(settings);
            });
          }
        },
      );

  Widget _getThousandSeparationChips() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ChoiceChip(
            label: Text(
              "COMMA",
              style: TextStyle(
                  color: widget.dataProvider.settings.thousandSeparatorSymbol ==
                          Settings.SEPARATOR_COMMA
                      ? Colors.white
                      : Colors.black),
            ),
            selected: _isThousandSeparatorComma(),
            selectedColor: Theme.of(context).primaryColor,
            onSelected: (value) {
              _setThousandSeparator(value, true);
            },
          ),
          SizedBox(
            width: 8.0,
          ),
          ChoiceChip(
            label: Text(
              "POINT",
              style: TextStyle(
                  color: widget.dataProvider.settings.thousandSeparatorSymbol ==
                          Settings.SEPARATOR_POINT
                      ? Colors.white
                      : Colors.black),
            ),
            selected: !_isThousandSeparatorComma(),
            selectedColor: Theme.of(context).primaryColor,
            onSelected: (value) {
              _setThousandSeparator(value, false);
            },
          ),
        ],
      );

  Widget _getCentSeparationChips() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ChoiceChip(
            label: Text(
              "COMMA",
              style: TextStyle(
                  color: widget.dataProvider.settings.centSeparatorSymbol ==
                          Settings.SEPARATOR_COMMA
                      ? Colors.white
                      : Colors.black),
            ),
            selected: _isCentSeparatorComma(),
            selectedColor: Theme.of(context).primaryColor,
            onSelected: (value) {
              _setCentSeparator(value, true);
            },
          ),
          SizedBox(
            width: 8.0,
          ),
          ChoiceChip(
            label: Text(
              "POINT",
              style: TextStyle(
                  color: widget.dataProvider.settings.centSeparatorSymbol ==
                          Settings.SEPARATOR_POINT
                      ? Colors.white
                      : Colors.black),
            ),
            selected: !_isCentSeparatorComma(),
            selectedColor: Theme.of(context).primaryColor,
            onSelected: (value) {
              _setCentSeparator(value, false);
            },
          ),
        ],
      );

  Color _getTextColorForCurrencyChip(Currency c) =>
      _isCurrencySelected(c.isoCode) ? Colors.white : Colors.black;

  bool _isCurrencySelected(String currencyISOCode) =>
      widget.dataProvider.settings.currencyISOCode == currencyISOCode;

  String _getCurrencyExampleText() =>
      "Example: ${CurrencyFormatter.formatAmount(1234.56, widget.dataProvider.settings)}";

  bool _isThousandSeparatorComma() =>
      widget.dataProvider.settings.thousandSeparatorSymbol ==
      Settings.SEPARATOR_COMMA;

  bool _isCentSeparatorComma() =>
      widget.dataProvider.settings.centSeparatorSymbol ==
      Settings.SEPARATOR_COMMA;

  void _setThousandSeparator(bool value, bool isChipCommaChip) {
    var settings = widget.dataProvider.settings;

    if (isChipCommaChip) {
      setState(() {
        settings.thousandSeparatorSymbol =
            value ? Settings.SEPARATOR_COMMA : Settings.SEPARATOR_POINT;
      });
    } else {
      setState(() {
        settings.thousandSeparatorSymbol =
            value ? Settings.SEPARATOR_POINT : Settings.SEPARATOR_COMMA;
      });
    }

    widget.dataProvider.changeSettings(settings);
  }

  void _setCentSeparator(bool value, bool isChipCommaChip) {
    var settings = widget.dataProvider.settings;

    if (isChipCommaChip) {
      setState(() {
        settings.centSeparatorSymbol =
            value ? Settings.SEPARATOR_COMMA : Settings.SEPARATOR_POINT;
      });
    } else {
      setState(() {
        settings.centSeparatorSymbol =
            value ? Settings.SEPARATOR_POINT : Settings.SEPARATOR_COMMA;
      });
    }

    widget.dataProvider.changeSettings(settings);
  }
}
