import 'package:flutter/material.dart';
import '../core/data/data_provider.dart';
import '../core/category.dart';

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
  @override
  void initState() {
    super.initState();
    widget.dataProvider.onCategoryAdded.add(() {
      setState(() {});
    });
    widget.dataProvider.onCategoryRemoved.add(() {
      setState(() {});
    });
    widget.dataProvider.onCategoryChanged.add(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    //TDODO remove listeners
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //TODO delete import
          widget.dataProvider.addCategory(Category(
              name: DateTime.now().toIso8601String(), goal: Goal(amount: 100.9)));
        },
        child: Icon(Icons.add),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      widget.dataProvider.categories.elementAt(index).name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 34,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ActionChip(
                          label: Text("Edit"),
                          onPressed: () {},
                        ),
                        SizedBox(width: 8),
                        ActionChip(
                          label: Text(
                            "Delete",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                          onPressed: () {
                            setState(() {
                              widget.dataProvider.removeCategory(widget.dataProvider.categories.elementAt(index));
                            });
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
          separatorBuilder: (context, index) => Divider(),
          itemCount: widget.dataProvider.categories.length),
    );
  }
}
