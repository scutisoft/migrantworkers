import 'dart:convert';
import 'dart:developer';
import '../api/apiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api/ApiManager.dart';
import '../model/parameterMode.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';
import '../utils/general.dart';


class GetUiNotifier {

  Future<dynamic> getUiJson(String pageId,String? loginUserId,bool isNeedUi,{String? dataJson}) async {
   List<ParameterModel> parameters=[
      ParameterModel(Key: "SpName", Type: "String", Value: "USP_GetPageInfo"),
      ParameterModel(Key: "LoginUserId", Type: "int", Value: loginUserId),
      ParameterModel(Key: "PageIdentifier", Type: "String", Value: pageId),
      ParameterModel(Key: "DataJson", Type: "String", Value: dataJson),
      ParameterModel(Key: "IsNeedUI", Type: "int", Value: isNeedUi),
      ParameterModel(Key: "ActionType", Type: "String", Value: "Get"),
      ParameterModel(Key: "database", Type: "String", Value: getDatabase()),
    ];
    var body={
      "Fields": parameters.map((e) => e.toJson()).toList()
    };
    print("-------getUiJson-------");
    print(jsonEncode(body));
    String val="";
    try{
      await ApiManager().ApiCallGetInvoke(body).then((value) {


      //  log("$value");
        if(value[0]){
          val=value[1];
        }
        else{
          Get.dialog(  CupertinoAlertDialog(
            title: Icon(Icons.error_outline,color: Colors.red,size: 50,),
            content: Text("${value[1]}",
              style: TextStyle(fontSize: 18),),
          ));
        }

        /*if(value!="null"){
        //  var parsed=json.decode(value);

        }*/
      });
      return val;
    }catch(e){
          print("CATCH $e");
    }
  }

  Future<dynamic> postUiJson(String? loginUserId,String pageId,String dataJson,Map clickEvent) async {
    List<ParameterModel> parameters=[
      ParameterModel(Key: "SpName", Type: "String", Value: "USP_GetPageInfo"),
      ParameterModel(Key: "LoginUserId", Type: "int", Value: loginUserId),
      ParameterModel(Key: "PageIdentifier", Type: "String", Value: pageId),
      ParameterModel(Key: "DataJson", Type: "String", Value: dataJson),
      ParameterModel(Key: "IsNeedUI", Type: "int", Value: false),
      ParameterModel(Key: "ActionType", Type: "String", Value: clickEvent[General.actionType]),
      ParameterModel(Key: "database", Type: "String", Value:getDatabase()),
    ];
    var body={
      "Fields": parameters.map((e) => e.toJson()).toList()
    };
    //log("postCall ${jsonEncode(body)}");
    var val=[];
    try{
      await ApiManager().ApiCallGetInvoke(body).then((value) {
       //  log("$value");
        val=value;
        /*if(value!="null"){
        //  var parsed=json.decode(value);

        }*/
      });
      return val;
    }catch(e){
          print("CATCH $e");
    }
  }

  Future<dynamic> notificationTokenUpdate(String token,int loginUserId) async {
    List<ParameterModel> parameters=[
      ParameterModel(Key: "SpName", Type: "String", Value: "USP_UpdateNotificationDetail"),
      ParameterModel(Key: "LoginUserId", Type: "int", Value: loginUserId),
      ParameterModel(Key: "TokenNumber", Type: "String", Value: token),
      ParameterModel(Key: "DeviceId", Type: "String", Value: null),
      ParameterModel(Key: "database", Type: "String", Value:getDatabase()),
    ];
    var body={
      "Fields": parameters.map((e) => e.toJson()).toList()
    };
    var val=[];
    try{
      await ApiManager().ApiCallGetInvoke(body).then((value) {
        log("$value");
        val=value;
        /*if(value!="null"){
        //  var parsed=json.decode(value);

        }*/
      });
      return val;
    }catch(e){
      print("CATCH $e");
    }
  }

  Future<dynamic> errorLog(String e,String t) async {
    List<ParameterModel> parameters=[
      ParameterModel(Key: "SpName", Type: "String", Value: "USP_InsertErrorLogMobileDetail"),
      ParameterModel(Key: "LoginUserId", Type: "int", Value: await getLoginId()),
      ParameterModel(Key: "AppPage", Type: "String", Value: e),
      ParameterModel(Key: "ErrorDescription", Type: "String", Value: t),
      ParameterModel(Key: "database", Type: "String", Value:getDatabase()),
    ];
    var body={
      "Fields": parameters.map((e) => e.toJson()).toList()
    };
    var val=[];
    try{
      await ApiManager().ApiCallGetInvoke(body).then((value) {
        log("$value");
        val=value;
        /*if(value!="null"){
        //  var parsed=json.decode(value);

        }*/
      });
      return val;
    }catch(e){
      print("CATCH $e");
    }

  }

}