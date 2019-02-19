import 'package:firebase_database/firebase_database.dart';

class Group {

  String id, name;
  List<String> categoryIDs;

  Group({this.id, this.name = "New Group", this.categoryIDs = const []});

  factory Group.fromSnapshot(DataSnapshot s) => Group(
      id: s.key, name: s.value["name"], categoryIDs: s.value["categoryIDs"]);

  Map<String, dynamic> toMap() => {"name":name, "categoryIDs":categoryIDs};
}
