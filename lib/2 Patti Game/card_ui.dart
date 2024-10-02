import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlayerWidget extends StatelessWidget {
  final String playerName;
  final String playerImage;
  final List<String> cards;
  final bool isCurrentPlayer;
  final (bool, bool, bool) leftRightTop; // (isLeft, isRight, isTop)
  final double amount;
  final bool showCards;

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
    // Creating a list of card widgets
    List<Widget> cardWidgets = cards.map((card) {
      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: SvgPicture.asset(
          showCards
              ? 'assets/Card/svg-cards/$card.svg'
              : 'assets/Card/svg-cards/blue.svg', // Back of card
          width: 123,
          height: 55,
        ),
      );
    }).toList();

    // Display player's amount
    Widget amountWidget = Text(
      '₹$amount',
      style: const TextStyle(color: Colors.white, fontSize: 16),
    );

    // Display player's name
    Widget nameWidget = Text(
      playerName,
      style: const TextStyle(color: Colors.white),
    );

    // Display player's image
    Widget imageWidget = Image.asset(
      playerImage,
      height: 40,
    );

    // Depending on the player's position, arrange widgets
    if (leftRightTop.$2) {
      // Right Positioned Player
      return Row(
        children: [
          const SizedBox(width: 5),
          Transform.rotate(
            angle: 3.1416 / 2, // Rotate the cards vertically
            child: Wrap(children: cardWidgets),
          ),
          Column(
            children: [
              imageWidget,
              amountWidget,
              nameWidget,
            ],
          ),
        ],
      );
    } else if (leftRightTop.$1) {
      // Left Positioned Player
      return Row(
        children: [
          const SizedBox(width: 5),
          Column(
            children: [
              imageWidget,
              amountWidget,
              nameWidget,
            ],
          ),
          Transform.rotate(
            angle: 3.1416 / 2, // Rotate the cards vertically
            child: Wrap(children: cardWidgets),
          ),
        ],
      );
    } else if (leftRightTop.$3) {
      // Top Positioned Player
      return Column(
        children: [
          const SizedBox(height: 5),
          imageWidget,
          amountWidget,
          nameWidget,
          Wrap(children: cardWidgets),
        ],
      );
    } else {
      // Bottom Positioned Player
      return Column(
        children: [
          const SizedBox(height: 5),
          Wrap(children: cardWidgets),
          const SizedBox(height: 5),
          imageWidget,
          const SizedBox(height: 3),
          amountWidget,
          nameWidget,
        ],
      );
    }
  }
}
