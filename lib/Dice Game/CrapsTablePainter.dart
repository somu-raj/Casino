import 'package:flutter/material.dart';

import '../Helper_Constants/colors.dart';

class CrapsTablePainter extends CustomPainter {
  final Function(Offset) onTapCallback;

  CrapsTablePainter({required this.onTapCallback});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.transparent;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Background color
    //paint.color = Colors.black;
    paint.style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Line color golden
    paint.color = colors.whiteTemp;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3;

    final double columnWidth = size.width / 10;
    const double rowHeight = 50;
    const double firstRowHeight = 70; // Increased height for the first row

    final firstRow = [
      _Section(
        const Offset(0, 0),
        Offset(columnWidth * 2, firstRowHeight),
        "Don't Pass Bar",
        onTap: () {
          debugPrint("Don't Pass Bar tapped");
        },
      ),
      _Section(
        Offset(columnWidth * 2, 0),
        Offset(columnWidth * 4, firstRowHeight),
        "Don't\nCome\nBar",
        onTap: () {
          print("Don't Come Bar tapped");
        },
      ),
      _Section(
        Offset(columnWidth * 4, 0),
        Offset(columnWidth * 5, firstRowHeight),
        "4",
        onTap: () {
          print("Number 4 tapped");
        },
      ),
      _Section(
        Offset(columnWidth * 5, 0),
        Offset(columnWidth * 6, firstRowHeight),
        "5",
        onTap: () {
          print("Number 5 tapped");
        },
      ),
      _Section(
        Offset(columnWidth * 6, 0),
        Offset(columnWidth * 7, firstRowHeight),
        "SIX",
        onTap: () {
          print("Number 6 tapped");
        },
      ),
      _Section(
        Offset(columnWidth * 7, 0),
        Offset(columnWidth * 8, firstRowHeight),
        "8",
        onTap: () {
          print("Number 8 tapped");
        },
      ),
      _Section(
        Offset(columnWidth * 8, 0),
        Offset(columnWidth * 9, firstRowHeight),
        "NINE",
        onTap: () {
          print("Number 9 tapped");
        },
      ),
      _Section(
        Offset(columnWidth * 9, 0),
        Offset(columnWidth * 10, firstRowHeight),
        "10",
        onTap: () {
          print("Number 10 tapped");
        },
      ),
    ];

    // Second row: Come
    final secondRow = [
      _Section(const Offset(0, firstRowHeight), Offset(columnWidth * 9, firstRowHeight + rowHeight), "COME", textColor: Colors.red,),
    ];

    // Third row: Numbers 2 and 12 in a card, other numbers with space and "Field" text
    final double cardWidth = columnWidth / 2;
    final thirdRow = [
      _Section(
          Offset(columnWidth * 0.20, firstRowHeight + rowHeight + 9),
          Offset(columnWidth * 0.20 + cardWidth, firstRowHeight + rowHeight + cardWidth + 9),
          "2",
          textColor: Colors.white,
          //backgroundColor: Colors.blueGrey,
          borderColor: Colors.amberAccent,
          borderRadius: 100,onTap: (){
          print("Surrender");
         }),
      _Section(
          Offset(columnWidth * 0, firstRowHeight + rowHeight),
          Offset(columnWidth * 9, firstRowHeight + rowHeight * 2),
          "3     .     4       .      9       .     10      .     11\n                           FIELD",
          textColor: Colors.white),
      _Section(
          Offset(columnWidth * 7.75 - cardWidth, firstRowHeight + rowHeight + 9),
          Offset(columnWidth * 7.75, firstRowHeight + rowHeight + cardWidth + 9),
          "12",

          textColor: Colors.white,
          //backgroundColor: Colors.blueGrey,
          borderColor: Colors.amberAccent,
          borderRadius: 50),

    ];

