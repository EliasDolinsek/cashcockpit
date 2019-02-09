import 'package:firebase_database/firebase_database.dart';

class BankAccount {
  String id, name;
  double balance;

  BankAccount({this.id, this.name, this.balance});

  factory BankAccount.fromSnapshot(DataSnapshot s) => BankAccount(
      id: s.key, name: s.value["name"], balance: s.value["balance"]);

  Map<String, dynamic> toMap() => {"name": name, "balance": balance};

  static BankAccount findById(List<BankAccount> bankAccounts, String id) {
    bankAccounts.forEach((bankAccount) {
      if (bankAccount.id == id) {
        return bankAccount;
      }
    });
  }
}
