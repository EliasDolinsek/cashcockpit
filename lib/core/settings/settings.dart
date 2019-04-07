import 'package:firebase_database/firebase_database.dart';
import '../currency/currency.dart';

class Settings {
  static const SEPARATOR_COMMA = 0;
  static const SEPARATOR_POINT = 1;

  //ISO 4217
  String currencyISOCode, id;
  int pin, centSeparatorSymbol, thousandSeparatorSymbol;
  bool saveImageLocallyOnly, pinRequiredForLogin, saveDataOnFirebase;

  Settings(
      {this.id = "user_settings",
      this.currencyISOCode,
      this.pin,
      this.centSeparatorSymbol,
      this.thousandSeparatorSymbol,
      this.saveImageLocallyOnly,
      this.pinRequiredForLogin,
      this.saveDataOnFirebase});

  Currency get currency => Currency.getDefaultCurrencies()
      .firstWhere((c) => c.isoCode == currencyISOCode);

  Map<String, dynamic> toMap() => {
        "currencyISOCode": currencyISOCode,
        "pin": pin,
        "centSeparatorSymbol": centSeparatorSymbol,
        "thousandSeparatorSymbol": thousandSeparatorSymbol,
        "saveImageLocallyOnly": saveImageLocallyOnly,
        "pinRequiredForLogin": pinRequiredForLogin,
        "saveDataOnFirebase": saveDataOnFirebase
      };

  factory Settings.fromSnapshot(DataSnapshot s) => Settings(
      currencyISOCode: s.value["currencyISOCode"],
      pin: s.value["pin"],
      centSeparatorSymbol: s.value["centSeparatorSymbol"],
      thousandSeparatorSymbol: s.value["thousandSeparatorSymbol"],
      saveImageLocallyOnly: s.value["saveImageLocallyOnly"],
      pinRequiredForLogin: s.value["pinRequiredForLogin"],
      saveDataOnFirebase: s.value["saveDataOnFirebase"]);

  String get centSeparator =>
      centSeparatorSymbol == SEPARATOR_COMMA ? "," : ".";

  String get thousandSeparator =>
      thousandSeparatorSymbol == SEPARATOR_COMMA ? "," : ".";
}
