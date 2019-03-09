import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

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
      {String text = "0.0"}) {
    var alignCurrencySymbolRight =
        s.currency.currencySymbolAlignment == CurrencySymbolAlignment.RIGHT;

    var currencySymbol = s.currency.currencySymbol;

    return MoneyMaskedTextController(
        initialValue: double.parse(text),
        decimalSeparator: s.centSeparator,
        thousandSeparator: s.thousandSeparator,
        rightSymbol: alignCurrencySymbolRight ? currencySymbol : "",
        leftSymbol: !alignCurrencySymbolRight ? currencySymbol : "");
  }

  static double getAmountInputAsDouble(String input, Settings s) {
    var resultString = input;

    resultString = resultString.replaceAll(s.thousandSeparator, "");
    resultString = resultString.replaceAll(s.currency.currencySymbol, "");

    if(s.centSeparatorSymbol == Settings.SEPARATOR_COMMA){
      resultString = resultString.replaceAll(s.centSeparator, ".");
    }

    return double.parse(resultString);
  }

  static String formatAmount(double amount, Settings s) {
    var formatterOutput = FlutterMoneyFormatter(
        amount: amount,
        settings: MoneyFormatterSettings(
            thousandSeparator: s.thousandSeparator,
            decimalSeparator: s.centSeparator,
          symbol: s.currency.currencySymbol
        )).output;

    return s.currency.currencySymbolAlignment == CurrencySymbolAlignment.RIGHT ? formatterOutput.symbolOnRight : formatterOutput.symbolOnLeft;
  }
}

enum CurrencySymbolAlignment { LEFT, RIGHT }
