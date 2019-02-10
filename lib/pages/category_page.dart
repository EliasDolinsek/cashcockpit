import 'package:flutter/material.dart';

import '../core/category.dart';
import '../core/data/data_provider.dart';

class CategoryPage extends StatefulWidget {

  final DataProvider dataProvider;
  Category category;
  final bool editMode;

  CategoryPage(this.category, this.editMode, this.dataProvider);

  @override
  State<StatefulWidget> createState() {
    return _CategoryPageState();
  }
}

class _CategoryPageState extends State<CategoryPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _nameController;
  TextEditingController _goalAmountController;

  Function _onCategoryChanged;
  Function _onCategoryRemoved;

  @override
  void initState() {
    super.initState();
    _setupTextController();

    _onCategoryChanged = (updatedCategory) {
      if (widget.category.id == updatedCategory.id) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(
                "Updated values because category got edited on another device")));
        setState(() {
          widget.category = updatedCategory;
          _setupTextController();
        });
      }
    };

    _onCategoryRemoved = (removedCategory) {
      if (widget.category.id == removedCategory.id) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Category got deleted"),
                  content: Text("${widget.category.name} got deleted on another device"),
                  actions: <Widget>[
                    MaterialButton(
                      child: Text("Close"),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ));
      }
    };

    widget.dataProvider.onCategoryChanged.add(_onCategoryChanged);
    widget.dataProvider.onCategoryRemoved.add(_onCategoryRemoved);
  }

  void _setupTextController() {
    _nameController = TextEditingController(text: widget.category.name);
    _goalAmountController = TextEditingController(
        text: widget.category.goal.amount != null
            ? widget.category.goal.amount.toString()
            : "");
  }

  @override
  void dispose() {
    super.dispose();
    widget.dataProvider.onCategoryChanged.remove(_onCategoryChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.category.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  widget.category.name = value;
                }),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: _goalAmountController,
              enabled: widget.category.goal.enabled,
              decoration: InputDecoration(
                labelText: "Goal Amount",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                try {
                  widget.category.goal.amount = double.parse(value);
                } on Exception {
                  //TODO
                  print("Invalid Goal-Amount");
                }
              },
            ),
            SizedBox(
              height: 8,
            ),
            SwitchListTile(
              value: widget.category.goal.enabled,
              title: Text("Enable Goal"),
              onChanged: (value) {
                setState(
                  () {
                    widget.category.goal.enabled = value;
                  },
                );
              },
            ),
            SizedBox(
              height: 16,
            ),
            ButtonBar(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    if (widget.editMode) {
                      widget.dataProvider.onCategoryChanged
                          .remove(_onCategoryChanged);
                      widget.dataProvider.changeCategory(widget.category);
                    } else {
                      widget.dataProvider.addCategory(widget.category);
                    }

                    Navigator.pop(context);
                  },
                  child: widget.editMode
                      ? Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        )
                      : Text(
                          "Create",
                          style: TextStyle(color: Colors.white),
                        ),
                  color: Theme.of(context).primaryColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