    // Your existing code with _Section
    final fourthRow = [
      _Section(
        Offset(columnWidth, firstRowHeight + rowHeight * 2),
        const Offset(0, firstRowHeight + rowHeight * 3),
        "6",
        textColor: Colors.red,
        onTap: () {
          print("Number 6 tapped");
        },
      ),
      _Section(
        const Offset(0, firstRowHeight + rowHeight * 2),
        Offset(columnWidth * 9, firstRowHeight + rowHeight * 3),
        "Don't Pass Bar",
      ),
    ];

    final fifthRow = [
      _Section(
        Offset(columnWidth, firstRowHeight + rowHeight * 3),
        const Offset(0, firstRowHeight + rowHeight * 4),
        "8",
        textColor: Colors.red,
        onTap: () {
          print("Number 8 tapped");
        },
      ),
      _Section(
        const Offset(0, firstRowHeight + rowHeight * 3),
        Offset(columnWidth * 9, firstRowHeight + rowHeight * 4),
        "PASS LINE",
      ),
    ];

/*    final fourthRow = [
      _Section(
        Offset(columnWidth, firstRowHeight + rowHeight * 2),
        const Offset(0, firstRowHeight + rowHeight * 3),
        "6",textColor: Colors.red,
        onTap: () {
          print("Number 6 tapped");
        },
      ),
      _Section(
        const Offset(0, firstRowHeight + rowHeight * 2),
        Offset(columnWidth * 9, firstRowHeight + rowHeight * 3),
        "Don't Pass Bar",
      ),
    ];
    final fifthRow = [
      _Section(
        Offset(columnWidth, firstRowHeight + rowHeight * 3),
        const Offset(0, firstRowHeight + rowHeight * 4),
        "8",textColor: Colors.red,
        onTap: () {
          print("Number 8 tapped");
        },
      ),
      _Section(
        const Offset(0, firstRowHeight + rowHeight * 3),
        Offset(columnWidth * 9, firstRowHeight + rowHeight * 4),
        "PASS LINE",
      ),
    ];*/


    final allSections = [
      ...firstRow,
      ...secondRow,
      ...thirdRow,
      ...fourthRow,
      ...fifthRow,
    ];

    for (var section in allSections) {
      drawSection(canvas, section.rect, section.label, section.textColor, section.backgroundColor, section.borderColor, section.borderRadius,);
    }
  }

  void drawSection(Canvas canvas, Rect rect, String text, [Color textColor = Colors.white, Color? backgroundColor, Color? borderColor, double? borderRadius]) {
    final paint = Paint()
      ..color = Colors.amberAccent // Line color golden
      ..style = PaintingStyle.stroke;
    final textPainter = TextPainter(

      text: TextSpan(
        text: text,
        style: TextStyle(
          color: textColor,
          fontSize: 16, // Increase the font size
          fontWeight: FontWeight.bold, // Make the text bold
        ),
      ),

      textDirection: TextDirection.ltr,
    )..layout(maxWidth: rect.width);

    // Draw background if specified
    if (backgroundColor != null) {
      final backgroundPaint = Paint()
        ..color = backgroundColor
        ..style = PaintingStyle.fill;
      canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(borderRadius ?? 20)), backgroundPaint);
    }

    // Draw border if specified
    if (borderColor != null) {
      final borderPaint = Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(borderRadius ?? 20)), borderPaint);
    }

    // Draw border
    if (borderRadius != null) {
      canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(borderRadius)), paint);
    } else {
      canvas.drawRect(rect, paint);
    }

    // Draw text
    textPainter.paint(
      canvas,
      Offset(rect.left + (rect.width - textPainter.width) / 2,
          rect.top + (rect.height - textPainter.height) / 2),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _Section {
  final Offset topLeft;
  final Offset bottomRight;
  final String label;
  final Color textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final Function()? onTap;

  _Section(this.topLeft, this.bottomRight, this.label, {this.textColor = Colors.white, this.backgroundColor, this.borderColor, this.borderRadius,this.onTap});

  Rect get rect => Rect.fromPoints(topLeft, bottomRight);
}





