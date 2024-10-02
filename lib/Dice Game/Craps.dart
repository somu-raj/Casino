import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:roullet_app/Dice%20Game/dice_controller.dart';
import 'package:roullet_app/Helper_Constants/colors.dart';
import 'package:roullet_app/Widgets/coins_widget.dart';
import '../Helper_Constants/Images_path.dart';
import '../Helper_Constants/sounds_source_path.dart';
import '../audio_controller.dart';
import 'CrapsTablePainter.dart';
import 'dice_table_ui.dart';

  class CrapsGame extends StatefulWidget {
    final AudioController? audioController;
    const CrapsGame({super.key, this.audioController});

    @override
    _CrapsGameState createState() => _CrapsGameState();
  }

  class _CrapsGameState extends State<CrapsGame> with  SingleTickerProviderStateMixin{


    late AnimationController _controller;
    late Animation<double> _rotationAnimation;
    late Animation<Offset> _positionAnimation;
    int _currentDiceFace = 1;
    final Random _random = Random();

    @override
    void initState() {
      super.initState();

      _controller = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
      )..addListener(() {
        setState(() {});
      });

      _rotationAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOut,
        ),
      );

      _positionAnimation = Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(0.05, 0.05), // Adjust the movement range
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOut,
        ),
      );
    }

    void _rollDice() {
      _currentDiceFace = _random.nextInt(6) + 1;
      _controller.forward().then((_) {
        _controller.reset();
      });
    }
    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }

    int dice1 = 1;
    int dice2 = 1;
    final Dice dice = Dice();
    bool isRolling = false;

    void rollDice() {
      widget.audioController?.playSound(SoundSource.diceSound, "Ludo");
      isRolling = true;

      setState(() {});
      Future.delayed(2.seconds, (){
        isRolling = false;
        setState(() {

          dice1 = dice.roll();
          dice2 = dice.roll();

        });
      });

    }

    DiceController diceController = Get.put(DiceController());

    void handleTap(Offset position) {
      // Handle tap on the craps table sections
      // You can calculate which section was tapped based on the position
      print("Tapped position: $position");
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
      Size size = MediaQuery.of(context).size;
      double h = size.height;
      double w = size.width;
      return Scaffold(
        backgroundColor: Colors.amber,
        body: Container(
          height: h,
          width: w,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colors.secondary,
                colors.primary,
                colors.secondary,
              ],
            ),
            image: DecorationImage(
              image: AssetImage(ImagesPath.backGroundImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const DiceTableScreen(),
             /*   GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    handleTap(details.localPosition);
                  },
                  child: CustomPaint(
                    size: Size(MediaQuery.of(context).size.width * 0.9, 280),
                    painter: CrapsTablePainter(onTapCallback: handleTap),
                  ),
                ),*/
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        DiceWidget(number: dice1,isRolling: isRolling,),
                        const SizedBox(width: 20),
                        DiceWidget(number: dice2, isRolling: isRolling,),
                        const SizedBox(width: 50),
                        InkWell(
                          onTap: rollDice,
                          child: Container(
                            height: 45,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: colors.borderColorLight,
                                width: 2,
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Dice Roll",
                                  style: TextStyle(
                                    color: colors.whiteTemp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Obx(() {
                          return Row(
                            children: [
                              const SizedBox(width: 20),
                              CoinWidget(
                                foreGroundColor: Colors.blue.shade900,
                                text: "5",
                                onTap: () {
                                  diceController.onCoinTap(5);
                                  widget.audioController?.playSound(
                                    SoundSource.coinRemoveSoundPath,
                                    'coin_select',
                                  );
                                },
                                selected:
                                diceController.selectedCoin.value == 5,
                              ),
                              const SizedBox(width: 20),
                              CoinWidget(
                                foreGroundColor: Colors.orange.shade900,
                                text: "10",
                                onTap: () {
                                  diceController.onCoinTap(10);
                                  widget.audioController?.playSound(
                                    SoundSource.coinRemoveSoundPath,
                                    'coin_select',
                                  );
                                },
                                selected:
                                diceController.selectedCoin.value == 10,
                              ),
                              const SizedBox(width: 20),
                              CoinWidget(
                                foreGroundColor: Colors.red.shade900,
                                text: "20",
                                onTap: () {
                                  diceController.onCoinTap(20);
                                  widget.audioController?.playSound(
                                    SoundSource.coinRemoveSoundPath,
                                    'coin_select',
                                  );
                                },
                                selected:
                                diceController.selectedCoin.value == 20,
                              ),
                              const SizedBox(width: 20),
                              CoinWidget(
                                foreGroundColor: Colors.brown.shade600,
                                text: "50",
                                onTap: () {
                                  diceController.onCoinTap(50);
                                  widget.audioController?.playSound(
                                    SoundSource.coinRemoveSoundPath,
                                    'coin_select',
                                  );
                                },
                                selected:
                                diceController.selectedCoin.value == 50,
                              ),
                              const SizedBox(width: 20),
                              CoinWidget(
                                foreGroundColor: Colors.teal.shade900,
                                text: "100",
                                onTap: () {
                                  diceController.onCoinTap(100);
                                  widget.audioController?.playSound(
                                    SoundSource.coinRemoveSoundPath,
                                    'coin_select',
                                  );
                                },
                                selected:
                                diceController.selectedCoin.value == 100,
                              ),
                              const SizedBox(width: 20),
                              CoinWidget(
                                foreGroundColor: Colors.yellow.shade900,
                                text: "200",
                                onTap: () {
                                  diceController.onCoinTap(200);
                                  widget.audioController?.playSound(
                                    SoundSource.coinRemoveSoundPath,
                                    'coin_select',
                                  );
                                },
                                selected:
                                diceController.selectedCoin.value == 200,
                              ),
                              const SizedBox(width: 20),
                              CoinWidget(
                                foreGroundColor: Colors.purple.shade900,
                                text: "500",
                                onTap: () {
                                  diceController.onCoinTap(500);
                                  widget.audioController?.playSound(
                                    SoundSource.coinRemoveSoundPath,
                                    'coin_select',
                                  );
                                },
                                selected:
                                diceController.selectedCoin.value == 500,
                              ),
                              const SizedBox(width: 20),
                              CoinWidget(
                                foreGroundColor: Colors.pink.shade900,
                                text: "1000",
                                onTap: () {
                                  diceController.onCoinTap(1000);
                                  widget.audioController?.playSound(
                                    SoundSource.coinRemoveSoundPath,
                                    'coin_select',
                                  );
                                },
                                selected: diceController
                                    .selectedCoin.value ==
                                    1000,
                              ),
                            ],
                          );
                        })
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }



  bool coinSelected = false;

  class DiceWidget extends StatelessWidget {
    final int number;
    final bool isRolling;
    late AnimationController? controller;
    late Animation<double>? rotationAnimation;
    late Animation<Offset>? positionAnimation;

     DiceWidget({super.key, required this.number,this.controller,this.rotationAnimation,this.positionAnimation,required this.isRolling});

    @override
    Widget build(BuildContext context) {
      return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: colors.red,
          border: Border.all(color: colors.borderColorLight, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Image.asset(
            isRolling ?'assets/dice/ezgif-4-149ec746b8.gif':
            'assets/dice/dice$number.png',
            fit: BoxFit.contain,
          ),
        ),
      );
      /*return Center(
        child: Transform(
          transform: Matrix4.identity()
            ..rotateX(rotationAnimation!.value)
            ..rotateY(rotationAnimation!.value)
            ..rotateZ(rotationAnimation!.value),
          alignment: FractionalOffset.center,
          child: SlideTransition(
            position: positionAnimation,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.red,
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Image.asset(
                  'assets/dice/dice$_currentDiceFace.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      );*/
    }
  }

  class Dice {
    int roll() {
      return Random().nextInt(6) + 1;
    }
  }
