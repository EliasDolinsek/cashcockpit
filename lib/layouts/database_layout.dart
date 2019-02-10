import 'package:flutter/material.dart';

import '../widgets/category_item.dart';

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
            Text("BankAccounts")
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
