import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helper_Constants/colors.dart';

class DiceTableScreen extends StatelessWidget {
  const DiceTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
      Table(
      border: TableBorder.all(color: colors.borderColorDark),
      children: const [
        TableRow(
          children: [
            TableCell(child: Center(child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Don't Pass Bar",style: TextStyle(
                  color: colors.whiteTemp,fontSize: 18,fontWeight: FontWeight.bold
              ),),
            ))),
            TableCell(child: Center(child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Don't Come Bar",style: TextStyle(
                  color: colors.whiteTemp,fontSize: 18,fontWeight: FontWeight.bold
              ),),
            ))),

            TableCell(child: Center(child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("4",style: TextStyle(
                  color: colors.whiteTemp,fontSize: 18,fontWeight: FontWeight.bold
              ),),
            ))),
            TableCell(
              child: IntrinsicWidth(
                child: IntrinsicHeight(
                  child: Center(
                    child: Text('10'),
                  ),
                ),
              ),
            ),
            TableCell(
              child: IntrinsicWidth(
                child: IntrinsicHeight(
                  child: Center(
                    child: Text('11'),
                  ),
                ),
              ),
            ),
            TableCell(
              child: IntrinsicWidth(
                child: IntrinsicHeight(
                  child: Center(
                    child: Text('12'),
                  ),
                ),
              ),
            ),

          ],
        ),
      ],
    ),

          Table(
            border: const TableBorder(
              left: BorderSide(
              color:  colors.borderColorDark
            ),
              right: BorderSide(
              color:  colors.borderColorDark
            ),
              bottom: BorderSide(
              color:  colors.borderColorDark
            ),
                ),
            children: const [
               TableRow(
                children: [
                  TableCell(child: Center(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('COME',style: TextStyle(
                      color: colors.red,fontSize: 20,fontWeight: FontWeight.bold
                    ),),
                  ))),
                ],
              ),

            ],
          ),
        ],
      ),
    );

  }
}
