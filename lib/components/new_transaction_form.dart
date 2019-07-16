import 'package:flutter/material.dart';

class NewTransactionForm extends StatefulWidget {
  NewTransactionForm({
    @required this.addTx,
  });

  final Function addTx;

  @override
  _NewTransactionFormState createState() => _NewTransactionFormState();
}

class _NewTransactionFormState extends State<NewTransactionForm> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final categoryController = TextEditingController();

  void _submitData() {
    String enteredTitle = titleController.text;
    double enteredAmount = double.parse(amountController.text);
    enteredAmount = double.parse(enteredAmount.toStringAsFixed(2));
    String enteredCategory = categoryController.text;
    if (enteredCategory.isEmpty) {
      enteredCategory = "Uncategorized";
    }

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      enteredCategory,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: titleController,
            onSubmitted: (_) => _submitData(),
            // onChanged: (val) {
            //   titleInput = val;
            // },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            controller: amountController,
            keyboardType: TextInputType.numberWithOptions(
              signed: false,
              decimal: true,
            ),
            onSubmitted: (_) => _submitData(),
            // onChanged: (val) => amountInput = val,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Category'),
            controller: categoryController,
            onSubmitted: (_) => _submitData(),
            // onChanged: (val) => categoryInput = val,
          ),
          FlatButton(
            child: Text('Add Transaction'),
            textColor: Colors.purple,
            onPressed: _submitData,
          ),
        ],
      ),
    );
  }
}
