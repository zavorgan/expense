import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransacionList extends StatelessWidget {
  // TransacionList({Key? key}) : super(key: key);

  final List<Transaction> transactions;
  final Function deleteTx;

  TransacionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    print('build() TansactionList');
    return transactions.isEmpty //если пустой выводим первое условие
        ? LayoutBuilder(builder: (ctx, constraints) {
            //ипользуем допустимы размер

            return Column(
              children: [
                Text(
                  'No transaction',
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            //иначе выводим список транзакций
            itemBuilder: (ctx, index) {
              return TransactionItem(
                  transaction: transactions[index], deleteTx: deleteTx);
            },
            itemCount: transactions.length,
          );
  }
}
