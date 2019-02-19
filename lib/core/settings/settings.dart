import 'package:firebase_database/firebase_database.dart';

class Settings {

  String currencyCode;
  int pin, centSymbolCode;

  Settings({this.currencyCode, this.pin, this.centSymbolCode});

  Map<String, dynamic> toMap() => {"currencyCode":currencyCode, "pin":pin, "centSymbolColde":centSymbolCode};

  factory Settings.fromSnapshot(DataSnapshot s) => Settings(
      currencyCode: s.value["currencyCode"], pin: s.value["pin"], centSymbolCode: s.value["centSymbolCode"]);

}