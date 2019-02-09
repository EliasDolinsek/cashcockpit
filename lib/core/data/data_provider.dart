import 'remote_dataservice.dart';

import '../bank_account.dart';
import '../autoadd.dart';
import '../category.dart';
import '../bill.dart';

class DataProvider {
  final List<Function> onCategoryAdded = [];
  final List<Function> onCategoryRemoved = [];
  final List<Function> onCategoryChanged = [];

  final List<Function> onBankAccountAdded = [];
  final List<Function> onBankAccountRemoved = [];
  final List<Function> onBankAccountChanged = [];

  final List<Function> onBillAdded = [];
  final List<Function> onBillRemoved = [];
  final List<Function> onBillChanged = [];

  final List<Function> onAutoAddAdded = [];
  final List<Function> onAutoAddRemoved = [];
  final List<Function> onAutoAddChanged = [];

  final List<BankAccount> bankAccounts = [];
  final List<AutoAdd> autoAdds = [];
  final List<Category> categories = [];
  final List<Bill> bills = [];

  RemoteDataService remoteDataService = RemoteDataService();

  DataProvider() {
    remoteDataService.setupDatalinks().whenComplete(() {
      _setupOnAdded();
      _setupOnChanged();
      _setupOnRemoved();
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

  Future<void> removeBankAccount(BankAccount b){
    return remoteDataService.bankAccountsReference.child(b.id).remove();
  }

  Future<void> removeAutoAdd(AutoAdd a){
    return remoteDataService.autoAddsReference.child(a.id).remove();
  }

  Future<void> removeBill(Bill b){
    return remoteDataService.billsReference.child(b.id).remove();
  }

  Future<void> removeCategory(Category c){
    return remoteDataService.categoriesRefernece.child(c.id).remove();
  }

  void _setupOnAdded() {
    remoteDataService.autoAddsReference.onChildAdded.listen((event) {
      var autoAdd = AutoAdd.fromSnapshot(event.snapshot);
      autoAdds.add(autoAdd);

      onAutoAddAdded.forEach((e) {
        e();
      });
    });

    remoteDataService.bankAccountsReference.onChildAdded.listen((event) {
      var bankAccount = BankAccount.fromSnapshot(event.snapshot);
      bankAccounts.add(bankAccount);

      onBankAccountAdded.forEach((e) {
        e();
      });
    });

    remoteDataService.billsReference.onChildAdded.listen((event) {
      var bill = Bill.fromSnapshot(event.snapshot);
      bills.add(bill);

      onBillAdded.forEach((e) {
        e();
      });
    });

    remoteDataService.categoriesRefernece.onChildAdded.listen((event) {
      var category = Category.fromSnapshot(event.snapshot);
      categories.add(category);

      onCategoryAdded.forEach((e) {
        e();
      });
    });
  }

  void _setupOnChanged() {
    remoteDataService.autoAddsReference.onChildChanged.listen((event) {
      var autoAdd = AutoAdd.fromSnapshot(event.snapshot);
      for (int i = 0; i < autoAdds.length; i++) {
        if (autoAdds.elementAt(i).id == autoAdd.id) {
          autoAdds.removeAt(i);
          autoAdds.insert(i, autoAdd);
        }
      }

      onAutoAddChanged.forEach((e) {
        e();
      });
    });

    remoteDataService.bankAccountsReference.onChildChanged.listen((event) {
      var bankAccount = BankAccount.fromSnapshot(event.snapshot);
      for (int i = 0; i < bankAccounts.length; i++) {
        if (bankAccounts.elementAt(i).id == bankAccount.id) {
          bankAccounts.removeAt(i);
          bankAccounts.insert(i, bankAccount);
        }
      }

      onBankAccountChanged.forEach((e) {
        e();
      });
    });

    remoteDataService.billsReference.onChildChanged.listen((event) {
      var bill = Bill.fromSnapshot(event.snapshot);
      for (int i = 0; i < bills.length; i++) {
        if (bills.elementAt(i).id == bill.id) {
          bills.removeAt(i);
          bills.insert(i, bill);
        }
      }

      onBillChanged.forEach((e) {
        e();
      });
    });

    remoteDataService.categoriesRefernece.onChildChanged.listen((event) {
      var category = Category.fromSnapshot(event.snapshot);
      for (int i = 0; i < categories.length; i++) {
        if (categories.elementAt(i).id == category.id) {
          categories.removeAt(i);
          categories.insert(i, category);
        }
      }

      onCategoryChanged.forEach((e) {
        e();
      });
    });
  }

  void _setupOnRemoved() {
    remoteDataService.autoAddsReference.onChildRemoved.listen((event) {});

    remoteDataService.bankAccountsReference.onChildRemoved.listen((event) {});

    remoteDataService.billsReference.onChildRemoved.listen((event) {});

    remoteDataService.categoriesRefernece.onChildRemoved.listen((event) {
      var category = Category.fromSnapshot(event.snapshot);
      for(var currentCategory in categories){
        if(currentCategory.id == category.id){
          categories.remove(currentCategory);
          break;
        }
      }

      onCategoryRemoved.forEach((c){
        c();
      });
    });
  }
}
