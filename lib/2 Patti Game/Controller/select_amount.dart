import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:roullet_app/2%20Patti%20Game/user_conect_socket.dart';
import 'package:roullet_app/Ludo/util/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Api Services/api_end_points.dart';
import '../../Helper_Constants/Images_path.dart';
import '../../Helper_Constants/colors.dart';
import '../../Helper_Constants/sounds_source_path.dart';
import '../../Screens/Model/get_profile_model.dart';
import '../../Widgets/coins_widget.dart';
import '../../audio_controller.dart';
import '../Screens/poker.dart';
import 'package:http/http.dart'as http;
import 'controller.dart';

class SelectAmount extends StatefulWidget {
  const SelectAmount({super.key,required this.audioController,});
  final AudioController audioController;


  @override
  State<SelectAmount> createState() => _SelectAmountState();
}

class _SelectAmountState extends State<SelectAmount> {
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
              userName: getProfileModel?.data.first.username ?? "",
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

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String? userId;
  GetProfileModel? getProfileModel;
  Future<void> getProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString("userId");
    var headers = {'Cookie': 'ci_session=3s8dqkgvv46gsrpbcm2b10qpegedlr5e'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Endpoints.baseUrl}${Endpoints.getProfile}'));
    request.fields.addAll({'user_id': userId ?? ""});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = GetProfileModel.fromJson(json.decode(result));
      getProfileModel = finalResult;
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
          Text("Something went wrong!! Please logout and Login again")));
      debugPrint(response.reasonPhrase);
    }
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
          "Select Amount",
          style: TextStyle(color: colors.whiteTemp,fontSize: 18),
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
            const SizedBox(height: 30,),
            Obx(() {
              return Padding(
                padding: const EdgeInsets.all(8.0),
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
                          startCountdown();
                          getProfile();
                          pokerController.onCoinTap(20);
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>  UserConncetSocket(pokerController: pokerController, audioController: widget.audioController,)));
                        },
                        selected: pokerController.selectedCoin.value == 20),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CoinWidget(
                          foreGroundColor: Colors.blue.shade900,
                          text: "50",
                          onTap: () {

                            widget.audioController.playSound(
                              SoundSource.coinRemoveSoundPath,
                              'coin_select',
                            );
                            startCountdown();
                            getProfile();
                            pokerController.onCoinTap(50);
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>  UserConncetSocket(pokerController: pokerController, audioController: widget.audioController,)));
                          },
                          selected: pokerController.selectedCoin.value == 50),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CoinWidget(
                          foreGroundColor: Colors.red.shade900,
                          text: "100",
                          onTap: () {

                            widget.audioController.playSound(
                              SoundSource.coinRemoveSoundPath,
                              'coin_select',
                            );
                            startCountdown();
                            getProfile();
                            pokerController.onCoinTap(100);
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>  UserConncetSocket(pokerController: pokerController, audioController: widget.audioController,)));
                          },
                          selected: pokerController.selectedCoin.value == 100),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CoinWidget(
                          foreGroundColor: Colors.yellow.shade900,
                          text: "200",
                          onTap: () {

                            widget.audioController.playSound(
                              SoundSource.coinRemoveSoundPath,
                              'coin_select',
                            );
                            startCountdown();
                            getProfile();
                            pokerController.onCoinTap(200);
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>  UserConncetSocket(pokerController: pokerController, audioController: widget.audioController,)));
                          },
                          selected: pokerController.selectedCoin.value == 200),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CoinWidget(
                          foreGroundColor: Colors.blueGrey.shade700,
                          text: "500",
                          onTap: () {
                            widget.audioController.playSound(
                              SoundSource.coinRemoveSoundPath,
                              'coin_select',
                            );
                            startCountdown();
                            getProfile();
                            pokerController.onCoinTap(500);
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>  UserConncetSocket(pokerController: pokerController, audioController: widget.audioController,)));
                          },
                          selected: pokerController.selectedCoin.value == 500),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CoinWidget(
                          foreGroundColor: Colors.pink.shade900,
                          text: "1000",
                          onTap: () {
                            widget.audioController.playSound(
                              SoundSource.coinRemoveSoundPath,
                              'coin_select',
                            );
                            startCountdown();
                            getProfile();
                            pokerController.onCoinTap(1000);
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>  UserConncetSocket(pokerController: pokerController, audioController: widget.audioController,)));
                          },
                          selected: pokerController.selectedCoin.value == 1000),
                    ),
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
                     Container(
                       height: 120,
                       width: 125,
                       //constraints: const BoxConstraints(maxWidth: 150, maxHeight: 150), // Setting maximum width and height
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         border: Border.all(color: colors.borderColorDark, width: 2),
                       ),
                       padding: const EdgeInsets.all(8),
                       child: getProfileModel?.data.first.username == null
                           ?  Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           ClipRRect(
                             borderRadius: BorderRadius.circular(10),
                             child: Image.asset(
                               "assets/dummy.png",
                               fit: BoxFit.fill,
                               scale: 2.1,
                             ),
                           ),
                           const SizedBox(
                             height: 7,
                           ),
                           const Text(
                             "Player 1",
                             style:  TextStyle(color: colors.borderColorDark),
                           ),
                         ],
                       )
                           : Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           ClipRRect(
                             borderRadius: BorderRadius.circular(10),
                             child: Image.asset(
                               "assets/ludo/user1.jpg",
                               fit: BoxFit.fill,
                               scale: 3.1,
                             ),
                           ),
                           const SizedBox(
                             height: 7,
                           ),
                           Text(
                             "${getProfileModel?.data.first.username}",
                             style: const TextStyle(color: Colors.white),
                           ),
                         ],
                       ),
                     ),
                     const SizedBox(width: 10,),
                     Container(
                       height: 120,
                       width: 125,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         border: Border.all(color: colors.borderColorDark, width: 2),
                       ),
                       padding: const EdgeInsets.all(8),
                       child: getProfileModel?.data.first.username == null
                           ?  Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           ClipRRect(
                             borderRadius: BorderRadius.circular(10),
                             child: Image.asset(
                               "assets/dummy.png",
                               fit: BoxFit.fill,
                               scale: 2.1,
                             ),
                           ),
                           const SizedBox(
                             height: 7,
                           ),
                           const Text(
                             "Player 2",
                             style:  TextStyle(color: colors.borderColorDark),
                           ),
                         ],
                       )
                           : Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           ClipRRect(
                             borderRadius: BorderRadius.circular(10),
                             child: Image.asset(
                               "assets/ludo/user4.jpg",
                               fit: BoxFit.fill,
                               scale: 3.1,
                             ),
                           ),
                           const SizedBox(
                             height: 7,
                           ),
                           Text(
                             "${getProfileModel?.data.first.username}",
                             style: const TextStyle(color: Colors.white),
                           ),
                         ],
                       ),
                     ),

                   ],
                 ),
                 const SizedBox(height: 10),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Container(
                       height: 120,
                       width: 125,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         border: Border.all(color: colors.borderColorDark, width: 2),
                       ),
                       padding: const EdgeInsets.all(8),
                       child: getProfileModel?.data.first.username == null
                           ?  Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           ClipRRect(
                             borderRadius: BorderRadius.circular(10),
                             child: Image.asset(
                               "assets/dummy.png",
                               fit: BoxFit.fill,
                               scale: 2.1,
                             ),
                           ),
                           const SizedBox(
                             height: 7,
                           ),
                           const Text(
                             "Player 3",
                             style:  TextStyle(color: colors.borderColorDark),
                           ),
                         ],
                       )
                           : Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           ClipRRect(
                             borderRadius: BorderRadius.circular(10),
                             child: Image.asset(
                               "assets/ludo/user5.jpg",
                               fit: BoxFit.fill,
                               scale: 3.1,
                             ),
                           ),
                           const SizedBox(height: 7),
                           Text(
                             "${getProfileModel?.data.first.username}",
                             style: const TextStyle(color: Colors.white),
                           ),
                         ],
                       ),
                     ),
                     const SizedBox(width: 10,),
                     Container(
                       height: 120,
                       width: 125,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         border: Border.all(color: colors.borderColorDark, width: 2),
                       ),
                       padding: const EdgeInsets.all(8),
                       child: getProfileModel?.data.first.username == null
                           ?  Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           ClipRRect(
                             borderRadius: BorderRadius.circular(10),
                             child: Image.asset(
                               "assets/dummy.png",
                               fit: BoxFit.fill,
                               scale: 2.1,
                             ),
                           ),
                           const SizedBox(
                             height: 7,
                           ),
                           const Text(
                             "Player 4",
                             style:  TextStyle(color: colors.borderColorDark),
                           ),
                         ],
                       )
                           : Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           ClipRRect(
                             borderRadius: BorderRadius.circular(10),
                             child: Image.asset(
                               "assets/ludo/user6.jpg",
                               fit: BoxFit.fill,
                               scale: 3.1,
                             ),
                           ),
                           const SizedBox(height: 7),
                           Text(
                             "${getProfileModel?.data.first.username}",
                             style: const TextStyle(color: Colors.white),
                           ),
                         ],
                       ),
                     ),
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
