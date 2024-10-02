import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart'as http;

import '../../Api Services/api_end_points.dart';
import '../../Helper_Constants/colors.dart';

class TermAndCondition extends StatefulWidget {
  const TermAndCondition({super.key});

  @override
  State<TermAndCondition> createState() => _TermAndConditionState();
}

class _TermAndConditionState extends State<TermAndCondition> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTermAndConditionApi();
    getPrivacyPolicyApi();
  }
  String? privacyPolicyData;
  Future<void>getPrivacyPolicyApi()async {
    var headers = {
      'Cookie': 'ci_session=rrit0el7bnv2ulfrrrrev8ktq5pl48ak'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${Endpoints.baseUrl}${Endpoints.getPrivacyPolicy}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result  = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      setState(() {
        privacyPolicyData = finalResult['data']['description'];
      });
    }
    else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
    }

  }
  String? termAndConditionData;
  Future<void>getTermAndConditionApi()async {
    var headers = {
      'Cookie': 'ci_session=rrit0el7bnv2ulfrrrrev8ktq5pl48ak'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${Endpoints.baseUrl}${Endpoints.getTermsConditions}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result  = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      setState(() {
        termAndConditionData = finalResult['data']['description'];
      });
    }
    else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Scaffold(
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
          "Terms & Condition And Privacy Policy",
          style: TextStyle(fontSize: 17,color: colors.whiteTemp),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10),
            ),
            gradient:  LinearGradient(

                colors: <Color>[colors.primary, colors.secondary]),
          ),
        ),
      ),
      body: termAndConditionData == null? const Center(child: CupertinoActivityIndicator(color: colors.primary,)): termAndConditionData == ""? const Center(child: Text("No Data Found!!")):ListView(
        children: [
          const  Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Terms & Conditions",style: TextStyle(
                color: colors.blackTemp,fontSize: 20,fontWeight: FontWeight.bold
            ),),
          ),
          Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("$termAndConditionData", textAlign: TextAlign.justify,style: const TextStyle(),),
              )
          ),
          const Padding(
            padding:  EdgeInsets.all(8.0),
            child:  Text("Privacy Policy",style: TextStyle(
                color: colors.blackTemp,fontSize: 20,fontWeight: FontWeight.bold
            ),),
          ),
          Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child:  Text("$privacyPolicyData", textAlign: TextAlign.justify,style: const TextStyle(),),
              )
          )
        ],
      ),
    );
  }
}
