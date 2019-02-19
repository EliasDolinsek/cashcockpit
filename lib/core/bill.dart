import 'package:firebase_database/firebase_database.dart';

class Bill {
  static const int input = 0;
  static const int output = 1;

  String id;
  String description, imageUrl;
  String categoryId, bankAccountId;

  double amount;
  int type;

  Bill(
      {this.id,
      this.description,
      this.imageUrl,
      this.amount,
      this.type,
      this.categoryId,
      this.bankAccountId});

  factory Bill.fromSnapshot(DataSnapshot s, {bool useSubMap = false, String subMapCode = "bill"}) {
    Map<dynamic, dynamic> billMap = useSubMap ? s.value[subMapCode] : s.value;
    return Bill(
        description: billMap["description"],
        imageUrl: billMap["imageUrl"],
        amount: billMap["amount"],
        type: billMap["type"],
        categoryId: billMap["categoryID"],
        bankAccountId: billMap["billMap"]);
  }

  Map<String, dynamic> toMap() => {
        "description": description,
        "imageUrl": imageUrl,
        "categoryId": categoryId,
        "bankAccountId": bankAccountId,
        "amount": amount,
        "type": type
      };

  static Bill findById(List<Bill> bills, String id) =>
      bills.firstWhere((category) => category.id == id);
}
