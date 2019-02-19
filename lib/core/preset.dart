import 'bill.dart';
import 'package:firebase_database/firebase_database.dart';

class Preset {
  String id, name;
  Bill bill;

  Preset({this.id, this.name, this.bill});

  Map<String, dynamic> toMap() => {"name": name, "bill": bill.toMap()};

  factory Preset.fromSnapshot(DataSnapshot s) => Preset(
      id: s.key,
      name: s.value["name"],
      bill: Bill.fromSnapshot(s, useSubMap: true));
}
