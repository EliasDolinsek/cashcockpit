import 'package:firebase_database/firebase_database.dart';

class Category {

  String id, name;
  Goal goal;

  Category(this.goal, {this.id, this.name = "New Category"});

  factory Category.fromSnapshot(DataSnapshot s) =>
      Category(Goal.fromSnapshot(s, useSubMap: true), id: s.key, name: s.value["name"]);

  Map<String, dynamic> toMap() => {"name": name, "goal": goal.toMap()};

  static Category findById(List<Category> categories, String id) =>
      categories.firstWhere((category) => category.id == id);
}

class Goal {
  
  double amount;
  bool enabled;

  Goal({this.amount = 0, this.enabled = false});

  factory Goal.fromSnapshot(DataSnapshot s, {bool useSubMap = false, String subMapCode = "goal"}) {
    Map<dynamic, dynamic> goalMap = useSubMap ? s.value[subMapCode] : s.value;
    return Goal(amount: double.parse(goalMap["amount"].toString()), enabled: goalMap["enabled"]);
  }

  Map<String, dynamic> toMap() => {"amount": amount, "enabled": enabled};
}
