import 'bill.dart';
import 'package:firebase_database/firebase_database.dart';

class AutoAdd {
  static const weekly = 0;
  static const monthly = 1;
  static const yearly = 2;

  String id, name;
  int periodicity;
  Bill bill;

  AutoAdd({this.id, this.name, this.periodicity, this.bill});

  factory AutoAdd.fromSnapshot(DataSnapshot s) => AutoAdd(
      id: s.key,
      name: s.value["name"],
      periodicity: s.value["periodicity"],
      bill: Bill.fromSnapshot(s));

  Map<String, dynamic> toMap() =>
      {"name": name, "periodicity": periodicity, "bill": bill.toMap()};

  static AutoAdd findById(List<AutoAdd> autoAdds, String id) =>
      autoAdds.firstWhere((autoAdd) => autoAdd.id == id);
}
