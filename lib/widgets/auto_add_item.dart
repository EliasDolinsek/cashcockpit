import 'package:cash_cockpit/core/autoadd.dart';
import 'package:cash_cockpit/core/settings/settings.dart';
import 'package:flutter/material.dart';

class AutoAddItem extends StatelessWidget {
  final AutoAdd autoAdd;
  final Function onDelete;
  final Settings settings;

  AutoAddItem(this.autoAdd, this.onDelete, this.settings);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          autoAdd.name,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Roboto", fontSize: 34, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Chip(
              label: Text(
                AutoAdd.periodicityAsString(autoAdd).toUpperCase(),
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            SizedBox(width: 8),
            ActionChip(
              label: Text("Edit"),
              onPressed: () {
                Navigator.pushNamed(context, "/auto_add/${autoAdd.id}");
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
                    title: Text("Delete AutoAdd"),
                    content:
                    Text("Deleteing an AutoAdd can not be redone!"),
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
        ),
        SizedBox(
          height: 8.0,
        )
      ],
    );
  }
}
