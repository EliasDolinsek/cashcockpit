import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './pages/main_page.dart';
import './pages/sign_in_option_page.dart';
import './pages/sign_in_page.dart';
import './pages/sign_up_page.dart';

import './pages/category_page.dart';
import './core/category.dart';
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
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
        } else if (pathElements[1] == 'category') {
          final category = Category.findById(dataProvider.categories, pathElements[2]);
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => CategoryPage(
                category,
                true,
                dataProvider),
          );
        }
        return null;
      },
      home: MainPage(dataProvider),
    );
  }
}
