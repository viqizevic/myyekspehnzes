import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  DateTime _selectedDate = DateTime.now();
  bool _inputIsInvalid = false;

  void _submitData() {
    String enteredTitle = titleController.text;
    double enteredAmount = 0;
    if (amountController.text.isNotEmpty) {
      enteredAmount = double.parse(amountController.text);
      enteredAmount = double.parse(enteredAmount.toStringAsFixed(2));
    }
    String enteredCategory = categoryController.text;
    if (enteredCategory.isEmpty) {
      enteredCategory = "Uncategorized";
    }

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      setState(() {
        _inputIsInvalid = true;
      });
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      enteredCategory,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
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
          Container(
            height: 70,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No Date Chosen.'
                        : 'Date: ${DateFormat.MMMEd().format(_selectedDate)}',
                  ),
                ),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  child: Text(
                    'Choose another Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: _presentDatePicker,
                ),
              ],
            ),
          ),
          Visibility(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Please enter Title, Amount and Date.'),
            ),
            visible: _inputIsInvalid,
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
