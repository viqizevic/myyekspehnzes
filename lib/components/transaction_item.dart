import 'package:flutter/material.dart';
import 'package:myy_expenses/constants.dart';

class TransactionItem extends StatefulWidget {
  TransactionItem({this.title, this.amount, this.category});

  final String title;
  final String amount;
  final String category;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Row(
          children: <Widget>[
            Text(
              widget.amount,
              style: kTransactionTitleAmountStyle,
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
                  Text(
                    widget.category,
                    style: kTransactionCategoryTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
