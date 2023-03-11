import 'dart:convert';
import 'dart:developer';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
//import 'package:treedonate/widgets/alertDialog.dart';

import '../../api/ApiManager.dart';
import '../../api/sp.dart';
import '../../helper/language.dart';
import '../../model/parameterMode.dart';
import '../../notifier/configuration.dart';
import '../../utils/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../utils/utils.dart';
import '../../widgets/loader.dart';
import '../../widgets/pinWidget.dart';

class PinScreenLogin extends StatefulWidget {
  @override
  State<PinScreenLogin> createState() => _PinScreenLoginState();
}

class _PinScreenLoginState extends State<PinScreenLogin> {

  String localMpin="";
  final LocalAuthentication auth = LocalAuthentication();
  @override
  void initState(){
    checkFingerPrint();
    pinWidget.onComplete=(){
      if(pinWidget.validate()){
        login(pinWidget.getValue());
      }
    };
    super.initState();
  }

  void checkFingerPrint() async{
    localMpin = await getSharedPrefString(SP_PIN);
    print("localMpin $localMpin");
    if(Platform.isAndroid){
      bool hasFingerPrint=await getSharedPrefBool(SP_HASFINGERPRINT);
      bool allowFingerPrint=await getSharedPrefBool(SP_ALLOWFINGERPRINT);
      if(hasFingerPrint && allowFingerPrint){
        _authenticateWithBiometrics();
      }
      else if(localMpin.isEmpty){
        clearUserSessionDetail();
      }
    }
  }
  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        /*_isAuthenticating = true;
        _authorized = 'Authenticating';*/
      });
      authenticated = await auth.authenticate(
        localizedReason:
        'Scan your fingerprint to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
     /*   _isAuthenticating = false;
        _authorized = 'Authenticating';*/
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
       /* _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';*/
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    if(authenticated){
      if(localMpin.isEmpty){
        navigateByUserType();
      }
      else{
        login(localMpin);
      }
    }
    setState(() {
      //_authorized = message;
    });
  }

  PinWidget pinWidget=PinWidget(pinLength: 6,onComplete: (){

  },);
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Stack(
        children: [
          Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage('assets/login/login-bg.jpg'),fit: BoxFit.cover,
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(Language.welcomeBack,style: ts18(Color(0XFF000000),fontfamily: 'USB',fontsize: 30),),
                //Text("Welcome Back...",style: ts18(ColorUtil.primaryTextColor2),),
                const SizedBox(height: 20,),
                Text(Language.enterPin,style: ts18(Color(0XFF000000),fontfamily: 'USB'),),
                const SizedBox(height: 20,),
                pinWidget,
                const SizedBox(height: 50,),
                /*DoneBtn(
                    onDone: (){
                      //Get.off(CutomerLogin());
                      if(pinWidget.validate()){
                        login(pinWidget.getValue());
                      }
                    },
                    title: "Login"
                ),
                const SizedBox(height: 30,),*/
                DoneBtn(
                    onDone: (){
                      clearUserSessionDetail();
                    },
                    title: Language.logWithEmail
                ),
              ],
            ),
          ),
          Obx(() => Loader(value: showLoader.value,))
        ],
      ),
    ));
  }
  void login(pin) async{

    List<ParameterModel> params=[];
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.multiLoginSp));
    params.add(ParameterModel(Key: "UserName", Type: "String", Value: await getSharedPrefString(SP_USEREMAIL)));
    params.add(ParameterModel(Key: "Password", Type: "String", Value: await getSharedPrefString(SP_USERPASSWORD)));
    params.add(ParameterModel(Key: "DeviceId", Type: "String", Value: getDeviceId()));
    params.add(ParameterModel(Key: "Type", Type: "String", Value: 2));
    params.add(ParameterModel(Key: "MPINNumber", Type: "String", Value: pin));
    params.add(ParameterModel(Key: "OTPNumber", Type: "String", Value: null));
    ApiManager().GetInvokeLogin(params).then((response) async {
      if(response[0]){
        var parsed=json.decode(response[1]);
        log("pin $parsed");
        var t =parsed['Table'];

        if(t.length>0){
          setUserSessionDetail(parsed["Table"][0]);
          accessData=parsed['Table1'];
          String nb=await getSharedPrefString(SP_NOTIFICATIONBODY);
          if(nb.isEmpty){
            navigateByUserType();
          }
          else{
           // checkNotiPurpose(jsonDecode(nb));
           // setSharedPrefString("", SP_NOTIFICATIONBODY);
          }
        }
        else {
          //CustomAlert().commonErrorAlert("User Not Found...", "");
        }
      }
    });
  }
}
