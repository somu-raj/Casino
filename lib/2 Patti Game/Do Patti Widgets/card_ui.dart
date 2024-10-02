import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
class PlayerWidget extends StatelessWidget {
  final String playerName;
  final String playerImage;
  final List<String> cards;
  final bool isCurrentPlayer;
  final (bool, bool, bool) leftRightTop;
  final double amount;
  final bool showCards; // New parameter to control card visibility

  const PlayerWidget({
    super.key,
    required this.playerName,
    required this.playerImage,
    required this.cards,
    required this.isCurrentPlayer,
    required this.leftRightTop,
    required this.amount,
    this.showCards = false,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> cardWidgets = cards.map((card) {
      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: SvgPicture.asset(
          showCards
              ? 'assets/Card/svg-cards/$card.svg'
              : 'assets/Card/svg-cards/blue.svg',
          width: 123,
          height: 55,
        ),
      );
    }).toList();

    Widget amountWidget = Text(
      '\₹$amount',
      style: const TextStyle(color: Colors.white, fontSize: 16),
    );

    if (leftRightTop.$2) {
      return Row(
        children: [
          const SizedBox(width: 5),
          Transform.rotate(angle: 3.1416 / 2, child: Wrap(children: cardWidgets)),
          Column(
            children: [
              Image.asset(playerImage, height: 40),
              amountWidget,
              Text(playerName, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ],
      );
    } else if (leftRightTop.$1) {
      return Row(
        children: [
          const SizedBox(width: 5),
          Column(
            children: [
              Image.asset(playerImage, height: 40),
              amountWidget,
              Text(playerName, style: const TextStyle(color: Colors.white)),
            ],
          ),
          Transform.rotate(angle: 3.1416 / 2, child: Wrap(children: cardWidgets)),
        ],
      );
    } else if (leftRightTop.$3) {
      return Column(
        children: [
          const SizedBox(height: 5),
          Image.asset(playerImage, height: 40),
          amountWidget,
          Text(playerName, style: const TextStyle(color: Colors.white)),
          Wrap(children: cardWidgets),
        ],
      );
    } else {
      return Column(
        children: [
          const SizedBox(height: 5),
          Wrap(children: cardWidgets),
          const SizedBox(height: 5),
          Image.asset(playerImage, height: 40),
          const SizedBox(height: 3),
          amountWidget,
          //Text(playerName, style: const TextStyle(color: Colors.white)),
        ],
      );
    }
  }
}






