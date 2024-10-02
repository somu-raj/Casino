import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:roullet_app/2%20Patti%20Game/Controller/roomDataController.dart';
import 'package:roullet_app/2%20Patti%20Game/Resources/socketMethods.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Helper_Constants/Images_path.dart';
import '../../Helper_Constants/colors.dart';
import '../../Helper_Constants/sounds_source_path.dart';
import '../../Widgets/coins_widget.dart';
import '../../audio_controller.dart';
import '../Do Patti Widgets/common_widgets.dart';
import 'poker.dart';
import 'package:http/http.dart' as http;
import '../Controller/controller.dart';
import 'package:shimmer/shimmer.dart';

class SelectAmount extends StatefulWidget {
  const SelectAmount({
    super.key,
    required this.audioController,
  });
  final AudioController audioController;
  @override
  State<SelectAmount> createState() => _SelectAmountState();
}

class _SelectAmountState extends State<SelectAmount> {
  SocketMethods socketMethods = SocketMethods();
  PokerController pokerController = Get.put(PokerController());
  ValueNotifier<int> seconds = ValueNotifier(10);
  ValueNotifier<int> minutes = ValueNotifier(0);
  Timer? timer;
  void startCountdown() {
    const oneSec = Duration(seconds: 1); // Starting from 59 seconds
    timer = Timer.periodic(oneSec, (timer) {
      if (minutes.value == 0 && seconds.value == 0) {
        minutes.value = 1;
        seconds.value = 0;
        widget.audioController
            .playSound(SoundSource.countDownSoundPath, 'count_down');
        // Stop the timer before navigating
        timer.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PokerTable(
              audioController: widget.audioController,
              pokerController: pokerController,
              userName: roomDataController.getProfileModel?.data.first.username ?? "",
            ),
          ),
        );
      } else if (seconds.value == 0) {
        minutes.value--;
        seconds.value = 59;
        widget.audioController
            .playSound(SoundSource.countDownSoundPath, 'count_down');
      } else {
        seconds.value--;
        widget.audioController
            .playSound(SoundSource.countDownSoundPath, 'count_down');
      }
    });
  }

  RoomDataController roomDataController = Get.put(RoomDataController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() async {
    await getUserId();
    socketMethods.setConnectListener(onConnect);
    socketMethods.setOnConnectionErrorListener(onConnectError);
    socketMethods.setOnConnectionErrorTimeOutListener(onConnectTimeout);
    socketMethods.setOnErrorListener(onError);
    socketMethods.setOnDisconnectListener(onDisconnect);
    socketMethods.joinRoomSuccessListener(roomDataController);
    socketMethods.errorOccuredListener(roomDataController);
  }

  bool _connectedToSocket = false;
  String _errorConnectMessage = '';

  onConnect(data) {
    debugPrint('Connected $data');
    setState(() {
      _connectedToSocket = true;
    });
  }

  onConnectError(data) {
    debugPrint('onConnectError $data');
    setState(() {
      _connectedToSocket = false;
      _errorConnectMessage = 'Failed to Connect';
    });
  }

  onConnectTimeout(data) {
    debugPrint('onConnectTimeout $data');
    setState(() {
      _connectedToSocket = false;
      _errorConnectMessage = 'Connection timedout';
    });
  }

  onError(data) {
    debugPrint('onError $data');
    setState(() {
      _connectedToSocket = false;
      _errorConnectMessage = 'Connection Failed';
    });
  }

  onDisconnect(data) {
    debugPrint('onDisconnect $data');
    setState(() {
      _connectedToSocket = false;
      _errorConnectMessage = 'Disconnected';
    });
  }

  Widget buildShimmer(double height, double width, {double? radius}) {
    return SizedBox(
      height: height,
      width: width,
      child: Shimmer.fromColors(
        baseColor: Colors.transparent,
        highlightColor: Colors.grey[100]!.withOpacity(0.5),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 10)),
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String? userId;
  getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString("userId");
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: colors.whiteTemp), // 1,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Select  Table  Amount",
          style:
              TextStyle(
                  color: colors.borderColorLight,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "CinzelDecorative",
                  shadows: [
            Shadow(
              color: colors.black54,
              blurRadius: 10,
            ),
            Shadow(
              color: colors.blackColor,
              blurRadius: 20,
            )
          ]),
        ),
        actions: [
          ValueListenableBuilder(
              valueListenable: seconds,
              builder: (_, second, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          border: Border.all(color: colors.whiteTemp),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "0${minutes.value}:${second.toString().padLeft(2, "0")}",
                        style: const TextStyle(color: colors.whiteTemp),
                      )),
                );
              })
        ],
      ),
      body: Container(
        width: double.infinity,
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
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Obx(() {
              debugPrint("run time type --> ${pokerController.getProfileModel?.data.first.wallet.runtimeType}");
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CoinWidget(
                        foreGroundColor: Colors.purple.shade900,
                        text: "20",
                        onTap: () {
                          widget.audioController.playSound(
                            SoundSource.coinRemoveSoundPath,
                            'coin_select',
                          );
                          // startCountdown();
                          roomDataController.getProfileData();
                          pokerController.onCoinTap(20);
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>  UserConncetSocket(pokerController: pokerController, audioController: widget.audioController,)));
                        },
                        selected: pokerController.selectedCoin.value == 20),
                    const SizedBox(
                      width: 10,
                    ),
                    CoinWidget(
                        foreGroundColor: Colors.blue.shade900,
                        text: "50",
                        onTap: () {
                          widget.audioController.playSound(
                            SoundSource.coinRemoveSoundPath,
                            'coin_select',
                          );
                          // startCountdown();
                          roomDataController.getProfileData();
                          pokerController.onCoinTap(50);
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>  UserConncetSocket(pokerController: pokerController, audioController: widget.audioController,)));
                        },
                        selected: pokerController.selectedCoin.value == 50),
                    const SizedBox(
                      width: 10,
                    ),
                    CoinWidget(
                        foreGroundColor: Colors.red.shade900,
                        text: "100",
                        onTap: () {
                          widget.audioController.playSound(
                            SoundSource.coinRemoveSoundPath,
                            'coin_select',
                          );
                          // startCountdown();
                          roomDataController.getProfileData();
                          pokerController.onCoinTap(100);
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>  UserConncetSocket(pokerController: pokerController, audioController: widget.audioController,)));
                        },
                        selected: pokerController.selectedCoin.value == 100),
                    const SizedBox(
                      width: 10,
                    ),
                    CoinWidget(
                        foreGroundColor: Colors.yellow.shade900,
                        text: "200",
                        onTap: () {
                          widget.audioController.playSound(
                            SoundSource.coinRemoveSoundPath,
                            'coin_select',
                          );
                          socketMethods.joinRoom(
                              "Surendra",
                              '200',
                              pokerController.getProfileModel?.data.first.id.toString() ?? "",
                              // pokerController.getProfileModel?.data.first.wallet??"0"

                            '500'
                          );
                          // startCountdown();
                          roomDataController.getProfileData();
                          pokerController.onCoinTap(200);
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>  UserConncetSocket(pokerController: pokerController, audioController: widget.audioController,)));
                        },
                        selected: pokerController.selectedCoin.value == 200),
                    const SizedBox(
                      width: 10,
                    ),
                    CoinWidget(
                        foreGroundColor: Colors.blueGrey.shade700,
                        text: "500",
                        onTap: () {
                          widget.audioController.playSound(
                            SoundSource.coinRemoveSoundPath,
                            'coin_select',
                          );
                          // startCountdown();
                          roomDataController.getProfileData();
                          pokerController.onCoinTap(500);
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>  UserConncetSocket(pokerController: pokerController, audioController: widget.audioController,)));
                        },
                        selected: pokerController.selectedCoin.value == 500),
                    const SizedBox(
                      width: 10,
                    ),
                    CoinWidget(
                        foreGroundColor: Colors.pink.shade900,
                        text: "1000",
                        onTap: () {
                          widget.audioController.playSound(
                            SoundSource.coinRemoveSoundPath,
                            'coin_select',
                          );
                          startCountdown();
                          roomDataController.getProfileData();
                          pokerController.onCoinTap(1000);
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>  UserConncetSocket(pokerController: pokerController, audioController: widget.audioController,)));
                        },
                        selected: pokerController.selectedCoin.value == 1000),
                  ],
                ),
              );
            }),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoomUserWidget(
                        userImage: "assets/ludo/user1.jpg",
                        userName: roomDataController.getProfileModel?.data.first.username,
                        player: 1,
                        roomJoined: false),
                    const SizedBox(
                      width: 10,
                    ),
                    RoomUserWidget(
                        userImage: "assets/ludo/user4.jpg",
                        userName: roomDataController.getProfileModel?.data.first.username,
                        player: 2,
                        roomJoined: true)
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoomUserWidget(
                        userImage: "assets/ludo/user5.jpg",
                        userName: roomDataController.getProfileModel?.data.first.username,
                        player: 3,
                        roomJoined: true),
                    const SizedBox(
                      width: 10,
                    ),
                    RoomUserWidget(
                        userImage: "assets/ludo/user6.jpg",
                        userName: roomDataController.getProfileModel?.data.first.username,
                        player: 4,
                        roomJoined: false)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
