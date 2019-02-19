import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RemoteDataService {
  DatabaseReference categoriesRefernece,
      bankAccountsReference,
      billsReference,
      autoAddsReference,
      groupsReference,
      presetsReference,
      settingsReference;

  FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  RemoteDataService() {
    _firebaseDatabase.setPersistenceEnabled(true);
  }

  Future<void> setupDatalinks() async {
    final user = await FirebaseAuth.instance.currentUser();

    categoriesRefernece =
        _firebaseDatabase.reference().child("categories").child(user.uid);

    bankAccountsReference =
        _firebaseDatabase.reference().child("bankAccounts").child(user.uid);

    billsReference =
        _firebaseDatabase.reference().child("bills").child(user.uid);

    autoAddsReference =
        _firebaseDatabase.reference().child("autoAdds").child(user.uid);

    groupsReference =
        _firebaseDatabase.reference().child("groups").child(user.uid);

    presetsReference =
        _firebaseDatabase.reference().child("presets").child(user.uid);

    settingsReference =
        _firebaseDatabase.reference().child("settings").child(user.uid);
  }
}
