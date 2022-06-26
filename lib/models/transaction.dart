import 'package:flutter/foundation.dart';

class Transaction {
  final DateTime date;
  final String title;
  final String id;
  final double amount;
  Transaction(
      {@required this.date,
      @required this.title,
      @required this.id,
      @required this.amount});
}
