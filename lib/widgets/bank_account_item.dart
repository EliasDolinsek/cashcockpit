import 'package:cash_cockpit/core/settings/settings.dart';
import 'package:flutter/material.dart';

import '../core/currency/currency.dart';
import '../core/bank_account.dart';

class BankAccountItem extends StatelessWidget {

  final BankAccount bankAccount;
  final Function onDelete;
  final Settings settings;

  BankAccountItem(this.bankAccount, this.onDelete, this.settings);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          bankAccount.name,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Roboto", fontSize: 34, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Chip(
              label: Text(
                bankAccount.balance != 0
                    ? CurrencyFormatter.formatAmount(bankAccount.balance, settings)
                    : "No balance",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            SizedBox(width: 8),
            ActionChip(
              label: Text("Edit"),
              onPressed: () {
                Navigator.pushNamed(context, "/bank_account/${bankAccount.id}");
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
                        title: Text("Delete bank account"),
                        content:
                            Text("Deleteing a bank account can not be redone!"),
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
