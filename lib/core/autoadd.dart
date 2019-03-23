import 'bill.dart';
import 'package:firebase_database/firebase_database.dart';

class AutoAdd {

  static const WEEKLY = 0;
  static const MONTHLY = 1;
  static const YEARLY = 2;

  String id, name;
  int periodicity, addingDate;
  Bill bill;

  AutoAdd(this.bill, {this.id, this.name = "New AutoAdd", this.periodicity, this.addingDate});

  factory AutoAdd.fromSnapshot(DataSnapshot s) => AutoAdd(
    Bill.fromSnapshot(s),
      id: s.key,
      name: s.value["name"],
      periodicity: s.value["periodicity"],
      addingDate: s.value["addingDate"],
  );

  Map<String, dynamic> toMap() =>
      {"name": name, "periodicity": periodicity, "bill": bill.toMap(), "addingDate":addingDate};

  static AutoAdd findById(List<AutoAdd> autoAdds, String id) =>
      autoAdds.firstWhere((autoAdd) => autoAdd.id == id);
  
  static String periodicityAsString(AutoAdd autoAdd){
    if (autoAdd.periodicity == WEEKLY){
      return "weekly";
    } else if (autoAdd.periodicity == MONTHLY) {
      return "monthly";
    } else {
      return "yearly";
    }
  }
}
