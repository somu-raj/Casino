
//
// import 'dart:async';
// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../Api Services/api_end_points.dart';
// import '../../Screens/Model/get_profile_model.dart';
// import '../../utils.dart';
// import 'package:http/http.dart' as http;
//
// class PokerController extends GetxController {
//   List<String> players = ["Player 1", "Player 2", "Player 3", "Player 4"];
//   List<String> playersImage = [
//     "assets/Card/man.png",
//     "assets/Card/man1.png",
//     "assets/Card/man2.png",
//     "assets/Card/man3.png"
//   ];
//   List<String> cardNumber = [];
//   List<List<String>> playerCards = [[], [], [], []];
//   List<double> playerAmounts = [100.0, 150.0, 200.0, 250.0].obs;
//   int currentPlayerIndex = 3;
//   String? userId;
//   List<String> dealtCards = [];
//
//   bool isPlayer1CardsVisible = false;
//
// /*  void dealCards() {
//   cardNumber.shuffle();
//   for (int i = 0; i < 2; i++) {
//   for (int j = 0; j < playerCards.length; j++) {
//   playerCards[j].add(cardNumber.removeAt(0));
//   }
//   }
//   update();
//   }*/
//
//   void dealCards() {
//     // Simulate dealing cards to players
//     dealtCards = [
//       'ace_of_clubs',
//       '2_of_diamonds',
//       '3_of_hearts'
//     ]; // Example dealt cards
//     playerCards = [
//       ['ace_of_clubs', '2_of_diamonds'],
//       ['3_of_hearts', '4_of_spades'],
//       ['5_of_hearts', '6_of_clubs'],
//       ['7_of_spades', '8_of_diamonds']
//     ];
//   }
//
//   RxInt amount = 5.obs;
//
//   //RxInt get amount => _amount;
//   void incrementAmount() {
//     amount += 5;
//     update();
//   }
//
//   void decrementAmount() {
//     amount -= 5;
//     update();
//   }
//
//   ValueNotifier progress = ValueNotifier(10);
//   Timer? progressTimer;
//
//   startProgress() {
//     progressTimer = Timer.periodic(1.seconds, (timer) {
//       progress.value -= 1;
//       if (progress.value == 0) {
//         timer.cancel();
//       }
//     });
//   }
//
//   RxInt selectedCoin = 0.obs;
//
//   /// on select a coin
//   onCoinTap(int value) {
//     if (selectedCoin.value == value) {
//       selectedCoin.value = 0;
//       return;
//     }
//     selectedCoin.value = value;
//     // audioController
//     //     .playSound(SoundSource.coinRemoveSoundPath, 'coin_select');
//
//     //     Utils.mySnackBar(title: "Your wallet balance is not Sufficient");
//     //   }
//     // } else {
//     //   Utils.mySnackBar(title: "Bet Time Over...", maxWidth: 250);
//     // }
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//     getProfile();
//   }
//
//   /// getProfileApi
//   GetProfileModel? getProfileModel;
//   RxBool isProfileUpdated = false.obs;
//
//   Future<GetProfileModel?> getProfile() async {
//     isProfileUpdated.value = false;
//     try {
//       SharedPreferences preferences = await SharedPreferences.getInstance();
//       String? userId = preferences.getString("userId");
//
//       if (userId == null || userId.isEmpty) {
//         Utils.mySnackBar(
//             title: "User ID is missing. Please logout and Login again");
//         return null;
//       }
//
//       var headers = {'Cookie': 'ci_session=3s8dqkgvv46gsrpbcm2b10qpegedlr5e'};
//       var request = http.MultipartRequest(
//           'POST', Uri.parse('${Endpoints.baseUrl}${Endpoints.getProfile}'));
//       request.fields.addAll({'user_id': userId});
//       request.headers.addAll(headers);
//
//       http.StreamedResponse response = await request.send();
//
//       if (response.statusCode == 200) {
//         var result = await response.stream.bytesToString();
//         var finalResult = GetProfileModel.fromJson(json.decode(result));
//         getProfileModel = finalResult;
//         isProfileUpdated.value = true;
//       } else {
//         var errorResult = await response.stream.bytesToString();
//         print("Error: ${response.statusCode} - $errorResult");
//         Utils.mySnackBar(
//             title: "Something went wrong!! Please logout and Login again");
//       }
//     } catch (e) {
//       print("Exception: $e");
//       Utils.mySnackBar(title: "An error occurred. Please try again later");
//     }
//     return getProfileModel;
//   }
// }
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Api Services/api_end_points.dart';
import '../../Screens/Model/get_profile_model.dart';
import '../../utils.dart';
import 'package:http/http.dart'as http;

