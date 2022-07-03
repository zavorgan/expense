import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expense/widgets/chart.dart';

import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
  //
  //отключение горизонтального экрана
  //
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  //
  runApp(MyApp());
}

// void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                // button: TextStyle(color: Colors.white),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String titleInput;
  // final titleController = TextEditingController();
  // final amountController = TextEditingController();

  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    //переменная последние транзакции
    return _userTransactions.where((tx) {
      //берем все
      return tx.date.isAfter(
        //эта дата до сегодняшнего дня
        DateTime.now().subtract(
          //вычленяем по дате (сечас - 7 дней)
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

=======
    print('build() MyHomePageState');
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
>>>>>>> 875169b011c4b786d9d054c2bb1c48d05beedc2a
    final appBar = AppBar(
      title: Text(
        'Personal Expenses',
        // style: TextStyle(
        //   fontFamily: 'Open Sans',
        // ),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: Icon(Icons.add),
        )
      ],
    );
    final txWidget = Container(
      //высота = запрос размера экрана - аппбар - строка состояния(системная панель) и делить на процент
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: TransacionList(_userTransactions, _deleteTransaction),
    );

    final txListWidget = Container(
      //высота = запрос размера экрана - аппбар - строка состояния(системная панель) и делить на процент
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: TransacionList(_userTransactions, _deleteTransaction),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart'),
<<<<<<< HEAD
                  Switch(
=======
                  Switch.adaptive(
>>>>>>> 875169b011c4b786d9d054c2bb1c48d05beedc2a
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  ),
                ],
              ),
<<<<<<< HEAD
            if (!isLandscape)
              Container(
                //высота = запрос размера экрана - аппбар - строка состояния(системная панель) и делить на процент
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(_recentTransactions),
              ),
            if (!isLandscape) txListWidget,
=======
            //если не горизонт отобразть
            if (!isLandscape)
              Container(
                //высота = запрос размера экрана - аппбар - строка состояния(системная панель) и делить на процент
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(_recentTransactions),
              ),
            //если не горизонт отобразть
            if (!isLandscape) txWidget,
            //если горизонт отобразть
>>>>>>> 875169b011c4b786d9d054c2bb1c48d05beedc2a
            if (isLandscape)
              _showChart
                  ? Container(
                      //высота = запрос размера экрана - аппбар - строка состояния(системная панель) и делить на процент
<<<<<<< HEAD
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: Chart(_recentTransactions),
                    )
                  : txListWidget //передаем чарт за последнюю неделю
            // Container(
            //     //высота = запрос размера экрана - аппбар - строка состояния(системная панель) и делить на процент
            //     height: (MediaQuery.of(context).size.height -
            //             appBar.preferredSize.height -
            //             MediaQuery.of(context).padding.top) *
            //         0.7,
            //     child:
            //         TransacionList(_userTransactions, _deleteTransaction),
            //   ), //передаем все тразации
=======
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: Chart(_recentTransactions),
                    )
                  : txWidget, //передаем чарт за последнюю неделю
            //передаем все тразации
>>>>>>> 875169b011c4b786d9d054c2bb1c48d05beedc2a
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
