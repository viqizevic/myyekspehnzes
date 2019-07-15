import 'package:flutter/material.dart';
import 'models/transaction.dart';
import 'components/transaction_item.dart';
import 'components/new_transaction_form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Expenses',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      id: 't1',
      title: 'J.Co',
      amount: 17.99,
      date: DateTime.now(),
      category: 'Eating Out',
    ),
    Transaction(
      id: 't2',
      title: 'Hero',
      amount: 12.04,
      date: DateTime.now(),
      category: 'Grocery',
    ),
  ];

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransactionForm(),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Expenses'),
      ),
      body: Container(
        child: Column(
          children: transactions.map((tx) {
            return TransactionItem(
              title: tx.title,
              amount: '€${tx.amount.toStringAsFixed(2)}',
              category: tx.category,
            );
          }).toList(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