class PokerController extends GetxController {
  List<String> players = ["Player 1", "Player 2", "Player 3", "Player 4"];
  List<String> playersImage = [
    "assets/Card/man.png",
    "assets/Card/man1.png",
    "assets/Card/man2.png",
    "assets/Card/man3.png"
  ];
  List<String> cardNumber = [];
  List<List<String>> playerCards = [[], [], [], []];
  List<double> playerAmounts = [100.0, 150.0, 200.0, 250.0].obs;
  int currentPlayerIndex = 3;
  String? userId;
  List<String> dealtCards = [];

  bool isPlayer1CardsVisible = false;

  void dealCards() {
    /// Clear previous cards
    dealtCards.clear();
    playerCards = [[], [], [], []];

    /// Shuffle cards
    cardNumber.shuffle();

    /// Deal 2 cards to each player
    for (int i = 0; i < 2; i++) {
      for (int j = 0; j < playerCards.length; j++) {
        String card = cardNumber.removeAt(0);
        playerCards[j].add(card);
        dealtCards.add(card);
      }
    }

    update();
  }
 /// remaining card list
  List<String> getRemainingCards() {
    return cardNumber.where((card) => !dealtCards.contains(card)).toList();
  }

  RxInt amount = 5.obs;
  /// quantity increment function
  void incrementAmount() {
    amount += 5;
    update();
  }

  /// quantity decrement function
  void decrementAmount() {
    amount -= 5;
    update();
  }

  ValueNotifier progress = ValueNotifier(10);
  Timer? progressTimer;

  startProgress() {
    progressTimer = Timer.periodic(1.seconds, (timer) {
      progress.value -= 1;
      if (progress.value == 0) {
        timer.cancel();
      }
    });
  }

  RxInt selectedCoin = 0.obs;

  onCoinTap(int value) {
    if (selectedCoin.value == value) {
      selectedCoin.value = 0;
      return;
    }
    selectedCoin.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  GetProfileModel? getProfileModel;
  RxBool isProfileUpdated = false.obs;

  Future<GetProfileModel?> getProfile() async {
    isProfileUpdated.value = false;
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? userId = preferences.getString("userId");

      if (userId == null || userId.isEmpty) {
        Utils.mySnackBar(
            title: "User ID is missing. Please logout and Login again");
        return null;
      }

      var headers = {'Cookie': 'ci_session=3s8dqkgvv46gsrpbcm2b10qpegedlr5e'};
      var request = http.MultipartRequest(
          'POST', Uri.parse('${Endpoints.baseUrl}${Endpoints.getProfile}'));
      request.fields.addAll({'user_id': userId});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var finalResult = GetProfileModel.fromJson(json.decode(result));
        getProfileModel = finalResult;
        isProfileUpdated.value = true;
      } else {
        var errorResult = await response.stream.bytesToString();
        print("Error: ${response.statusCode} - $errorResult");
        Utils.mySnackBar(
            title: "Something went wrong!! Please logout and Login again");
      }
    } catch (e) {
      print("Exception: $e");
      Utils.mySnackBar(title: "An error occurred. Please try again later");
    }
    return getProfileModel;
  }
}

