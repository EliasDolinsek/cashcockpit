import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:cash_cockpit/core/data/data_provider.dart';
import 'package:cash_cockpit/core/group.dart';
import 'package:flutter/material.dart';

class GroupPage extends StatefulWidget {
  final DataProvider dataProvider;
  final bool editMode;
  Group group;

  GroupPage(this.group, this.editMode, this.dataProvider);

  @override
  State<StatefulWidget> createState() {
    return _GroupPageState();
  }
}

class _GroupPageState extends State<GroupPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _nameController;

  Function _onGroupChanged;
  Function _onGroupRemoved;

  @override
  void initState() {
    super.initState();
    _setupTextController();

    _onGroupChanged = (updatedGroup) {
      if (widget.group.id == updatedGroup.id) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(
                "Updated values because group got edited on another device")));
        setState(() {
          widget.group = updatedGroup;
          _setupTextController();
        });
      }
    };

    _onGroupRemoved = (removedGroup) {
      if (widget.group.id == removedGroup.id) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Group got deleted"),
                  content: Text(
                      "${widget.group.name} got deleted on another device"),
                  actions: <Widget>[
                    MaterialButton(
                      child: Text("Close"),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ));
      }
    };

    widget.dataProvider.onGroupChanged.add(_onGroupChanged);
    widget.dataProvider.onGroupRemoved.add(_onGroupRemoved);
  }

  @override
  void dispose() {
    super.dispose();
    widget.dataProvider.onGroupChanged.remove(_onGroupChanged);
    widget.dataProvider.onGroupRemoved.remove(_onGroupRemoved);
  }

  void _setupTextController() {
    _nameController =
        TextEditingController(text: widget.editMode ? widget.group.name : "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.group.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                  labelText: "Name", border: OutlineInputBorder()),
              onChanged: (value) {
                setState(() {
                  if (value.trim().length == 0) {
                    widget.group.name = "New Group";
                  } else {
                    widget.group.name = value;
                  }
                });
              },
            ),
            SizedBox(
              height: 8.0,
            ),
            ActionChip(
              avatar: CircleAvatar(
                backgroundColor: Color(widget.group.color),
              ),
              label: Text("CHANGE GROUP COLOR"),
              onPressed: () {
                showDialog(context: context, builder: (context) => AlertDialog(
                  title: Text("Group Color"),
                  content: MaterialColorPicker(
                    selectedColor: Color(widget.group.color),
                    onColorChange: (c){
                      setState(() {
                        widget.group.color = c.value;
                      });
                    },
                  ),
                  actions: <Widget>[
                    MaterialButton(
                      child: Text("CLOSE"),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ));
              },
            ),
            SizedBox(height: 8.0,),
            Divider(),
            Expanded(
                child: ListView(
              children: <Widget>[
                DataTable(
                  columns: <DataColumn>[
                    DataColumn(label: Text("Add")),
                    DataColumn(label: Text("Category"))
                  ],
                  rows: widget.dataProvider.categories
                      .map(
                        (category) => DataRow(
                              cells: <DataCell>[
                                DataCell(
                                  Checkbox(
                                    value: widget.group.categoryIDs
                                        .contains(category.id),
                                    onChanged: (value) {
                                      setState(() {
                                        if (widget.group.categoryIDs
                                            .contains(category.id)) {
                                          widget.group.categoryIDs
                                              .remove(category.id);
                                        } else {
                                          widget.group.categoryIDs
                                              .add(category.id);
                                        }
                                      });
                                    },
                                  ),
                                ),
                                DataCell(Text(category.name))
                              ],
                            ),
                      )
                      .toList(),
                ),
              ],
            )),
            ButtonBar(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    if (widget.editMode) {
                      widget.dataProvider.changeGroup(widget.group);
                    } else {
                      widget.dataProvider.addGroup(widget.group);
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
