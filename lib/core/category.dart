import 'package:firebase_database/firebase_database.dart';

class Category {
  String id, name;
  Goal goal;

  Category({this.id, this.name, this.goal});

  factory Category.fromSnapshot(DataSnapshot s) =>
      Category(id: s.key, name: s.value["name"], goal: Goal.fromSnapshot(s));

  Map<String, dynamic> toMap() => {"name": name, "goal": goal.toMap()};

  static Category findById(List<Category> categories, String id) {
    categories.forEach((category) {
      if (category.id == id) {
        return category;
      }
    });
  }
}

class Goal {
  double amount;

  Goal({this.amount});

  factory Goal.fromSnapshot(DataSnapshot s) =>
      Goal(amount: s.value["goal.amount"]);

  Map<String, dynamic> toMap() => {"amount": amount};
}
