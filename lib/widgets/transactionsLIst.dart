import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'transactionItem.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _Transactions;
  final Function deletetx;
  const TransactionList(this._Transactions, this.deletetx);

  @override
  Widget build(BuildContext context) {
    return _Transactions.isEmpty
        ? LayoutBuilder(builder: ((context, constraints) {
            return Column(children: [
              Text(
                'No transactions.',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: constraints.maxHeight * 0.7,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ))
            ]);
          }))
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return TransactionItem(
                  transaction: _Transactions[index], deletetx: deletetx);
            },
            itemCount: _Transactions.length,
          );
  }
}
