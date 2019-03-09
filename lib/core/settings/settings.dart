import 'package:firebase_database/firebase_database.dart';
import '../currency/currency.dart';

class Settings {
  static const SEPARATOR_COMMA = 0;
  static const SEPARATOR_POINT = 1;

  //ISO 4217
  String currencyISOCode, id;
  int pin, centSeparatorSymbol, thousandSeparatorSymbol;

  Settings(
      {this.id,
      this.currencyISOCode,
      this.pin,
      this.centSeparatorSymbol,
      this.thousandSeparatorSymbol});

  Currency get currency {
    if (currencyISOCode == "EUR") {
      return Currency.EUR;
    } else if (currencyISOCode == "USD") {
      return Currency.USD;
    } else if (currencyISOCode == "JPY") {
      return Currency.JPY;
    }
  }

  Map<String, dynamic> toMap() => {
        "currencyISOCode": currencyISOCode,
        "pin": pin,
        "centSeparatorSymbol": centSeparatorSymbol,
        "thousandSeparatorSymbol": thousandSeparatorSymbol
      };

  factory Settings.fromSnapshot(DataSnapshot s) => Settings(
      id: s.key,
      currencyISOCode: s.value["currencyISOCode"],
      pin: s.value["pin"],
      centSeparatorSymbol: s.value["centSeparatorSymbol"],
      thousandSeparatorSymbol: s.value["thousandSeparatorSymbol"]);

  String get centSeparator => centSeparatorSymbol == SEPARATOR_COMMA ? "," : ".";
  String get thousandSeparator => thousandSeparatorSymbol == SEPARATOR_COMMA ? "," : ".";

}
