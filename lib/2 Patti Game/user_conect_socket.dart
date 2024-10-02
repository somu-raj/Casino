import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:roullet_app/2%20Patti%20Game/Controller/controller.dart';
import 'package:roullet_app/2%20Patti%20Game/Screens/poker.dart';
// import 'package:roullet_app/Ludo/game.dart';
// import 'package:roullet_app/Ludo/util/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api Services/api_end_points.dart';
import '../Helper_Constants/Images_path.dart';
import '../Helper_Constants/colors.dart';
import '../Helper_Constants/sounds_source_path.dart';
import '../Screens/Model/get_profile_model.dart';
import '../audio_controller.dart';
import 'package:http/http.dart' as http;

class UserConncetSocket extends StatefulWidget {
  const UserConncetSocket({super.key, required this.audioController,required this.pokerController});
  final AudioController audioController;
  final PokerController pokerController;

  @override
  State<UserConncetSocket> createState() => _UserConncetSocketState();
}

class _UserConncetSocketState extends State<UserConncetSocket> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startCountdown();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
     SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,DeviceOrientation.landscapeRight]).then((value){

    });
    Size size = MediaQuery.of(context).size;
    double h = size.height;
    double w = size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: colors.whiteTemp), // 1,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Connect Users",
          style: TextStyle(color: colors.whiteTemp),
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
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 30),
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(50),
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            crossAxisCount: 2,
            childAspectRatio: 1.7,
            children: [
              Container(
                height: 50,
                width: 50,
                //constraints: const BoxConstraints(maxWidth: 150, maxHeight: 150), // Setting maximum width and height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                padding: const EdgeInsets.all(8),
                child: getProfileModel?.data.first.username == null
                    ? const CupertinoActivityIndicator()
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/ludo/user1.jpg",
                        fit: BoxFit.fill,
                        scale: 3.0,
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
              Container(
                constraints: const BoxConstraints(maxWidth: 100, maxHeight: 100), // Setting maximum width and height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                padding: const EdgeInsets.all(8),
                child: getProfileModel?.data.first.username == null
                    ? const CupertinoActivityIndicator(color: Colors.blue)
                    : getProfileModel?.data.first.city == "1"
                    ? const CupertinoActivityIndicator()
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/ludo/user4.jpg",
                        fit: BoxFit.fill,
                        scale: 2.8,
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
              Container(
                constraints: const BoxConstraints(maxWidth: 100, maxHeight: 100), // Setting maximum width and height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                padding: const EdgeInsets.all(8),
                child: getProfileModel?.data.first.username == null
                    ? const CupertinoActivityIndicator(color: Colors.blue)
                    : getProfileModel?.data.first.city == "1"
                    ? const CupertinoActivityIndicator()
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/ludo/user5.jpg",
                        fit: BoxFit.fill,
                        scale: 3.0,
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
              Container(
                constraints: const BoxConstraints(maxWidth: 100, maxHeight: 100), // Setting maximum width and height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                padding: const EdgeInsets.all(8),
                child: getProfileModel?.data.first.username == null
                    ? const CupertinoActivityIndicator(color: Colors.blue)
                    : getProfileModel?.data.first.city == "1"
                    ? const CupertinoActivityIndicator(color: Colors.blue)
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/ludo/user6.jpg",
                        fit: BoxFit.fill,
                        scale: 3.0,
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
          ),
        ),
      ),

    );
  }

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
        /*Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PokerTable(
              audioController: widget.audioController,
              pokerController: widget.pokerController,
              userName: getProfileModel?.data.first.username ?? "",
            ),
          ),
        );*/
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
}