import 'package:flutter/material.dart';
import 'package:myy_expenses/constants.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  TransactionItem({this.title, this.amount, this.category, this.date});

  final String title;
  final String amount;
  final String category;
  final DateTime date;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 35,
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: FittedBox(
                    child: Text(
                      widget.amount,
                      style: kTransactionTitleAmountStyle,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: kTransactionTitleTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          widget.category,
                          style: kTransactionCategoryTextStyle,
                        ),
                        Text(
                          DateFormat.yMMMd().format(widget.date),
                          style: kTransactionCategoryTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
