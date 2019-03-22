import 'package:flutter/material.dart';

import '../core/category.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  final Function onDelete;

  CategoryItem(this.category, this.onDelete);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          category.name,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Roboto", fontSize: 34, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ActionChip(
              label: Text("Edit"),
              onPressed: () {
                Navigator.pushNamed(context, "/category/${category.id}");
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
                        title: Text("Delete Category"),
                        content:
                            Text("Deleteing a category can not be redone!"),
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
      ],
    );
  }
}
