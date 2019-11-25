import 'package:flutter/material.dart';
import 'package:myy_expenses/components/chart_bar.dart';
import 'package:myy_expenses/models/transaction.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart({this.recentTransactions});

  List<Map<String, dynamic>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      final String formattedWeekDay = DateFormat.MMMEd().format(weekDay);
      double totalSum = recentTransactions.where((tx) {
        return DateFormat.MMMEd().format(tx.date) == formattedWeekDay;
      }).fold(0, (p, tx) {
        return p + tx.amount;
      });
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0, (sum, item) {
      return max(sum, item['amount']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: data['day'],
                spendingAmount: data['amount'],
                spendingPercentageOfTotal:
                    0.0 == maxSpending ? 0.0 : data['amount'] / maxSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
