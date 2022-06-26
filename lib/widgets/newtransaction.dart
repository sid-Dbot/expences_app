import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/adaptive_button.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  //const NewTransaction({Key? key}) : super(key: key);
  final Function addtx;

  NewTransaction(this.addtx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amtController = TextEditingController();
  DateTime _selectedDate;

  void submit() {
    if (amtController.text.isEmpty) {
      return;
    }
    final enteredtitle = titleController.text;
    final enteredamt = double.parse(amtController.text);
    if (enteredtitle.isEmpty || enteredamt <= 0 || _selectedDate == null) {
      return;
    }
    widget.addtx(
      enteredtitle,
      enteredamt,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _datepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Card(
              elevation: 20,
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w600, fontFamily: 'OpenSans')),
                controller: titleController,
                onSubmitted: (_) => submit(),
              )),
          Card(
              elevation: 20,
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Expenditure',
                    labelStyle: TextStyle(
                        fontFamily: 'sOpenSans', fontWeight: FontWeight.w600)),
                controller: amtController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submit(),
              )),
          Row(
            children: [
              Expanded(
                child: Text(_selectedDate == null
                    ? 'No date choosen!'
                    : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'),
              ),
              AdaptiveButton("Date Picker", _datepicker),
            ],
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: StadiumBorder(),
              side: BorderSide(color: Colors.black),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            onPressed: submit,
            child: Text(
              'Submit',
              style: TextStyle(
                color: Theme.of(context).textTheme.button.color,
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
