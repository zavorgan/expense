import 'package:flutter/material.dart';
import '../widgets/adaptive_flat_button.dart';
import 'package:intl/intl.dart';

import 'adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  //новая транзакция
  final _titleController =
      TextEditingController(); //переменная для названия расхода
  final _amountController =
      TextEditingController(); //переменная для потраченной суммы
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enterdAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enterdAmount <= 0 || _selectedDate == null) {
      //проверяем на пустые поля введеные в транзакцию
      return;
    }

    widget.addTx(
      enteredTitle,
      enterdAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            //показать выбор даты
            context: context, //инфа из контекста
            initialDate: DateTime.now(), //начальная дата по умолчанию
            firstDate: DateTime(
                2022), //когда начинается выбор даты (с 1 января 2022 года(можно более точно указать))
            lastDate: DateTime.now()) //конечная дата выбора (сегодня)
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        // иизменить состояние виджета нужно запустить сетстате
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) {
                //   titleInput = val;
                // },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) => amountInput = val,
              ),
              Container(
                height: 80, //отступы
                child: Row(
                  //ряд
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen!'
                            : DateFormat.yMd().format(_selectedDate),
                      ),
                    ), //текстовое поле
                    AdaptiveFlatButton(
                        text: 'Chose Date', handler: _presentDatePicker)
                  ],
                ),
              ),
              FlatButton(
                child: Text(
                  'Add Transaction',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
