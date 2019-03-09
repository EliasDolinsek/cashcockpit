import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import '../settings/settings.dart';

class Currency {
  static const USD = Currency(
      isoCode: "USD",
      currencySymbolAlignment: CurrencySymbolAlignment.LEFT,
      currencySymbol: "\$");
  static const EUR = Currency(
      isoCode: "EUR",
      currencySymbolAlignment: CurrencySymbolAlignment.RIGHT,
      currencySymbol: "€");
  static const JPY = Currency(
      isoCode: "JPY",
      currencySymbolAlignment: CurrencySymbolAlignment.LEFT,
      currencySymbol: "¥");

  final String isoCode, currencySymbol;
  final CurrencySymbolAlignment currencySymbolAlignment;

  const Currency(
      {this.isoCode, this.currencySymbol, this.currencySymbolAlignment});
}

class CurrencyFormatter {
  static TextEditingController getCurrencyTextController(Settings s,
      {String text = ""}) {
    var alignCurrencySymbolRight =
        s.currency.currencySymbolAlignment == CurrencySymbolAlignment.RIGHT;
    var currencySymbol = s.currency.currencySymbol;
    return MoneyMaskedTextController(
        initialValue: double.parse(text),
        decimalSeparator: Settings.getCentSeparator(s),
        thousandSeparator: Settings.getThousandSeparator(s),
        rightSymbol: alignCurrencySymbolRight ? currencySymbol : "",
        leftSymbol: !alignCurrencySymbolRight ? currencySymbol : "");
  }
}

enum CurrencySymbolAlignment { LEFT, RIGHT }
