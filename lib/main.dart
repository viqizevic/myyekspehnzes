import 'package:flutter/material.dart';
import 'package:myy_expenses/components/chart.dart';
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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String currency = '€';
  final double initialAmount = 100.0;
  final List<Transaction> transactions = [
    Transaction(
      id: 't4',
      title: 'KFC',
      amount: 10.37,
      date: DateTime.now(),
      category: 'Eating Out',
    ),
    Transaction(
      id: 't3',
      title: 'J.Co',
      amount: 5.79,
      date: DateTime.now(),
      category: 'Eating Out',
    ),
    Transaction(
      id: 't2',
      title: 'Carrefour',
      amount: 3.94,
      date: DateTime.now().subtract(Duration(days: 1)),
      category: 'Grocery',
    ),
    Transaction(
      id: 't1',
      title: 'Giant',
      amount: 14.83,
      date: DateTime.now().subtract(Duration(days: 2)),
      category: 'Grocery',
    ),
  ];

  List<Transaction> get _recentTransactions {
    return transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  List<TransactionItem> getListOfTransactionItems() {
    double currentAmount = initialAmount;
    return transactions.map((tx) {
      currentAmount -= tx.amount;
      return TransactionItem(
        title: tx.title,
        amount: '$currency${tx.amount.toStringAsFixed(2)}',
        category: tx.category,
        date: tx.date,
        balance: '$currency${currentAmount.toStringAsFixed(2)}',
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, String txCategory, DateTime chosenDate) {
    Transaction tx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      category: txCategory,
    );
    setState(() {
      transactions.add(tx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransactionForm(
            addTx: _addNewTransaction,
          ),
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Chart(
              recentTransactions: _recentTransactions,
            ),
            Column(children: getListOfTransactionItems()),
          ],
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
