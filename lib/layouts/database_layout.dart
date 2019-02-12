import 'package:flutter/material.dart';

import '../widgets/category_item.dart';
import '../widgets/bank_account_item.dart';

import '../core/data/data_provider.dart';

class DatabaseLayout extends StatelessWidget {
  final DataProvider dataProvider;

  DatabaseLayout(this.dataProvider);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("CashCockpit"),
            bottom: TabBar(tabs: [
              Tab(
                text: "Categories",
                icon: Icon(Icons.category),
              ),
              Tab(
                text: "AutoAdds",
                icon: Icon(Icons.timelapse),
              ),
              Tab(
                text: "Bank Accounts",
                icon: Icon(Icons.account_balance),
              ),
            ]),
          ),
          body: TabBarView(children: [
            _CategoriesList(dataProvider),
            Text("AutoAdds"),
            _BankAccountList(dataProvider),
          ]),
        ),
      ),
    );
  }
}

class _CategoriesList extends StatefulWidget {
  final DataProvider dataProvider;

  _CategoriesList(this.dataProvider);

  @override
  State<StatefulWidget> createState() {
    return _CategoriesListState();
  }
}

class _CategoriesListState extends State<_CategoriesList> {
  Function _onCategoryChange;

  @override
  void initState() {
    super.initState();

    _onCategoryChange = (c) {
      setState(() {});
    };

    widget.dataProvider.onCategoryAdded.add(_onCategoryChange);
    widget.dataProvider.onCategoryRemoved.add(_onCategoryChange);
    widget.dataProvider.onCategoryChanged.add(_onCategoryChange);
  }

  @override
  void dispose() {
    super.dispose();
    widget.dataProvider.onCategoryAdded.remove(_onCategoryChange);
    widget.dataProvider.onCategoryRemoved.remove(_onCategoryChange);
    widget.dataProvider.onCategoryChanged.remove(_onCategoryChange);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/category");
        },
        child: Icon(Icons.add),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: CategoryItem(
                  widget.dataProvider.categories.elementAt(index),
                  () => setState(
                        () {
                          widget.dataProvider.removeCategory(
                              widget.dataProvider.categories.elementAt(index));
                        },
                      ),
                ),
              ),
          separatorBuilder: (context, index) => Divider(),
          itemCount: widget.dataProvider.categories.length),
    );
  }
}

class _BankAccountList extends StatefulWidget {
  final DataProvider dataProvider;

  _BankAccountList(this.dataProvider);

  @override
  State<StatefulWidget> createState() {
    return _BankAccountListState();
  }
}

class _BankAccountListState extends State<_BankAccountList> {

  Function _onBankAccountChange;
  @override
  void initState() {
    super.initState();

    _onBankAccountChange = (c) {
      setState(() {});
    };

    widget.dataProvider.onBankAccountAdded.add(_onBankAccountChange);
    widget.dataProvider.onBankAccountRemoved.add(_onBankAccountChange);
    widget.dataProvider.onBankAccountChanged.add(_onBankAccountChange);
  }

  @override
  void dispose() {
    super.dispose();
    widget.dataProvider.onBankAccountAdded.remove(_onBankAccountChange);
    widget.dataProvider.onBankAccountRemoved.remove(_onBankAccountChange);
    widget.dataProvider.onBankAccountChanged.remove(_onBankAccountChange);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/bank_account");
        },
        child: Icon(Icons.add),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: BankAccountItem(
                    widget.dataProvider.bankAccounts.elementAt(index), () {
                  setState(() {
                    widget.dataProvider.removeBankAccount(
                        widget.dataProvider.bankAccounts.elementAt(index));
                  });
                }),
              ),
          separatorBuilder: (context, index) => Divider(),
          itemCount: widget.dataProvider.bankAccounts.length),
    );
  }
}
