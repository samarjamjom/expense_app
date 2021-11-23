import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../models/transaction.dart';
import './transactionItem.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _usertransactions;
  final Function deleteTx;

  TransactionList(this._usertransactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return _usertransactions.isEmpty
          ? LayoutBuilder(builder: (ctx, Constraints){
            return Column(
              children: [
                Text("No transaction added yet!"),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: Constraints.maxHeight * 0.6 ,
                  child: Image.asset('assets/images/waiting.png',
                      fit: BoxFit.cover),
                )
              ],
            );
          }) 
          : ListView.builder(
              itemBuilder: (ctx, index) {
               return transactionItem(transaction: _usertransactions[index], deleteTx: deleteTx);
              },
              itemCount: _usertransactions.length,
            );
  }
}

 