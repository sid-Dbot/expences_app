import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Bars extends StatelessWidget {
  final String label;
  final double spentAmt;
  final double pcntSpent;

  Bars(this.label, this.spentAmt, this.pcntSpent);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          Container(
              height: constraints.maxHeight * 0.15,
              child:
                  FittedBox(child: Text('\$${spentAmt.toStringAsFixed(0)}'))),
          SizedBox(
            height: 4,
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10)),
              ),
              FractionallySizedBox(
                heightFactor: pcntSpent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ]),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text(
                label,
              ),
            ),
          )
        ],
      );
    });
  }
}
