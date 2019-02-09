import 'remote_dataservice.dart';

import '../bank_account.dart';
import '../autoadd.dart';
import '../category.dart';
import '../bill.dart';

class DataProvider {
  final List<Function(Category value)> onCategoryAdded = [];
  final List<Function(Category value)> onCategoryRemoved = [];
  final List<Function(Category value)> onCategoryChanged = [];

  final List<Function(BankAccount value)> onBankAccountAdded = [];
  final List<Function(BankAccount value)> onBankAccountRemoved = [];
  final List<Function(BankAccount value)> onBankAccountChanged = [];

  final List<Function(Bill value)> onBillAdded = [];
  final List<Function(Bill value)> onBillRemoved = [];
  final List<Function(Bill value)> onBillChanged = [];

  final List<Function(AutoAdd value)> onAutoAddAdded = [];
  final List<Function(AutoAdd value)> onAutoAddRemoved = [];
  final List<Function(AutoAdd value)> onAutoAddChanged = [];

  final List<BankAccount> bankAccounts = [];
  final List<AutoAdd> autoAdds = [];
  final List<Category> categories = [];
  final List<Bill> bills = [];

  RemoteDataService remoteDataService = RemoteDataService();

  DataProvider() {
    remoteDataService.setupDatalinks().whenComplete(() {
      remoteDataService.autoAddsReference.onChildAdded.listen((event) {
        var autoAdd = AutoAdd.fromSnapshot(event.snapshot);
        autoAdds.add(autoAdd);

        onAutoAddAdded.forEach((e) {
          e(autoAdd);
        });
      });

      remoteDataService.bankAccountsReference.onChildAdded.listen((event) {
        var bankAccount = BankAccount.fromSnapshot(event.snapshot);
        bankAccounts.add(bankAccount);

        onBankAccountAdded.forEach((e) {
          e(bankAccount);
        });
      });

      remoteDataService.billsReference.onChildAdded.listen((event) {
        var bill = Bill.fromSnapshot(event.snapshot);
        bills.add(bill);

        onBillAdded.forEach((e) {
          e(bill);
        });
      });

      remoteDataService.autoAddsReference.onChildAdded.listen((event) {
        var category = Category.fromSnapshot(event.snapshot);
        categories.add(category);

        onCategoryAdded.forEach((e) {
          e(category);
        });
      });
    });
  }

  Future<void> addBankAccount(BankAccount b) async {
    return remoteDataService.bankAccountsReference.push().set(b.toMap());
  }

  Future<void> addAutoAdd(AutoAdd a) async {
    return remoteDataService.autoAddsReference.push().set(a.toMap());
  }

  Future<void> addBill(Bill b) async {
    return remoteDataService.billsReference.push().set(b.toMap());
  }

  Future<void> addCategory(Category c) async {
    return remoteDataService.categoriesRefernece.push().set(c.toMap());
  }
}
