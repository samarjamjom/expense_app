import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    void submitData() {
      final enteredTitle = _titleController.text;
      final enteredAmount = double.parse(_amountController.text);

      if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
        return;
      }
      widget.addTx(
        enteredTitle,
        enteredAmount,
        _selectedDate
      );

      Navigator.of(context).pop();
    }

    void _presentPicker() {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now(),
      ).then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _selectedDate = pickedDate;
        });
      });
    }

    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
            padding: EdgeInsets.only(
              top:10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: "title"),
                  controller: _titleController,
                  onSubmitted: (_) => submitData(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: "amount"),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => submitData(),
                ),
                Container(
                  height: 30,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _selectedDate == null
                              ? 'No Date Chosen!'
                              : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                        ),
                      ),
                      FlatButton(
                        textColor: Colors.purple,
                        child: Text(
                          "Choose Date",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: _presentPicker,
                      ),
                    ],
                  ),
                ),
                FlatButton(
                  child: Text("add transaction"),
                  onPressed: submitData,
                  color: Theme.of(context).primaryColor, //background color
                  textColor: Colors.white,
                )
              ],
            )),
      ),
    );
  }
}
