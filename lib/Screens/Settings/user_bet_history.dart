import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:roullet_app/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Api Services/api_end_points.dart';
import '../../Helper_Constants/colors.dart';
import '../Model/get_winning_history.dart';
import '../Model/my_bet_model.dart';
import '../Model/my_winning_history_model.dart';

class UserBetHistoryScreen extends StatefulWidget {
  const UserBetHistoryScreen({super.key});

  @override
  State<UserBetHistoryScreen> createState() => _UserBetHistoryScreenState();
}

class _UserBetHistoryScreenState extends State<UserBetHistoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50.0),
                bottomRight: Radius.circular(50),
              ),
            ),
            toolbarHeight: 60,
            centerTitle: true,
            iconTheme:const  IconThemeData(
                color: colors.whiteTemp
            ),
            title: const Text(
              "User Bet  History",
              style: TextStyle(fontSize: 17,color: colors.whiteTemp),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10),
                ),
                gradient: LinearGradient(

                    colors: <Color>[colors.primary, colors.secondary]),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.1,
                  child:myBetModel?.data == null
                      ? const Center(child:  CircularProgressIndicator())
                      : myBetModel?.data.length == 0
                      ? const Text("No My Bet ...")
                      : ListView.builder(
                      shrinkWrap: true,
                      itemCount: myBetModel?.data.length != null && myBetModel!.data.length >= 10
                          ? 10
                          : myBetModel?.data.length,
                      itemBuilder: (context, index) {
                        var myBet = myBetModel?.data[index];
                        return  Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Winning Amount :"),
                                    Text("₹ ${myBet?.amount}")
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Bet Number :"),
                                    Text("${myBet?.number}")
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Bet Type :"),
                                    Text("${myBet?.type}")
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Date :"),
                                    Text("${myBet?.created}")
                                  ],
                                ),
                               
                              ],
                            ),
                          ),
                        );
                      }
                  ),

                )
              ],
            ),
          )),
    );
  }

  String? userId;

  getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString("userId");
    getWinningHistory(context);

  }
  MyBetModel? myBetModel;
  Future<void> getWinningHistory(BuildContext context) async {
    var headers = {'Cookie': 'ci_session=c7797mp92d9k6gmq38epdr8hm70h9vab'};
    var request = http.MultipartRequest('POST',
        Uri.parse("${Endpoints.baseUrl}${Endpoints.userBet}"));
    request.fields.addAll({
      'user_id': userId.toString(),
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult =
      MyBetModel.fromJson(json.decode(result));
      if (finalResult.error == false) {
        setState(() {
          myBetModel = finalResult;

        });
      } else {
        Utils.mySnackBar(title:'${finalResult.message}' );
      }
    } else {
      print(response.reasonPhrase);
    }
  }
}
