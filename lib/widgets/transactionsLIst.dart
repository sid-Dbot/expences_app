import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _Transactions;
  final Function deletetx;
  TransactionList(this._Transactions, this.deletetx);

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
              return Card(
                margin: EdgeInsets.symmetric(vertical: 6, horizontal: 7),
                elevation: 7,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(7),
                      child: FittedBox(
                        child: Text(
                          '\$${_Transactions[index].amount}',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  title: Text('${_Transactions[index].title}',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(
                      DateFormat.yMMMd().format(_Transactions[index].date),
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  trailing: IconButton(
                    onPressed: () => deletetx(_Transactions[index].id),
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                  ),
                ),
              );
            },
            itemCount: _Transactions.length,
          );
  }
}
