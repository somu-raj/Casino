import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:roullet_app/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Api Services/api_end_points.dart';
import '../../Helper_Constants/colors.dart';
import '../Model/get_winning_history.dart';
import '../Model/my_winning_history_model.dart';

class MyWinningHistoryScreen extends StatefulWidget {
  const MyWinningHistoryScreen({super.key});

  @override
  State<MyWinningHistoryScreen> createState() => _MyWinningHistoryScreenState();
}

class _MyWinningHistoryScreenState extends State<MyWinningHistoryScreen> {
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
              "My Winning History",
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
                  child:myWinningHistory?.data == null
                      ? const Center(child:  CircularProgressIndicator())
                      : myWinningHistory?.data.length == 0
                      ? const Text("No My  Winning History..")
                      : ListView.builder(
                      shrinkWrap: true,
                      itemCount: myWinningHistory?.data.length != null && myWinningHistory!.data.length >= 10
                          ? 10
                          : myWinningHistory?.data.length,
                      itemBuilder: (context, index) {
                        var winningList = myWinningHistory?.data[index];
                        return  Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Winning Amount :"),
                                    Text("₹ ${winningList?.winningAmount}")
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Bet Number :"),
                                    Text("${winningList?.betNumber}")
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Bet Type :"),
                                    Text("${winningList?.betType}")
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Date :"),
                                    Text("${winningList?.date}")
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
  MyWinningHistory? myWinningHistory;
  Future<void> getWinningHistory(BuildContext context) async {
    var headers = {'Cookie': 'ci_session=c7797mp92d9k6gmq38epdr8hm70h9vab'};
    var request = http.MultipartRequest('POST',
        Uri.parse("${Endpoints.baseUrl}${Endpoints.myWinningHistory}"));
    request.fields.addAll({
      'user_id': userId.toString(),
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult =
      MyWinningHistory.fromJson(json.decode(result));
      if (finalResult.error == false) {
        setState(() {
          myWinningHistory = finalResult;

        });
      } else {
        Utils.mySnackBar(title:'${finalResult.message}' );
      }
    } else {
      print(response.reasonPhrase);
    }
  }
}
