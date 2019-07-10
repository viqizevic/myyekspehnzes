import 'package:flutter/material.dart';
import 'model/transaction.dart';

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
      title: 'Resto',
      amount: 17.99,
      date: DateTime.now(),
      category: 'Eating Out',
    ),
    Transaction(
      id: 't2',
      title: 'Lidl',
      amount: 12.04,
      date: DateTime.now(),
      category: 'Grocery',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Expenses'),
      ),
      body: Container(
        child: Column(
          children: transactions.map((tx) {
            return Card(
              child: Text(tx.title),
            );
          }).toList(),
        ),
      ),
    );
  }
}
