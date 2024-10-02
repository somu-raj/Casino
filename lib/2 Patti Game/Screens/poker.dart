import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/services.dart';

import '../../Helper_Constants/Images_path.dart';
import '../../Helper_Constants/colors.dart';
import '../../audio_controller.dart';
import '../../utils.dart';
import '../Controller/controller.dart';
import '../Do Patti Widgets/card_ui.dart';
// Replace with your actual import

// class PokerTable extends StatefulWidget {
//   const PokerTable(
//       {super.key,
//       required this.pokerController,
//       this.audioController,
//       required this.userName});
//
//   final PokerController pokerController;
//   final AudioController? audioController;
//   final String userName;
//
//   @override
//   _PokerTableState createState() => _PokerTableState();
// }
//
// class _PokerTableState extends State<PokerTable> {
//   late IO.Socket socket;
//   bool showPlayer4Cards = false;
//   bool showRemainingCards = false;
//   List<String> remainingCards = [];
//   List<String> selectedCards = [];
//
//   @override
//   void initState() {
//     super.initState();
//     for (int i = 1; i < 14; i++) {
//       String? card;
//       switch (i) {
//         case 1:
//           card = 'ace';
//           break;
//         case 11:
//           card = 'jack';
//           break;
//         case 12:
//           card = 'queen';
//           break;
//         case 13:
//           card = 'king';
//           break;
//         default:
//           card = "$i";
//           break;
//       }
//       for (int j = 0; j < 4; j++) {
//         String? suit;
//         switch (j) {
//           case 0:
//             suit = 'clubs';
//             break;
//           case 1:
//             suit = 'diamonds';
//             break;
//           case 2:
//             suit = 'hearts';
//             break;
//           default:
//             suit = "spades";
//             break;
//         }
//         widget.pokerController.cardNumber.add('${card}_of_$suit');
//       }
//     }
//     remainingCards = List.from(widget.pokerController.cardNumber);
//     widget.pokerController.dealCards();
//     // connectToServer();
//   }
//
//   void connectToServer() {
//     socket = IO.io('http://localhost:3000', <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': false,
//     });
//
//     socket.connect();
//
//     socket.on('connect', (_) {
//       print('connected to server');
//       socket.emit('join', 'poker-room'); // joining the poker room
//     });
//
//     socket.on('disconnect', (_) {
//       print('disconnected from server');
//     });
//
//     socket.on('player_joined', (data) {
//       print('Player joined: $data');
//     });
//
//     socket.on('card_distribution', (data) {
//       print('Cards distributed: $data');
//     });
//
//     socket.on('bet', (data) {
//       print('Bet placed: $data');
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//       ),
//     );
//     SystemChrome.setEnabledSystemUIMode(
//       SystemUiMode.manual,
//       overlays: [SystemUiOverlay.bottom],
//     );
//     return Scaffold(
//       body: Stack(
//         alignment: Alignment.center,
//         clipBehavior: Clip.none,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(colors: [
//                 colors.secondary.withOpacity(0.9),
//                 colors.primary,
//                 colors.secondary.withOpacity(0.9),
//               ]),
//               image: const DecorationImage(
//                 image: AssetImage(ImagesPath.backGroundImage),
//                 fit: BoxFit.fill,
//               ),
//             ),
//           ),
//           Stack(
//             alignment: Alignment.center,
//             clipBehavior: Clip.none,
//             children: [
//               Container(
//                 width: 300,
//                 height: 140,
//                 decoration: BoxDecoration(
//                   color: colors.primary,
//                   border: Border.all(color: const Color(0XFF623412), width: 3),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Color(0XFF623412),
//                       blurRadius: 3.0,
//                       spreadRadius: 1.0,
//                     )
//                   ],
//                   borderRadius: BorderRadius.circular(75),
//                 ),
//                 child: const Center(
//                   child: Text(
//                     'Poker Table',
//                     style: TextStyle(color: Colors.white, fontSize: 20),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: -110,
//                 child: PlayerWidget(
//                   playerImage: widget.pokerController.playersImage[0],
//                   playerName: widget.pokerController.players[0],
//                   cards: widget.pokerController.playerCards[0],
//                   isCurrentPlayer:
//                       widget.pokerController.currentPlayerIndex == 0,
//                   leftRightTop: (false, false, true),
//                   amount: widget.pokerController.playerAmounts[0],
//                 ),
//               ),
//               Positioned(
//                 left: -80,
//                 top: 40,
//                 child: PlayerWidget(
//                   playerName: widget.pokerController.players[1],
//                   playerImage: widget.pokerController.playersImage[1],
//                   cards: widget.pokerController.playerCards[1],
//                   isCurrentPlayer:
//                       widget.pokerController.currentPlayerIndex == 1,
//                   leftRightTop: (true, false, false),
//                   amount: widget.pokerController.playerAmounts[1],
//                 ),
//               ),
//               Positioned(
//                 right: -80,
//                 top: 40,
//                 child: PlayerWidget(
//                   playerName: widget.pokerController.players[2],
//                   playerImage: widget.pokerController.playersImage[2],
//                   cards: widget.pokerController.playerCards[2],
//                   isCurrentPlayer:
//                       widget.pokerController.currentPlayerIndex == 2,
//                   leftRightTop: (false, true, false),
//                   amount: widget.pokerController.playerAmounts[2],
//                 ),
//               ),
//               Positioned(
//                 bottom: -110,
//                 child: Obx(() {
//                   return PlayerWidget(
//                     playerName: /*widget.pokerController.isProfileUpdated.value
//                         ? (widget.pokerController.getProfileModel?.data.first.username ?? "")
//                         : */
//                         widget.pokerController.players[3],
//                     playerImage: widget.pokerController.playersImage[3],
//                     cards: widget.pokerController.playerCards[3],
//                     isCurrentPlayer:
//                         widget.pokerController.currentPlayerIndex == 3,
//                     leftRightTop: (false, false, false),
//                     amount: widget.pokerController.playerAmounts[3],
//                     showCards: showPlayer4Cards,
//                   );
//                 }),
//               ),
//             ],
//           ),
//           /*  if (showRemainingCards)
//             Positioned(
//               bottom: 60,
//               left: 0,
//               right: 0,
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: remainingCards.map((card) {
//                     // To ensure only remaining cards are shown
//                     if (!widget.pokerController.dealtCards.contains(card)) {
//                       return GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             // Toggle card selection
//                             if (selectedCards.contains(card)) {
//                               selectedCards.remove(card);
//                             } else {
//                               selectedCards.add(card);
//                             }
//                           });
//                         },
//                         child: Container(
//                           margin:  const EdgeInsets.symmetric(horizontal: 5),
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: selectedCards.contains(card)
//                                   ? colors.borderColorLight // Highlight selected card
//                                   : Colors.transparent,
//                               width: 2,
//                             ),
//                             borderRadius: BorderRadius.circular(2),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/Card/svg-cards/$card.svg',
//                             width: 123,
//                             height: 55,
//                           ),
//                         ),
//                       );
//                     } else {
//                       return const SizedBox.shrink();
//                     }
//                   }).toList(),
//                 ),
//               ),
//             ),*/
//
//           if (showRemainingCards)
//             Positioned(
//               bottom: 60,
//               left: 0,
//               right: 0,
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: remainingCards.map((card) {
//                     // To ensure only remaining cards are shown
//                     if (!widget.pokerController.dealtCards.contains(card)) {
//                       return GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             // Clear previously selected card and select the new one
//                             selectedCards.clear();
//                             selectedCards.add(card);
//                           });
//                         },
//                         child: Container(
//                           margin: const EdgeInsets.symmetric(horizontal: 5),
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: selectedCards.contains(card)
//                                   ? colors
//                                       .borderColorLight // Highlight selected card
//                                   : Colors.transparent,
//                               width: 2,
//                             ),
//                             borderRadius: BorderRadius.circular(2),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/Card/svg-cards/$card.svg',
//                             width: 123,
//                             height: 55,
//                           ),
//                         ),
//                       );
//                     } else {
//                       return const SizedBox.shrink();
//                     }
//                   }).toList(),
//                 ),
//               ),
//             ),
//           Positioned(
//             bottom: 10,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         Utils.mySnackBar(title: "isn't my side pack");
//                       },
//                       child: Container(
//                         height: 40,
//                         width: 60,
//                         decoration: BoxDecoration(
//                           color: colors.red.withOpacity(0.4),
//                           border: Border.all(
//                               color: colors.borderColorLight, width: 2),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: const Center(
//                           child: Text("Pack",
//                               style: TextStyle(color: colors.whiteTemp)),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 20),
//                     InkWell(
//                       onTap: () {
//                         setState(() {
//                           showPlayer4Cards = !showPlayer4Cards;
//                         });
//                       },
//                       child: Container(
//                         height: 40,
//                         width: 80,
//                         decoration: BoxDecoration(
//                           color: colors.primary.withOpacity(0.4),
//                           border: Border.all(
//                               color: colors.borderColorLight, width: 2),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: const Center(
//                           child: Text("Show",
//                               style: TextStyle(color: colors.whiteTemp)),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(width: 200),
//                 Row(
//                   children: [
//                     Container(
//                       width: 90,
//                       height: 40,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                             color: colors.borderColorLight, width: 2),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: Obx(
//                           () => Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               widget.pokerController.amount == 5
//                                   ? const SizedBox.shrink()
//                                   : InkWell(
//                                       onTap: () {
//                                         widget.pokerController
//                                             .decrementAmount();
//                                       },
//                                       child: const Icon(Icons.remove,
//                                           color: colors.whiteTemp),
//                                     ),
//                               Text(
//                                 '${widget.pokerController.amount}',
//                                 style: const TextStyle(
//                                     fontSize: 20.0, color: colors.whiteTemp),
//                               ),
//                               widget.pokerController.amount == 500
//                                   ? const SizedBox.shrink()
//                                   : InkWell(
//                                       onTap: () {
//                                         widget.pokerController
//                                             .incrementAmount();
//                                       },
//                                       child: const Icon(Icons.add,
//                                           color: colors.whiteTemp),
//                                     ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 20),
//                     InkWell(
//                       onTap: () {
//                         Utils.mySnackBar(title: "This is a my chal");
//                       },
//                       child: Container(
//                         height: 40,
//                         width: 60,
//                         decoration: BoxDecoration(
//                           color: colors.primary.withOpacity(0.4),
//                           border: Border.all(
//                               color: colors.borderColorLight, width: 2),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: const Center(
//                           child: Text("Chal",
//                               style: TextStyle(color: colors.whiteTemp)),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 20),
//                     InkWell(
//                       onTap: () {
//                         setState(() {
//                           showRemainingCards = !showRemainingCards;
//                           // Assuming the cards dealt are removed from the remainingCards list
//                           /*remainingCards = widget.pokerController.cardNumber
//                               .where((card) => !widget.pokerController.dealtCards.contains(card))
//                               .toList();*/
//                         });
//                       },
//                       child: Container(
//                         height: 40,
//                         width: 100,
//                         decoration: BoxDecoration(
//                           color: colors.primary.withOpacity(0.4),
//                           border: Border.all(
//                               color: colors.borderColorLight, width: 2),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: const Center(
//                           child: Text("Select Card",
//                               style: TextStyle(color: colors.whiteTemp)),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     widget.pokerController.playerCards = [[], [], [], []];
//     socket.dispose();
//     super.dispose();
//   }
// }


// class PokerTable extends StatefulWidget {
//   const PokerTable(
//       {super.key,
//         required this.pokerController,
//         this.audioController,
//         required this.userName});
//
//   final PokerController pokerController;
//   final AudioController? audioController;
//   final String userName;
//
//   @override
//   _PokerTableState createState() => _PokerTableState();
// }
//
// class _PokerTableState extends State<PokerTable> {
//   late IO.Socket socket;
//   bool showPlayer4Cards = false;
//   bool showRemainingCards = false;
//   List<String> remainingCards = [];
//   List<String> selectedCards = [];
//
//   @override
//   void initState() {
//     super.initState();
//     for (int i = 1; i < 14; i++) {
//       String? card;
//       switch (i) {
//         case 1:
//           card = 'ace';
//           break;
//         case 11:
//           card = 'jack';
//           break;
//         case 12:
//           card = 'queen';
//           break;
//         case 13:
//           card = 'king';
//           break;
//         default:
//           card = "$i";
//           break;
//       }
//       for (int j = 0; j < 4; j++) {
//         String? suit;
//         switch (j) {
//           case 0:
//             suit = 'clubs';
//             break;
//           case 1:
//             suit = 'diamonds';
//             break;
//           case 2:
//             suit = 'hearts';
//             break;
//           default:
//             suit = "spades";
//             break;
//         }
//         widget.pokerController.cardNumber.add('${card}_of_$suit');
//       }
//     }
//     widget.pokerController.dealCards();
//     remainingCards = widget.pokerController.getRemainingCards();
//     // connectToServer();
//   }
//
//   void connectToServer() {
//     socket = IO.io('http://localhost:3000', <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': false,
//     });
//
//     socket.connect();
//
//     socket.on('connect', (_) {
//       print('connected to server');
//       socket.emit('join', 'poker-room'); // joining the poker room
//     });
//
//     socket.on('disconnect', (_) {
//       print('disconnected from server');
//     });
//
//     socket.on('player_joined', (data) {
//       print('Player joined: $data');
//     });
//
//     socket.on('card_distribution', (data) {
//       print('Cards distributed: $data');
//     });
//
//     socket.on('bet', (data) {
//       print('Bet placed: $data');
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//       ),
//     );
//     SystemChrome.setEnabledSystemUIMode(
//       SystemUiMode.manual,
//       overlays: [SystemUiOverlay.bottom],
//     );
//     return Scaffold(
//       body: Stack(
//         alignment: Alignment.center,
//         clipBehavior: Clip.none,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(colors: [
//                 colors.secondary.withOpacity(0.9),
//                 colors.primary,
//                 colors.secondary.withOpacity(0.9),
//               ]),
//               image: const DecorationImage(
//                 image: AssetImage(ImagesPath.backGroundImage),
//                 fit: BoxFit.fill,
//               ),
//             ),
//           ),
//           Stack(
//             alignment: Alignment.center,
//             clipBehavior: Clip.none,
//             children: [
//               Container(
//                 width: 300,
//                 height: 140,
//                 decoration: BoxDecoration(
//                   color: colors.primary,
//                   border: Border.all(color: const Color(0XFF623412), width: 3),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Color(0XFF623412),
//                       blurRadius: 3.0,
//                       spreadRadius: 1.0,
//                     )
//                   ],
//                   borderRadius: BorderRadius.circular(75),
//                 ),
//                 child: const Center(
//                   child: Text(
//                     'Poker Table',
//                     style: TextStyle(color: Colors.white, fontSize: 20),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: -110,
//                 child: PlayerWidget(
//                   playerImage: widget.pokerController.playersImage[0],
//                   playerName: widget.pokerController.players[0],
//                   cards: widget.pokerController.playerCards[0],
//                   isCurrentPlayer:
//                   widget.pokerController.currentPlayerIndex == 0,
//                   leftRightTop: (false, false, true),
//                   amount: widget.pokerController.playerAmounts[0],
//                 ),
//               ),
//               Positioned(
//                 left: -80,
//                 top: 40,
//                 child: PlayerWidget(
//                   playerName: widget.pokerController.players[1],
//                   playerImage: widget.pokerController.playersImage[1],
//                   cards: widget.pokerController.playerCards[1],
//                   isCurrentPlayer:
//                   widget.pokerController.currentPlayerIndex == 1,
//                   leftRightTop: (true, false, false),
//                   amount: widget.pokerController.playerAmounts[1],
//                 ),
//               ),
//               Positioned(
//                 right: -80,
//                 top: 40,
//                 child: PlayerWidget(
//                   playerName: widget.pokerController.players[2],
//                   playerImage: widget.pokerController.playersImage[2],
//                   cards: widget.pokerController.playerCards[2],
//                   isCurrentPlayer:
//                   widget.pokerController.currentPlayerIndex == 2,
//                   leftRightTop: (false, true, false),
//                   amount: widget.pokerController.playerAmounts[2],
//                 ),
//               ),
//               Positioned(
//                 bottom: -110,
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       showPlayer4Cards = !showPlayer4Cards;
//                     });
//                   },
//                   child: PlayerWidget(
//                     playerName: widget.pokerController.players[3],
//                     playerImage: widget.pokerController.playersImage[3],
//                     cards: widget.pokerController.playerCards[3],
//                     isCurrentPlayer:
//                     widget.pokerController.currentPlayerIndex == 3,
//                     leftRightTop: (false, false, false),
//                     amount: widget.pokerController.playerAmounts[3],
//                     showCards: showPlayer4Cards,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: -200,
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       showRemainingCards = !showRemainingCards;
//                     });
//                   },
//                   child: Container(
//                     width: 200,
//                     height: 50,
//                     color: Colors.blue,
//                     child: const Center(
//                       child: Text(
//                         'Select Card',
//                         style: TextStyle(color: Colors.white, fontSize: 20),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               if (showRemainingCards)
//                 Positioned(
//                   bottom: -220,
//                   child: SizedBox(
//                     height: 120,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: remainingCards.length,
//                       itemBuilder: (context, index) {
//                         String card = remainingCards[index];
//                         bool isSelected = selectedCards.contains(card);
//                         return GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               if (isSelected) {
//                                 selectedCards.remove(card);
//                               } else {
//                                 selectedCards.add(card);
//                               }
//                             });
//                           },
//                           child: Container(
//                             width: 80,
//                             margin: const EdgeInsets.symmetric(horizontal: 4),
//                             decoration: BoxDecoration(
//                               color: isSelected ? Colors.red : Colors.white,
//                               borderRadius: BorderRadius.circular(8),
//                               border: Border.all(color: Colors.black),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 card,
//                                 style: TextStyle(
//                                   color: isSelected
//                                       ? Colors.white
//                                       : Colors.black,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }



/*class PokerTable extends StatefulWidget {
  const PokerTable({super.key, required this.pokerController, this.audioController, required this.userName});

  final PokerController pokerController;
  final AudioController? audioController;
  final String userName;

  @override
  _PokerTableState createState() => _PokerTableState();
}

class _PokerTableState extends State<PokerTable> {
  late IO.Socket socket;
  bool showPlayer4Cards = false;
  bool showRemainingCards = false;
  List<String> remainingCards = [];
  List<String> selectedCards = [];

  @override
  void initState() {
    super.initState();
    for (int i = 1; i < 14; i++) {
      String? card;
      switch (i) {
        case 1:
          card = 'ace';
          break;
        case 11:
          card = 'jack';
          break;
        case 12:
          card = 'queen';
          break;
        case 13:
          card = 'king';
          break;
        default:
          card = "$i";
          break;
      }
      for (int j = 0; j < 4; j++) {
        String? suit;
        switch (j) {
          case 0:
            suit = 'clubs';
            break;
          case 1:
            suit = 'diamonds';
            break;
          case 2:
            suit = 'hearts';
            break;
          default:
            suit = "spades";
            break;
        }
        widget.pokerController.cardNumber.add('${card}_of_$suit');
      }
    }
    remainingCards = List.from(widget.pokerController.cardNumber);
    remainingCards.shuffle();  // Shuffle the remaining cards
    widget.pokerController.dealCards();
    // connectToServer();
  }

  void connectToServer() {
    socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.on('connect', (_) {
      print('connected to server');
      socket.emit('join', 'poker-room'); // joining the poker room
    });

    socket.on('disconnect', (_) {
      print('disconnected from server');
    });

    socket.on('player_joined', (data) {
      print('Player joined: $data');
    });

    socket.on('card_distribution', (data) {
      print('Cards distributed: $data');
    });

    socket.on('bet', (data) {
      print('Bet placed: $data');
    });
  }

  void toggleShowRemainingCards() {
    setState(() {
      showRemainingCards = !showRemainingCards;
      if (showRemainingCards) {
        remainingCards.shuffle();  // Shuffle the cards each time they are shown
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom],
    );
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                colors.secondary.withOpacity(0.9),
                colors.primary,
                colors.secondary.withOpacity(0.9),
              ]),
              image: const DecorationImage(
                image: AssetImage(ImagesPath.backGroundImage),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 300,
                height: 140,
                decoration: BoxDecoration(
                  color: colors.primary,
                  border: Border.all(color: const Color(0XFF623412), width: 3),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0XFF623412),
                      blurRadius: 3.0,
                      spreadRadius: 1.0,
                    )
                  ],
                  borderRadius: BorderRadius.circular(75),
                ),
                child: const Center(
                  child: Text(
                    'Poker Table',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Positioned(
                top: -110,
                child: PlayerWidget(
                  playerImage: widget.pokerController.playersImage[0],
                  playerName: widget.pokerController.players[0],
                  cards: widget.pokerController.playerCards[0],
                  isCurrentPlayer:
                  widget.pokerController.currentPlayerIndex == 0,
                  leftRightTop: (false, false, true),
                  amount: widget.pokerController.playerAmounts[0],
                ),
              ),
              Positioned(
                left: -80,
                top: 40,
                child: PlayerWidget(
                  playerName: widget.pokerController.players[1],
                  playerImage: widget.pokerController.playersImage[1],
                  cards: widget.pokerController.playerCards[1],
                  isCurrentPlayer:
                  widget.pokerController.currentPlayerIndex == 1,
                  leftRightTop: (true, false, false),
                  amount: widget.pokerController.playerAmounts[1],
                ),
              ),
              Positioned(
                right: -80,
                top: 40,
                child: PlayerWidget(
                  playerName: widget.pokerController.players[2],
                  playerImage: widget.pokerController.playersImage[2],
                  cards: widget.pokerController.playerCards[2],
                  isCurrentPlayer:
                  widget.pokerController.currentPlayerIndex == 2,
                  leftRightTop: (false, true, false),
                  amount: widget.pokerController.playerAmounts[2],
                ),
              ),
              Positioned(
                bottom: -110,
                child: Obx(() {
                  return PlayerWidget(
                    playerName: widget.pokerController.isProfileUpdated.value
                        ? (widget.pokerController.getProfileModel?.data.first.username ?? "")
                        :
                    widget.pokerController.players[3],
                    playerImage: widget.pokerController.playersImage[3],
                    cards: widget.pokerController.playerCards[3],
                    isCurrentPlayer:
                    widget.pokerController.currentPlayerIndex == 3,
                    leftRightTop: (false, false, false),
                    amount: widget.pokerController.playerAmounts[3],
                    showCards: showPlayer4Cards,
                  );
                }),
              ),
            ],
          ),
          if (showRemainingCards)
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: remainingCards.map((card) {
                    if (!widget.pokerController.dealtCards.contains(card)) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCards.clear();
                            selectedCards.add(card);
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedCards.contains(card)
                                  ? colors.borderColorLight
                                  : Colors.transparent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: SvgPicture.asset(
                            'assets/Card/svg-cards/$card.svg',
                            width: 123,
                            height: 55,
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }).toList(),
                ),
              ),
            ),
          Positioned(
            bottom: 10,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Utils.mySnackBar(title: "isn't my side pack");
                      },
                      child: Container(
                        height: 40,
                        width: 60,
                        decoration: BoxDecoration(
                          color: colors.red.withOpacity(0.4),
                          border: Border.all(
                              color: colors.borderColorLight, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text("Pack",
                              style: TextStyle(color: colors.whiteTemp)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        setState(() {
                          showPlayer4Cards = !showPlayer4Cards;
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          color: colors.primary.withOpacity(0.4),
                          border: Border.all(
                              color: colors.borderColorLight, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text("Show",
                              style: TextStyle(color: colors.whiteTemp)),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 90,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: colors.borderColorLight, width: 2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Obx(
                              () => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              widget.pokerController.amount == 5
                                  ? const SizedBox.shrink()
                                  : InkWell(
                                onTap: () {
                                  widget.pokerController
                                      .decrementAmount();
                                },
                                child: const Icon(Icons.remove,
                                    color: colors.whiteTemp),
                              ),
                              Text(
                                '${widget.pokerController.amount}',
                                style: const TextStyle(
                                    fontSize: 20.0, color: colors.whiteTemp),
                              ),
                              widget.pokerController.amount == 500
                                  ? const SizedBox.shrink()
                                  : InkWell(
                                onTap: () {
                                  widget.pokerController
                                      .incrementAmount();
                                },
                                child: const Icon(Icons.add,
                                    color: colors.whiteTemp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        Utils.mySnackBar(title: "This is a my chal");
                      },
                      child: Container(
                        height: 40,
                        width: 60,
                        decoration: BoxDecoration(
                          color: colors.primary.withOpacity(0.4),
                          border: Border.all(
                              color: colors.borderColorLight, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text("Chal",
                              style: TextStyle(color: colors.whiteTemp)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: toggleShowRemainingCards,
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          color: colors.primary.withOpacity(0.4),
                          border: Border.all(
                              color: colors.borderColorLight, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text("Select Card",
                              style: TextStyle(color: colors.whiteTemp)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.pokerController.playerCards = [[], [], [], []];
    socket.dispose();
    super.dispose();
  }
}*/

// class PokerTable extends StatefulWidget {
//   const PokerTable({super.key, required this.pokerController, this.audioController, required this.userName});
//
//   final PokerController pokerController;
//   final AudioController? audioController;
//   final String userName;
//
//   @override
//   _PokerTableState createState() => _PokerTableState();
// }
//
// class _PokerTableState extends State<PokerTable> {
//   late IO.Socket socket;
//   bool showPlayer4Cards = false;
//   bool showRemainingCards = false;
//   List<String> remainingCards = [];
//   List<String> selectedCards = [];
//
//   @override
//   void initState() {
//     super.initState();
//     for (int i = 1; i < 14; i++) {
//       String? card;
//       switch (i) {
//         case 1:
//           card = 'ace';
//           break;
//         case 11:
//           card = 'jack';
//           break;
//         case 12:
//           card = 'queen';
//           break;
//         case 13:
//           card = 'king';
//           break;
//         default:
//           card = "$i";
//           break;
//       }
//       for (int j = 0; j < 4; j++) {
//         String? suit;
//         switch (j) {
//           case 0:
//             suit = 'clubs';
//             break;
//           case 1:
//             suit = 'diamonds';
//             break;
//           case 2:
//             suit = 'hearts';
//             break;
//           default:
//             suit = "spades";
//             break;
//         }
//         widget.pokerController.cardNumber.add('${card}_of_$suit');
//       }
//     }
//     remainingCards = List.from(widget.pokerController.cardNumber);
//     remainingCards.shuffle();  // Shuffle the remaining cards
//     widget.pokerController.dealCards();
//     // connectToServer();
//   }
//
//   void connectToServer() {
//     socket = IO.io('http://localhost:3000', <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': false,
//     });
//
//     socket.connect();
//
//     socket.on('connect', (_) {
//       print('connected to server');
//       socket.emit('join', 'poker-room'); // joining the poker room
//     });
//
//     socket.on('disconnect', (_) {
//       print('disconnected from server');
//     });
//
//     socket.on('player_joined', (data) {
//       print('Player joined: $data');
//     });
//
//     socket.on('card_distribution', (data) {
//       print('Cards distributed: $data');
//     });
//
//     socket.on('bet', (data) {
//       print('Bet placed: $data');
//     });
//   }
//
//   void toggleShowRemainingCards() {
//     setState(() {
//       showRemainingCards = !showRemainingCards;
//       if (showRemainingCards) {
//         remainingCards.shuffle();  // Shuffle the cards each time they are shown
//       }
//     });
//   }
//
//   void addSelectedCardToPlayer4() {
//     setState(() {
//       if (selectedCards.isNotEmpty && widget.pokerController.playerCards[3].length < 3) {
//         widget.pokerController.playerCards[3].add(selectedCards[0]);
//         remainingCards.remove(selectedCards[0]);
//         selectedCards.clear();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//       ),
//     );
//     SystemChrome.setEnabledSystemUIMode(
//       SystemUiMode.manual,
//       overlays: [SystemUiOverlay.bottom],
//     );
//     return Scaffold(
//       body: Stack(
//         alignment: Alignment.center,
//         clipBehavior: Clip.none,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(colors: [
//                 colors.secondary.withOpacity(0.9),
//                 colors.primary,
//                 colors.secondary.withOpacity(0.9),
//               ]),
//               image: const DecorationImage(
//                 image: AssetImage(ImagesPath.backGroundImage),
//                 fit: BoxFit.fill,
//               ),
//             ),
//           ),
//           Stack(
//             alignment: Alignment.center,
//             clipBehavior: Clip.none,
//             children: [
//               Container(
//                 width: 300,
//                 height: 140,
//                 decoration: BoxDecoration(
//                   color: colors.primary,
//                   border: Border.all(color: const Color(0XFF623412), width: 3),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Color(0XFF623412),
//                       blurRadius: 3.0,
//                       spreadRadius: 1.0,
//                     )
//                   ],
//                   borderRadius: BorderRadius.circular(75),
//                 ),
//                 child: const Center(
//                   child: Text(
//                     'Poker Table',
//                     style: TextStyle(color: Colors.white, fontSize: 20),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: -110,
//                 child: PlayerWidget(
//                   playerImage: widget.pokerController.playersImage[0],
//                   playerName: widget.pokerController.players[0],
//                   cards: widget.pokerController.playerCards[0],
//                   isCurrentPlayer: widget.pokerController.currentPlayerIndex == 0,
//                   leftRightTop: (false, false, true),
//                   amount: widget.pokerController.playerAmounts[0],
//                 ),
//               ),
//               Positioned(
//                 left: -80,
//                 top: 40,
//                 child: PlayerWidget(
//                   playerName: widget.pokerController.players[1],
//                   playerImage: widget.pokerController.playersImage[1],
//                   cards: widget.pokerController.playerCards[1],
//                   isCurrentPlayer: widget.pokerController.currentPlayerIndex == 1,
//                   leftRightTop: (true, false, false),
//                   amount: widget.pokerController.playerAmounts[1],
//                 ),
//               ),
//               Positioned(
//                 right: -80,
//                 top: 40,
//                 child: PlayerWidget(
//                   playerName: widget.pokerController.players[2],
//                   playerImage: widget.pokerController.playersImage[2],
//                   cards: widget.pokerController.playerCards[2],
//                   isCurrentPlayer: widget.pokerController.currentPlayerIndex == 2,
//                   leftRightTop: (false, true, false),
//                   amount: widget.pokerController.playerAmounts[2],
//                 ),
//               ),
//               Positioned(
//                 bottom: -110,
//                 child: Obx(() {
//                   return PlayerWidget(
//                     playerName: widget.pokerController.isProfileUpdated.value
//                         ? (widget.pokerController.getProfileModel?.data.first.username ?? "")
//                         : widget.pokerController.players[3],
//                     playerImage: widget.pokerController.playersImage[3],
//                     cards: widget.pokerController.playerCards[3],
//                     isCurrentPlayer: widget.pokerController.currentPlayerIndex == 3,
//                     leftRightTop: (false, false, false),
//                     amount: widget.pokerController.playerAmounts[3],
//                     showCards: showPlayer4Cards,
//                   );
//                 }),
//               ),
//             ],
//           ),
//           if (showRemainingCards)
//             Positioned(
//               bottom: 60,
//               left: 0,
//               right: 0,
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: remainingCards.map((card) {
//                     if (!widget.pokerController.dealtCards.contains(card)) {
//                       return GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             selectedCards.clear();
//                             selectedCards.add(card);
//                           });
//                         },
//                         child: Container(
//                           margin: const EdgeInsets.symmetric(horizontal: 5),
//                           decoration: BoxDecoration(
//                             border: Border.all(
//                               color: selectedCards.contains(card)
//                                   ? colors.borderColorLight
//                                   : Colors.transparent,
//                               width: 2,
//                             ),
//                             borderRadius: BorderRadius.circular(2),
//                           ),
//                           child: SvgPicture.asset(
//                             'assets/Card/svg-cards/$card.svg',
//                             width: 123,
//                             height: 55,
//                           ),
//                         ),
//                       );
//                     } else {
//                       return const SizedBox.shrink();
//                     }
//                   }).toList(),
//                 ),
//               ),
//             ),
//           Positioned(
//             bottom: 10,
//             left: 20,
//             right: 20,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         Utils.mySnackBar(title: "isn't my side pack");
//                       },
//                       child: Container(
//                         height: 40,
//                         width: 60,
//                         decoration: BoxDecoration(
//                           color: colors.red.withOpacity(0.4),
//                           border: Border.all(
//                               color: colors.borderColorLight, width: 2),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: const Center(
//                           child: Text("Pack",
//                               style: TextStyle(color: colors.whiteTemp)),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 20),
//                     InkWell(
//                       onTap: () {
//                         setState(() {
//                           showPlayer4Cards = !showPlayer4Cards;
//                         });
//                       },
//                       child: Container(
//                         height: 40,
//                         width: 80,
//                         decoration: BoxDecoration(
//                           color: colors.primary.withOpacity(0.4),
//                           border: Border.all(
//                               color: colors.borderColorLight, width: 2),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: const Center(
//                           child: Text("Show",
//                               style: TextStyle(color: colors.whiteTemp)),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Container(
//                       width: 90,
//                       height: 40,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                             color: colors.borderColorLight, width: 2),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: Obx(
//                               () => Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               widget.pokerController.amount == 5
//                                   ? const SizedBox.shrink()
//                                   : InkWell(
//                                 onTap: () {
//                                   widget.pokerController
//                                       .decrementAmount();
//                                 },
//                                 child: const Icon(Icons.remove,
//                                     color: colors.whiteTemp),
//                               ),
//                               Text(
//                                 '${widget.pokerController.amount}',
//                                 style: const TextStyle(
//                                     fontSize: 20.0, color: colors.whiteTemp),
//                               ),
//                               widget.pokerController.amount == 500
//                                   ? const SizedBox.shrink()
//                                   : InkWell(
//                                 onTap: () {
//                                   widget.pokerController
//                                       .incrementAmount();
//                                 },
//                                 child: const Icon(Icons.add,
//                                     color: colors.whiteTemp),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 20),
//                     InkWell(
//                       onTap: () {
//                         Utils.mySnackBar(title: "This is a my chal");
//                       },
//                       child: Container(
//                         height: 40,
//                         width: 60,
//                         decoration: BoxDecoration(
//                           color: colors.primary.withOpacity(0.4),
//                           border: Border.all(
//                               color: colors.borderColorLight, width: 2),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: const Center(
//                           child: Text("Chal",
//                               style: TextStyle(color: colors.whiteTemp)),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 20),
//                     InkWell(
//                       onTap: toggleShowRemainingCards,
//                       child: Container(
//                         height: 40,
//                         width: 100,
//                         decoration: BoxDecoration(
//                           color: colors.primary.withOpacity(0.4),
//                           border: Border.all(
//                               color: colors.borderColorLight, width: 2),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: const Center(
//                           child: Text("Select Card",
//                               style: TextStyle(color: colors.whiteTemp)),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 20),
//                     InkWell(
//                       onTap: addSelectedCardToPlayer4,
//                       child: Container(
//                         height: 40,
//                         width: 60,
//                         decoration: BoxDecoration(
//                           color: colors.primary.withOpacity(0.4),
//                           border: Border.all(
//                               color: colors.borderColorLight, width: 2),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: const Center(
//                           child: Text("Add",
//                               style: TextStyle(color: colors.whiteTemp)),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     widget.pokerController.playerCards = [[], [], [], []];
//     socket.dispose();
//     super.dispose();
//   }
// }


class PokerTable extends StatefulWidget {
  const PokerTable({super.key, required this.pokerController, this.audioController, required this.userName});

  final PokerController pokerController;
  final AudioController? audioController;
  final String userName;

  @override
  _PokerTableState createState() => _PokerTableState();
}

class _PokerTableState extends State<PokerTable> {
  late IO.Socket socket;
  bool showPlayer4Cards = false;
  bool showRemainingCards = false;
  List<String> remainingCards = [];
  List<String> selectedCards = [];

  @override
  void initState() {
    super.initState();
    for (int i = 1; i < 14; i++) {
      String? card;
      switch (i) {
        case 1:
          card = 'ace';
          break;
        case 11:
          card = 'jack';
          break;
        case 12:
          card = 'queen';
          break;
        case 13:
          card = 'king';
          break;
        default:
          card = "$i";
          break;
      }
      for (int j = 0; j < 4; j++) {
        String? suit;
        switch (j) {
          case 0:
            suit = 'clubs';
            break;
          case 1:
            suit = 'diamonds';
            break;
          case 2:
            suit = 'hearts';
            break;
          default:
            suit = "spades";
            break;
        }
        widget.pokerController.cardNumber.add('${card}_of_$suit');
      }
    }
    remainingCards = List.from(widget.pokerController.cardNumber);
    remainingCards.shuffle();  // Shuffle the remaining cards
    widget.pokerController.dealCards();
    // connectToServer();
  }

  void connectToServer() {
    socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.on('connect', (_) {
      print('connected to server');
      socket.emit('join', 'poker-room'); // joining the poker room
    });

    socket.on('disconnect', (_) {
      print('disconnected from server');
    });

    socket.on('player_joined', (data) {
      print('Player joined: $data');
    });

    socket.on('card_distribution', (data) {
      print('Cards distributed: $data');
    });

    socket.on('bet', (data) {
      print('Bet placed: $data');
    });
  }
/// show remaining card
  void toggleShowRemainingCards() {
    setState(() {
      showRemainingCards = !showRemainingCards;
      if (showRemainingCards) {
        remainingCards.shuffle();  // Shuffle the cards each time they are shown
      }
    });
  }
/// third card add
  void addSelectedCardToPlayer4(String card) {
    setState(() {
      if (widget.pokerController.playerCards[3].length < 3) {
        widget.pokerController.playerCards[3].add(card);
        remainingCards.remove(card);
        selectedCards.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom],
    );
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                colors.secondary.withOpacity(0.9),
                colors.primary,
                colors.secondary.withOpacity(0.9),
              ]),
              image: const DecorationImage(
                image: AssetImage(ImagesPath.backGroundImage),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 300,
                height: 140,
                decoration: BoxDecoration(
                  color: colors.primary,
                  border: Border.all(color: const Color(0XFF623412), width: 3),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0XFF623412),
                      blurRadius: 3.0,
                      spreadRadius: 1.0,
                    )
                  ],
                  borderRadius: BorderRadius.circular(75),
                ),
                child: const Center(
                  child: Text(
                    'Poker Table',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Positioned(
                top: -110,
                child: PlayerWidget(
                  playerImage: widget.pokerController.playersImage[0],
                  playerName: widget.pokerController.players[0],
                  cards: widget.pokerController.playerCards[0],
                  isCurrentPlayer: widget.pokerController.currentPlayerIndex == 0,
                  leftRightTop: (false, false, true),
                  amount: widget.pokerController.playerAmounts[0],
                ),
              ),
              Positioned(
                left: -80,
                top: 40,
                child: PlayerWidget(
                  playerName: widget.pokerController.players[1],
                  playerImage: widget.pokerController.playersImage[1],
                  cards: widget.pokerController.playerCards[1],
                  isCurrentPlayer: widget.pokerController.currentPlayerIndex == 1,
                  leftRightTop: (true, false, false),
                  amount: widget.pokerController.playerAmounts[1],
                ),
              ),
              Positioned(
                right: -80,
                top: 40,
                child: PlayerWidget(
                  playerName: widget.pokerController.players[2],
                  playerImage: widget.pokerController.playersImage[2],
                  cards: widget.pokerController.playerCards[2],
                  isCurrentPlayer: widget.pokerController.currentPlayerIndex == 2,
                  leftRightTop: (false, true, false),
                  amount: widget.pokerController.playerAmounts[2],
                ),
              ),
              Positioned(
                bottom: -110,
                child: Obx(() {
                  return PlayerWidget(
                    playerName: widget.pokerController.isProfileUpdated.value
                        ? (widget.pokerController.getProfileModel?.data.first.username ?? "")
                        : widget.pokerController.players[3],
                    playerImage: widget.pokerController.playersImage[3],
                    cards: widget.pokerController.playerCards[3],
                    isCurrentPlayer: widget.pokerController.currentPlayerIndex == 3,
                    leftRightTop: (false, false, false),
                    amount: widget.pokerController.playerAmounts[3],
                    showCards: showPlayer4Cards,
                  );
                }),
              ),
            ],
          ),
          /// Show remaining card list
          if (showRemainingCards)
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: remainingCards.map((card) {
                    if (!widget.pokerController.dealtCards.contains(card)) {
                      return GestureDetector(
                        onTap: () {
                          addSelectedCardToPlayer4(card);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedCards.contains(card)
                                  ? colors.borderColorLight
                                  : Colors.transparent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: SvgPicture.asset(
                            'assets/Card/svg-cards/$card.svg',
                            width: 123,
                            height: 55,
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }).toList(),
                ),
              ),
            ),
          /// All button
          Positioned(
            bottom: 10,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Utils.mySnackBar(title: "isn't my side pack");
                      },
                      child: Container(
                        height: 40,
                        width: 60,
                        decoration: BoxDecoration(
                          color: colors.red.withOpacity(0.4),
                          border: Border.all(
                              color: colors.borderColorLight, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text("Pack",
                              style: TextStyle(color: colors.whiteTemp)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        setState(() {
                          showPlayer4Cards = !showPlayer4Cards;
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          color: colors.primary.withOpacity(0.4),
                          border: Border.all(
                              color: colors.borderColorLight, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text("Show",
                              style: TextStyle(color: colors.whiteTemp)),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: colors.borderColorLight, width: 2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Obx(
                              () => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              widget.pokerController.amount == 5
                                  ? const SizedBox.shrink()
                                  : InkWell(
                                onTap: () {
                                  widget.pokerController
                                      .decrementAmount();
                                },
                                child: const Icon(Icons.remove,
                                    color: colors.whiteTemp),
                              ),
                              Text(
                                '${widget.pokerController.amount}',
                                style: const TextStyle(
                                    fontSize: 20.0, color: colors.whiteTemp),
                              ),
                              widget.pokerController.amount == 500
                                  ? const SizedBox.shrink()
                                  : InkWell(
                                onTap: () {
                                  widget.pokerController
                                      .incrementAmount();
                                },
                                child: const Icon(Icons.add,
                                    color: colors.whiteTemp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        Utils.mySnackBar(title: "This is a my chal");
                      },
                      child: Container(
                        height: 40,
                        width: 60,
                        decoration: BoxDecoration(
                          color: colors.primary.withOpacity(0.4),
                          border: Border.all(
                              color: colors.borderColorLight, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text("Chal",
                              style: TextStyle(color: colors.whiteTemp)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: toggleShowRemainingCards,
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          color: colors.primary.withOpacity(0.4),
                          border: Border.all(
                              color: colors.borderColorLight, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text("Select Card",
                              style: TextStyle(color: colors.whiteTemp)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.pokerController.playerCards = [[], [], [], []];
    socket.dispose();
    super.dispose();
  }
}











