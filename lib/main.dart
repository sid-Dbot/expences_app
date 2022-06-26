import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/chart.dart';
import './widgets/transactionsLIst.dart';
import './widgets/newtransaction.dart';
import './models/transaction.dart';

void main() {
  // -------Keeping Protrait mode locked---------
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(Dashboard());
}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'personal expenses',
      theme: ThemeData(
          fontFamily: 'Quicksand',
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
              .copyWith(secondary: Colors.black54),
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(color: Colors.white))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _Transactions = [
    // Transaction(date: DateTime.now(), title: 'Shoes', amount: 200),
    // Transaction(date: DateTime.now(), title: 'Gun', amount: 1000),
  ];
  bool _showchart = false;
  List<Transaction> get _recentTransaction {
    return _Transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(
        days: 7,
      )));
    }).toList();
  }

  void _addTransaction(String txtitle, double txamt, DateTime selectedDate) {
    final tx = Transaction(
        date: selectedDate,
        title: txtitle,
        id: DateTime.now().toString(),
        amount: txamt);
    setState(() {
      _Transactions.add(tx);
    });
  }

  void _addNewTransactionWindow(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void deleteTransaction(String id) {
    setState(() {
      _Transactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    final Landscape = mediaquery.orientation == Orientation.landscape;
    final PreferredSizeWidget appbar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Dashboard'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => _addNewTransactionWindow(context),
                  child: Icon(CupertinoIcons.add),
                )
              ],
            ))
        : AppBar(
            title: Text(
              'Dashboard',
              style: TextStyle(
                  fontFamily: 'Quicksand', fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                  onPressed: () => _addNewTransactionWindow(context),
                  icon: Icon(Icons.add))
            ],
          );
    final txlistWidget = Container(
        height: (mediaquery.size.height -
                appbar.preferredSize.height -
                mediaquery.padding.top) *
            0.7,
        child: TransactionList(_Transactions, deleteTransaction));
    final chart = Container(
        // width: 1000,
        color: Colors.blueGrey,
        child: Container(
            height: (mediaquery.size.height -
                    appbar.preferredSize.height -
                    mediaquery.padding.top) *
                0.3,
            child: Chart(_recentTransaction)));
    final body = SafeArea(
        child: SingleChildScrollView(
      child: Column(children: <Widget>[
        if (Landscape)
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Text('Show Chart'),
            Switch.adaptive(
              activeColor: Colors.blueGrey,
              value: _showchart,
              onChanged: (val) {
                setState(() {
                  _showchart = val;
                });
              },
            )
          ]),
        if (!Landscape) chart,
        if (!Landscape) txlistWidget,
        if (Landscape)
          _showchart
              ? Container(
                  height: (mediaquery.size.height -
                          appbar.preferredSize.height -
                          mediaquery.padding.top) *
                      0.5,
                  child: Chart(_recentTransaction))
              : txlistWidget
      ]),
    ));

    return Platform.isIOS
        ? CupertinoPageScaffold(navigationBar: appbar, child: body)
        : Scaffold(
            appBar: appbar,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _addNewTransactionWindow(context),
                  ),
            body: body);
  }
}
