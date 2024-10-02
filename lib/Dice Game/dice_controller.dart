import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../../Api Services/api_end_points.dart';
import '../../Screens/Model/get_profile_model.dart';
import '../../utils.dart';

class DiceController extends GetxController{


  RxInt selectedCoin = 0.obs;
  /// on select a coin
  onCoinTap(int value) {
    if (selectedCoin.value == value) {
      selectedCoin.value = 0;
      return;
    }
    selectedCoin.value = value;


    //
    //     Utils.mySnackBar(title: "Your wallet balance is not Sufficient");
    //   }
    // } else {
    //   Utils.mySnackBar(title: "Bet Time Over...", maxWidth: 250);
    // }
  }

  @override
  void onInit() {
    super.onInit();
    getProfile();

  }

  /// getProfileApi
  GetProfileModel? getProfileModel;
  RxBool isProfileUpdated = false.obs;

  Future<GetProfileModel?> getProfile() async {
    isProfileUpdated. value = false;
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? userId = preferences.getString("userId");

      if (userId == null || userId.isEmpty) {
        Utils.mySnackBar(title: "User ID is missing. Please logout and Login again");
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
        Utils.mySnackBar(title: "Something went wrong!! Please logout and Login again");
      }
    } catch (e) {
      print("Exception: $e");
      Utils.mySnackBar(title: "An error occurred. Please try again later");
    }
    return getProfileModel;
  }



}