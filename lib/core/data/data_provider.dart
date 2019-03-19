import 'remote_dataservice.dart';

import '../bank_account.dart';
import '../autoadd.dart';
import '../category.dart';
import '../bill.dart';
import '../group.dart';
import '../preset.dart';

import '../settings/settings.dart';

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

  final List<Function(Group value)> onGroupAdded = [];
  final List<Function(Group value)> onGroupRemoved = [];
  final List<Function(Group value)> onGroupChanged = [];

  final List<Function(Preset value)> onPresetAdded = [];
  final List<Function(Preset value)> onPresetRemoved = [];
  final List<Function(Preset value)> onPresetChanged = [];
  
  final List<Function(Settings value)> onSettingsChanged = [];

  final List<BankAccount> bankAccounts = [];
  final List<AutoAdd> autoAdds = [];
  final List<Category> categories = [];
  final List<Bill> bills = [];
  final List<Group> groups = [];
  final List<Preset> presets = [];
  
  Settings settings;

  RemoteDataService remoteDataService = RemoteDataService();

  DataProvider() {
    remoteDataService.setupDatalinks().whenComplete(() {
      _setupOnAdded();
      _setupOnChanged();
      _setupOnRemoved();
    });
  }

  //Listeners
  void addCategoryEventListener(Function f(c)){
    onCategoryAdded.add(f);
    onCategoryRemoved.add(f);
    onCategoryChanged.add(f);
  }

  void removeCategoryEventListener(Function f(c)){
    onCategoryAdded.remove(f);
    onCategoryRemoved.remove(f);
    onCategoryChanged.remove(f);
  }

  void addBankAccountEventListener(Function f(b)){
    onBankAccountAdded.add(f);
    onBankAccountRemoved.add(f);
    onBankAccountRemoved.add(f);
  }

  void removeBankAccountEventListener(Function f(b)){
    onBankAccountAdded.remove(f);
    onBankAccountRemoved.remove(f);
    onBankAccountRemoved.remove(f);
  }

  void addGroupEventListener(Function f(g)){
    onGroupAdded.add(f);
    onGroupRemoved.add(f);
    onGroupChanged.add(f);
  }

  void removeGroupEventListener(Function f(b)){
    onGroupAdded.remove(f);
    onGroupRemoved.remove(f);
    onGroupChanged.remove(f);
  }


  //Add
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

  Future<void> addGroup(Group g) async {
    return remoteDataService.groupsReference.push().set(g.toMap());
  }

  Future<void> addPreset(Preset p) async {
    return remoteDataService.presetsReference.push().set(p.toMap());
  }

  Future<void> setSettings(Settings s) async {
    return remoteDataService.settingsReference.child(s.id).set(s.toMap());
  }

  //Remove
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

  Future<void> removeGroup(Group g){
    return remoteDataService.groupsReference.child(g.id).remove();
  }

  Future<void> removePreset(Preset p) async {
    return remoteDataService.presetsReference.child(p.id).remove();
  }

  //Change
  Future<void> changeCategory(Category c){
    return remoteDataService.categoriesRefernece.child(c.id).update(c.toMap());
  }

  Future<void> changeBankAccount(BankAccount b){
    return remoteDataService.bankAccountsReference.child(b.id).update(b.toMap());
  }

  Future<void> changeGroup(Group g){
    return remoteDataService.groupsReference.child(g.id).update(g.toMap());
  }

  Future<void> changePreset(Preset p){
    return remoteDataService.presetsReference.child(p.id).update(p.toMap());
  }

  Future<void> changeSettings(Settings s){
    return remoteDataService.settingsReference.update(s.toMap());
  }

  //On added
  void _setupOnAdded() {
    remoteDataService.settingsReference.onChildAdded.listen((event){
      settings = Settings.fromSnapshot(event.snapshot);

      onSettingsChanged.forEach((s){
        s(settings);
      });
    });
    
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

    remoteDataService.categoriesRefernece.onChildAdded.listen((event) {
      var category = Category.fromSnapshot(event.snapshot);
      categories.add(category);

      onCategoryAdded.forEach((e) {
        e(category);
      });
    });

    remoteDataService.groupsReference.onChildAdded.listen((event){
      var group = Group.fromSnapshot(event.snapshot);
      groups.add(group);

      onGroupAdded.forEach((e){
        e(group);
      });
    });

    remoteDataService.presetsReference.onChildAdded.listen((event){
      var preset = Preset.fromSnapshot(event.snapshot);
      presets.add(preset);

      onPresetAdded.forEach((e){
        e(preset);
      });
    });
  }

  void _setupOnChanged() {
    remoteDataService.settingsReference.onChildChanged.listen((event){
      settings = Settings.fromSnapshot(event.snapshot);
      onSettingsChanged.forEach((f){
        f(settings);
      });
    });
    
    remoteDataService.autoAddsReference.onChildChanged.listen((event) {
      var autoAdd = AutoAdd.fromSnapshot(event.snapshot);
      for (int i = 0; i < autoAdds.length; i++) {
        if (autoAdds.elementAt(i).id == autoAdd.id) {
          autoAdds.removeAt(i);
          autoAdds.insert(i, autoAdd);
        }
      }

      onAutoAddChanged.forEach((e) {
        e(autoAdd);
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
        e(bankAccount);
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
        e(bill);
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
        e(category);
      });
    });

    remoteDataService.groupsReference.onChildChanged.listen((event){
      var group = Group.fromSnapshot(event.snapshot);
      for(int i = 0; i < groups.length; i++){
        if(groups.elementAt(i).id == group.id){
          groups.removeAt(i);
          groups.insert(i, group);
        }
      }

      onGroupChanged.forEach((e){
        e(group);
      });
    });

    remoteDataService.presetsReference.onChildChanged.listen((event){
      var preset = Preset.fromSnapshot(event.snapshot);
      for(int i = 0; i < presets.length; i++){
        if(presets.elementAt(i).id == preset.id){
          presets.removeAt(i);
          presets.insert(i, preset);
        }
      }

      onPresetChanged.forEach((e){
        e(preset);
      });
    });
  }

  void _setupOnRemoved() {
    remoteDataService.autoAddsReference.onChildRemoved.listen((event) {
      var autoAdd = AutoAdd.fromSnapshot(event.snapshot);
      for(var currentAutoAdd in autoAdds){
        if(currentAutoAdd.id == autoAdd.id){
          autoAdds.remove(currentAutoAdd);
          break;
        }
      }

      onAutoAddRemoved.forEach((a){
        a(autoAdd);
      });
    });

    remoteDataService.bankAccountsReference.onChildRemoved.listen((event) {
      var bankAccount = BankAccount.fromSnapshot(event.snapshot);
      for(var currentBankAccount in bankAccounts){
        if(currentBankAccount.id ==  bankAccount.id){
          bankAccounts.remove(currentBankAccount);
          break;
        }
      }

      onBankAccountRemoved.forEach((b){
        b(bankAccount);
      });
    });

    remoteDataService.billsReference.onChildRemoved.listen((event) {
      var bill = Bill.fromSnapshot(event.snapshot);
      for(var currentBill in bills){
        if(currentBill.id == bill.id){
          bills.remove(currentBill);
        }
      }

      onBillRemoved.forEach((b){
        b(bill);
      });
    });

    remoteDataService.categoriesRefernece.onChildRemoved.listen((event) {
      var category = Category.fromSnapshot(event.snapshot);
      for(var currentCategory in categories){
        if(currentCategory.id == category.id){
          categories.remove(currentCategory);
          break;
        }
      }

      onCategoryRemoved.forEach((c){
        c(category);
      });
    });

    remoteDataService.groupsReference.onChildRemoved.listen((event){
      var group = Group.fromSnapshot(event.snapshot);
      for(var currentGroup in groups){
        if(currentGroup.id == group.id){
          groups.remove(currentGroup);
          break;
        }
      }

      onGroupRemoved.forEach((e){
        e(group);
      });
    });
    
    remoteDataService.presetsReference.onChildRemoved.listen((event){
      var preset = Preset.fromSnapshot(event.snapshot);
      for(var currentPreset in presets){
        if(currentPreset.id == preset.id){
          presets.remove(preset);
          break;
        }
      }

      onPresetRemoved.forEach((e){
        e(preset);
      });
    });
  }
}
