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

  factory Bill.fromSnapshot(DataSnapshot s) => Bill(
        id: s.key,
        description: s.value["description"],
        imageUrl: s.value["imageUrl"],
        amount: s.value["amount"],
        type: s.value["type"],
        categoryId: s.value["categoryId"],
        bankAccountId: s.value["bankAccountId"],
      );

  Map<String, dynamic> toMap() => {
    "description":description,
    "imageUrl":imageUrl,
    "categoryId":categoryId,
    "bankAccountId":bankAccountId,
    "amount":amount,
    "type":type
  };
}
