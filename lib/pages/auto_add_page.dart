import 'package:cash_cockpit/core/autoadd.dart';
import 'package:cash_cockpit/core/data/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class AutoAddPage extends StatefulWidget {
  final DataProvider dataProvider;
  AutoAdd autoAdd;
  final bool editMode;

  AutoAddPage(this.autoAdd, this.editMode, this.dataProvider);

  @override
  State<StatefulWidget> createState() {
    return _AutoAddPageState();
  }
}

class _AutoAddPageState extends State<AutoAddPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _nameController;

  String _name;
  int _periodicity;
  int _addingDate;

  Function _onAutoAddChanged;
  Function _onAutoAddRemoved;

  @override
  void initState() {
    super.initState();
    _setupTextController();

    _name = widget.autoAdd.name;
    _periodicity = widget.autoAdd.periodicity == null
        ? AutoAdd.MONTHLY
        : widget.autoAdd.periodicity;
    _addingDate =
    widget.autoAdd.addingDate == null ? 1 : widget.autoAdd.addingDate;

    _onAutoAddChanged = (updatedAutoAdd) {
      if (widget.autoAdd.id == updatedAutoAdd.id) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(
                "Updated values because category got edited on another device")));
        setState(() {
          widget.autoAdd = updatedAutoAdd;
          _setupTextController();
        });
      }
    };

    _onAutoAddRemoved = (removedAutoAdd) {
      if (widget.autoAdd.id == removedAutoAdd.id) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: Text("AutoAdd got deleted"),
                  content: Text(
                      "${widget.autoAdd.name} got deleted on another device"),
                  actions: <Widget>[
                    MaterialButton(
                      child: Text("Close"),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ));
      }
    };

    widget.dataProvider.onAutoAddChanged.add(_onAutoAddChanged);
    widget.dataProvider.onAutoAddRemoved.add(_onAutoAddRemoved);
  }

  @override
  void dispose() {
    super.dispose();
    widget.dataProvider.onAutoAddChanged.add(_onAutoAddChanged);
    widget.dataProvider.onAutoAddRemoved.add(_onAutoAddRemoved);
  }

  void _setupTextController() {
    _nameController =
        TextEditingController(text: widget.editMode ? widget.autoAdd.name : "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ChoiceChip(
                  label: Text(
                    "Weekly",
                    style: TextStyle(
                        color: _periodicity == AutoAdd.WEEKLY
                            ? Colors.white
                            : Colors.black),
                  ),
                  selected: _periodicity == AutoAdd.WEEKLY,
                  onSelected: (value) {
                    if (value) {
                      setState(() {
                        _periodicity = AutoAdd.WEEKLY;
                      });
                    }
                  },
                  selectedColor: Theme
                      .of(context)
                      .primaryColor,
                ),
                SizedBox(
                  width: 8.0,
                ),
                ChoiceChip(
                  label: Text(
                    "Monthly",
                    style: TextStyle(
                        color: _periodicity == AutoAdd.MONTHLY
                            ? Colors.white
                            : Colors.black),
                  ),
                  selected: _periodicity == AutoAdd.MONTHLY,
                  onSelected: (value) {
                    if (value) {
                      setState(() {
                        _periodicity = AutoAdd.MONTHLY;
                      });
                    }
                  },
                  selectedColor: Theme
                      .of(context)
                      .primaryColor,
                ),
                SizedBox(
                  width: 8.0,
                ),
                ChoiceChip(
                  label: Text(
                    "Yearly",
                    style: TextStyle(
                        color: _periodicity == AutoAdd.YEARLY
                            ? Colors.white
                            : Colors.black),
                  ),
                  selected: _periodicity == AutoAdd.YEARLY,
                  onSelected: (value) {
                    if (value) {
                      setState(() {
                        _periodicity = AutoAdd.YEARLY;
                      });
                    }
                  },
                  selectedColor: Theme
                      .of(context)
                      .primaryColor,
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MaterialButton(
                    child: Text("EDIT BILL"),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context, builder: (context) => Text("Test"));
                    },
                  ),
                  Text("125€ income"),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MaterialButton(
                    child: Text(
                        "EDIT ADDITION DATE"
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              NumberPickerDialog.integer(
                                minValue: 1,
                                maxValue: 31,
                                initialIntegerValue: _addingDate,
                                title: Text("Select Addition Date"),
                              )).then((value) {
                        setState(() {
                          if (value != null) {
                            _addingDate = value;
                          }
                        });
                      });
                    },
                  ),
                  Text("Every 8. of month")
                ],
              ),
            ),
            ButtonBar(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    widget.autoAdd.name = _name;
                    widget.autoAdd.addingDate = _addingDate;
                    widget.autoAdd.periodicity = _periodicity;

                    if (widget.editMode) {
                      widget.dataProvider.onAutoAddChanged
                          .remove(_onAutoAddChanged);
                      widget.dataProvider.changeAutoAdd(widget.autoAdd);
                    } else {
                      widget.dataProvider.addAutoAdd(widget.autoAdd);
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
                  color: Theme
                      .of(context)
                      .primaryColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
