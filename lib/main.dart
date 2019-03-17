import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './pages/main_page.dart';
import './pages/sign_in_option_page.dart';
import './pages/sign_in_page.dart';
import './pages/sign_up_page.dart';

import './pages/bank_account_page.dart';
import './pages/category_page.dart';
import './pages/group_page.dart';

import './core/category.dart';
import './core/bank_account.dart';
import './core/group.dart';

import './core/data/data_provider.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new CashCockpit());
  });
}

class CashCockpit extends StatelessWidget {
  final dataProvider = DataProvider();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue, accentColor: Colors.deepPurpleAccent),
      routes: {
        "/main": (context) => MainPage(dataProvider),
        "/sign_in_options": (context) => SignInOptionPage(),
        "/sign_in": (context) => SignInPage(),
        "/sign_up": (context) => SignUpPage(),
        "/category": (context) =>
            CategoryPage(Category(Goal()), false, dataProvider),
        "/bank_account": (context) =>
            BankAccountPage(BankAccount(), false, dataProvider),
        "/group": (context) => GroupPage(Group([]), false, dataProvider),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        String direction = pathElements[1];
        if (pathElements[0] != '') {
          return null;
        } else if (direction == 'category') {
          final category = Category.findById(
              dataProvider.categories, pathElements[2]);
          return MaterialPageRoute(
            builder: (context) =>
                CategoryPage(
                    category,
                    true,
                    dataProvider),
          );
        } else if (direction == "bank_account") {
          final bankAccount = BankAccount.findById(
              dataProvider.bankAccounts, pathElements[2]);
          return MaterialPageRoute(
              builder: (context) =>
                  BankAccountPage(bankAccount, true, dataProvider)

          );
        }
        return null;
      },
      home: MainPage(dataProvider),
    );
  }
}
