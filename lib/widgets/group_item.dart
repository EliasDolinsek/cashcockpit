import 'package:flutter/material.dart';

import 'package:cash_cockpit/core/group.dart';
import 'package:cash_cockpit/core/settings/settings.dart';

class GroupItem extends StatelessWidget {
  final Group group;
  final Function onDelete;
  final Settings settings;

  GroupItem(this.group, this.onDelete, this.settings);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          group.name,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Roboto", fontSize: 34, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Chip(
              label: Text(
                "${group.categoryIDs.length} Categories",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            SizedBox(width: 8),
            ActionChip(
              label: Text("Edit"),
              onPressed: () {
                Navigator.pushNamed(context, "/group/${group.id}");
              },
            ),
            SizedBox(width: 8),
            ActionChip(
              label: Text(
                "Delete",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: Text("Delete group"),
                        content:
                            Text("Deleteing a group can not be redone!"),
                        actions: <Widget>[
                          MaterialButton(
                            child: Text("Cancel"),
                            onPressed: () => Navigator.pop(context),
                          ),
                          MaterialButton(
                            child: Text("Delete"),
                            onPressed: () {
                              onDelete();
                              Navigator.pop(context);
                            },
                          )
                        ],
                      )),
            )
          ],
        )
      ],
    );
  }
}
