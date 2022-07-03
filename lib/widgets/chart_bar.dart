import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  // const ChartBar({Key? key}) : super(key: key);
  final String label; //день недели
  final double spendingAmount; //сумма за день
  final double spendingPctOfTotal; //процент от вей суммы

  const ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    print('build() ChartBar');
    return LayoutBuilder(builder: ((ctx, constraints) {
      // передает ограничения виджета которые можно использовать(его размеры ширина и высота)
      return Column(
        //возврщает виждет который нам надо с ограничениями
        children: <Widget>[
          Container(
            height:
                constraints.maxHeight * 0.15, //относительная высота в процентах
            child: FittedBox(
              //изменяет содержимое в пределах области
              child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
            ),
          ),
          SizedBox(
            height:
                constraints.maxHeight * 0.05, //относительная высота в процентах
          ),
          Container(
            height:
                constraints.maxHeight * 0.6, //относительная высота в процентах
            width: 10,
            child: Stack(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(
            height:
                constraints.maxHeight * 0.05, //относительная высота в процентах
          ),
          Container(
              height: constraints.maxHeight *
                  0.15, //относительная высота в процентах
              child: FittedBox(child: Text(label))),
        ],
      );
    }));
  }
}
