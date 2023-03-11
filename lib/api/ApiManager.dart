import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/parameterMode.dart';
import '../utils/constants.dart';
import '../widgets/alertDialog.dart';
import 'apiUtils.dart';

var showLoader=false.obs;

//BuildContext context
class ApiManager{

   ApiCallGetInvoke(var body,) async {
    try{

      showLoader.value=true;
    // var itemsUrl="http://192.168.1.102//nextStop_dev///api/Mobile/GetInvoke";
      var itemsUrl="${GetBaseUrl()}/api/Mobile/GetInvoke";

      final response = await http.post(Uri.parse(itemsUrl),
          headers: {"Content-Type": "application/json"},
          body: json.encode(body)
      ).timeout(Duration(seconds: 30),onTimeout: ()=>onTme());
      //log("${response.statusCode} ${response.body}");

      showLoader.value=false;
      if(response.statusCode==200){
        return [true,response.body];
      }
      else{
        var msg;
        msg=json.decode(response.body);
        return [false,msg['Message']];
        // return response.statusCode.toString();
      }
    }
    catch(e){
      print("ee $e");
      showLoader.value=false;
      return [false,"Catch Api"];

    }
  }

  onTme(){
    showLoader.value=false;
    return [false,"Connection TimeOut"];
  }

   int timeOut=30;
   String invokeUrl="";
   Future<List> GetInvoke(List<ParameterModel> parameterList,{isNeedErrorAlert=true,String url="/api/Mobile/GetInvoke"}) async {
     showLoader.value=true;
     try{
       //log(json.encode(parameterList));
       invokeUrl=GetBaseUrl()+url;
       //log("invokeUrl"+invokeUrl);
       var body={
         "Fields": parameterList.map((e) => e.toJson()).toList()
       };
       final response = await http.post(Uri.parse(invokeUrl),
           headers: {"Content-Type": "application/json"},
           body: json.encode(body)
       ).timeout(Duration(seconds: timeOut),onTimeout: ()=>onTme());
       showLoader.value=false;
       if(response.statusCode==200){
         return [true,response.body];
       }
       else{
         var msg;
        // print("${response.statusCode} ${response.body}");
         msg=json.decode(response.body);
         if(isNeedErrorAlert)
           CustomAlert().commonErrorAlert(msg['Message'], "");
         return [false,msg['Message']];
       }
     }
     catch(e){
       print("ee $e");
       showLoader.value=false;
       CustomAlert().commonErrorAlert("Server Error", "$e");
       return [false,"Catch Api"];
     }
   }

   Future<List> GetInvokeLogin(List<ParameterModel> parameterList) async {
     try{
       showLoader.value=true;
       //print(json.encode(parameterList));
       //var url="https://scutisoft.in/QMS_UAT_Test/api/Login/InvokeSignIn";
       //var url=GetBaseUrl()+"/api/Login/InvokeSignIn";
       var url=GetBaseUrl()+"/api/Mobile/GetInvoke";
       var body={
         "Fields": parameterList.map((e) => e.toJson()).toList()
       };
       final response = await http.post(Uri.parse(url),
           headers: {"Content-Type": "application/json"},
           body: json.encode(body)
       ).timeout(Duration(seconds: timeOut),onTimeout: ()=>onTme());
       showLoader.value=false;
       if(response.statusCode==200){
         return [true,response.body];
       }
       else{
         var msg;
         msg=json.decode(response.body);
         CustomAlert().commonErrorAlert(msg['Message'], "");
         return [false,response];
       }
     }
     catch(e){
       showLoader.value=false;
       print("ee $e");
       CustomAlert().commonErrorAlert("Server Error", "$e");
       return [false,"Catch Api"];
     }
   }


   Future<List> PostCall(String url,List<ParameterModel> parameterList) async {
     try{
       showLoader.value=true;
       var itemsUrl=GetBaseUrl()+url;
       var body={
         "Fields": parameterList.map((e) => e.toJson()).toList()
       };
       final response = await http.post(Uri.parse(itemsUrl),
           headers: {"Content-Type": "application/json"},
           body: json.encode(body)
       ).timeout(Duration(seconds: timeOut),onTimeout: ()=>onTme()).onError((error, stackTrace){
         showLoader.value=false;
         return http.Response('{"Message":"$error"}',500);
       });
       showLoader.value=false;
       if(response.statusCode==200){
         return [true,response.body];
       }
       else{
         var msg;
         // print(msg);
         //  print("response ${response.body}");
         msg=json.decode(response.body);
         print("MSG $msg");
         CustomAlert().cupertinoAlert("${msg["Message"]}",);
         return [false,response];
         // return response.statusCode.toString();
       }
     }
     catch(e){
       showLoader.value=false;
       return [false,"Network Issue"];
       print("NETWORK ISSUE--$e");
       // CustomAlert().commonErrorAlert(context, "Network Issue", "Your Internet Connectivity or Server is Slow..");
     }
   }
}
/*
http.post(url,
body: json.encode(body),
headers: { 'Content-type': 'application/json',
'Accept': 'application/json',
"Authorization": "Some token"},
encoding: encoding)*/
