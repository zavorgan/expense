import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';
import '../widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      //в скобках начальное значение, перременная которая содежит и третьезначение которое извлекаем
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceAround, //выравнивание в колонке по главной оси
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit
                  .tight, //обернули в контейнер флекс с одинаковым пространством
              child: ChartBar(
                data['day'],
                data['amount'],
                totalSpending ==
                        0.0 //проверка есть ли вообще транзакции, если нет то 0.0 иначе
                    ? 0.0
                    : (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
