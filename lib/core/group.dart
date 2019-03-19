import 'package:firebase_database/firebase_database.dart';

class Group {
  String id, name;
  List<dynamic> categoryIDs;

  Group(this.categoryIDs, {this.id, this.name = "New Group"});

  factory Group.fromSnapshot(DataSnapshot s) {
    var categoryIDs = s.value["categoryIDs"];
    if (categoryIDs == null) {
      categoryIDs = [];
    }

    return Group(categoryIDs, id: s.key, name: s.value["name"]);
  }

  Map<String, dynamic> toMap() => {"name": name, "categoryIDs": categoryIDs};

  static findById(List<Group> groups, String id) =>
      groups.firstWhere((group) => group.id == id);
}
