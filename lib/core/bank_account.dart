import 'package:firebase_database/firebase_database.dart';

class BankAccount {

  String id, name;
  double balance;
  bool balanceEnabled;

  BankAccount({this.id, this.name = "New Bank Account", this.balance = 0, this.balanceEnabled = false});

  factory BankAccount.fromSnapshot(DataSnapshot s) => BankAccount(
      id: s.key, name: s.value["name"], balance: double.parse(s.value["balance"].toString()), balanceEnabled: s.value["balanceEnabled"]);

  Map<String, dynamic> toMap() => {"name": name, "balance": balance, "balanceEnabled":balanceEnabled};

  static BankAccount findById(List<BankAccount> bankAccounts, String id) =>
      bankAccounts.firstWhere((bankAccount) => bankAccount.id == id);
}
