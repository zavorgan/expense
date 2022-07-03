import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

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
                SizedBox(
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
              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 6, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                          child: Text('\$${transactions[index].amount}')),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 360
                      ? FlatButton.icon(
                          onPressed: () => deleteTx(transactions[index].id),
                          label: Text(
                            'Delete',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          textColor: Theme.of(context).errorColor,
                          icon: Icon(
                            Icons.delete,
                          ),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => deleteTx(transactions[index]
                              .id), // передаются значения, поэтому передаем через анонимную функцию
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}


// Card(
//                   child: Row(
//                     children: <Widget>[
//                       Container(
//                         margin: EdgeInsets.symmetric(
//                           vertical: 10,
//                           horizontal: 15,
//                         ),
//                         decoration: BoxDecoration(
//                             border: Border.all(
//                           width: 2,
//                           color: Theme.of(context).primaryColor,
//                         )),
//                         padding: EdgeInsets.all(10),
//                         child: Text(
//                           '\$${transactions[index].amount.toStringAsFixed(2)}',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                             color: Theme.of(context).primaryColor,
//                           ),
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Padding(
//                             padding: const EdgeInsets.all(5.0),
//                             child: Text(
//                               transactions[index].title,
//                               style: TextStyle(
//                                 color: Colors.black87,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(5.0),
//                             child: Text(
//                               DateFormat.yMMMMd()
//                                   .format(transactions[index].date),
//                               style: TextStyle(
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 );