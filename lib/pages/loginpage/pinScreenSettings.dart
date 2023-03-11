import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:math' as math;
import '../../api/ApiManager.dart';
import '../../api/apiUtils.dart';
import '../../api/sp.dart';
import '../../model/parameterMode.dart';
import '../../notifier/configuration.dart';
import '../../utils/colorUtil.dart';
import '../../utils/constants.dart';
import '../../utils/sizeLocal.dart';
import '../../utils/utils.dart';
import '../../widgets/alertDialog.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/loader.dart';
import '../../widgets/pinWidget.dart';
import '../../helper/language.dart';


class PinScreenSettings extends StatefulWidget {
  bool fromLogin;
  PinScreenSettings({this.fromLogin=false});
  @override
  State<PinScreenSettings> createState() => _PinScreenSettingsState();
}

class _PinScreenSettingsState extends State<PinScreenSettings> {

  bool hasPin=false;
  PinWidget pinWidget=PinWidget(pinLength: 6,onComplete: (){},);
  PinWidget confirmPinWidget=PinWidget(pinLength: 6,onComplete: (){},);
  @override
  void initState(){
    getPinStatus();
    pinWidget.onComplete=(){
      confirmPinWidget.requestFocus();
    };
    confirmPinWidget.onComplete=(){
      if(pinWidget.validate() && confirmPinWidget.validate()){
        if(pinWidget.getValue()!=confirmPinWidget.getValue()){
          CustomAlert().cupertinoAlert(Language.pinDoesntMatch, );
        }
        else{
          fingerPrintAllowDialog(pinWidget.getValue());
          //createPin(pinWidget.getValue());
        }
      }
    };
    super.initState();
  }

  void getPinStatus() async{
    String pinNo=await getSharedPrefString(SP_PIN);
    log("pinBo $pinNo");
    if(widget.fromLogin){
      setState((){
        hasPin=pinNo.isNotEmpty;
      });
      if(pinNo.isNotEmpty){
        navigateByUserType();
      }
    }
    else{
      setState((){
        hasPin=pinNo.isNotEmpty;
      });
    }

  }

  double fingerPrintDialogWidth=0.0;

  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);
    fingerPrintDialogWidth=SizeConfig.screenWidth!*0.9;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorUtil.greyLite.withOpacity(0.96),
        body: Stack(
          children: [
          /*  Positioned(
              left: -100,
              child: Transform.rotate(
                angle: -math.pi / 12.0,
                child: Container(
                  height: 100,
                  width: SizeConfig.screenWidth!*2,
                  color: Color(0xfff3f3f3),
                ),
              ),
            ),*/
            Container(
              height: SizeConfig.screenHeight,
              decoration: BoxDecoration(
                //color: Colors.transparent,
                  /*image: DecorationImage(
                    image: AssetImage('assets/login/login-bg.jpg'),fit: BoxFit.cover,
                  )*/
              ),
              child: Column(
                children: [
                  CustomAppBar(
                    title: hasPin?Language.resetPin:Language.createPin,
                    suffix: Visibility(
                        visible: widget.fromLogin,
                        child: TextButton(onPressed: (){
                              insertDeviceInfo("");
                              navigateByUserType();
                             // checkHasCall();
                            },
                            child: Text("${Language.skip}   ",style: ts18(ColorUtil.red,fontfamily: 'Bold',),))
                    ),
                    prefix: GestureDetector(
                      onTap:(){
                        clearUserSessionDetail();
                      },
                      child: Container(
                          height:50,
                          width:50,
                          color: Colors.transparent,
                          child: Icon(Icons.arrow_back_ios_new_outlined,color: ColorUtil.themeBlack,size: 20,)
                      ),
                    ),
                  ),
                  Visibility(
                      visible: !hasPin,
                      child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 20,),
                        LeftAlignHeader(title: Language.newPin),
                        pinWidget,
                        const SizedBox(height: 20,),
                        LeftAlignHeader(title: Language.confirmPin),
                        confirmPinWidget,
                        const SizedBox(height: 30,),
                        DoneBtn(
                          title: Language.setPin,
                          onDone: (){
                            if(pinWidget.validate() && confirmPinWidget.validate()){
                              if(pinWidget.getValue()!=confirmPinWidget.getValue()){
                                CustomAlert().commonErrorAlert(Language.pinDoesntMatch, "");
                              }
                              else{
                                fingerPrintAllowDialog(pinWidget.getValue());
                                //createPin(pinWidget.getValue());
                              }
                            }
                          },
                        )
                      ],
                    )
                  )

                 /* Container(
                    height: 50,
                    child: Row(
                      children: [
                        ArrowBack(
                          onTap: (){
                            Get.back();
                          },
                        ),
                        Text(hasPin?"Reset Pin":"Create Pin",style: ts18(ColorUtil.primaryTextColor2),)
                      ],
                    ),
                  ),*/

                ],
              ),
            ),
            Obx(() => Loader(
              value: showLoader.value,
            ))
          ],
        ),
      ),
    );
  }


  void fingerPrintAllowDialog(String pin) async{
    bool hasFingerPrint=await getSharedPrefBool(SP_HASFINGERPRINT);
    if(hasFingerPrint){
      showDialog(
          barrierDismissible: false,
          context: Get.context!,
          builder: (ctx) => AlertDialog(
            contentPadding: const EdgeInsets.all(15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
            clipBehavior: Clip.antiAlias,
            content: Container(
                width: fingerPrintDialogWidth,
                decoration:BoxDecoration(
                  color:Colors.white,
                ),
                //  padding: pad,
                child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children:[
                      //SizedBox(height:20),
                      // SvgPicture.asset(img),
                      Icon(Icons.fingerprint,color: ColorUtil.secondary,size: 50,),
                      SizedBox(height:30),
                      Container(
                        //width: textWidth,
                        child: Text(Language.fingerPrintContent,
                          style:TextStyle(fontFamily:Language.regularFF,fontSize:23,color:Color(0xFF787878),letterSpacing: 0.5,
                              height: 1.5),textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(height:30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          GestureDetector(
                            onTap:(){
                              Get.back();
                              setSharedPrefBool(false, SP_ALLOWFINGERPRINT);
                              createPin(pin);
                              // cancelCallback!();
                            },
                            child: Container(
                              height: 50.0,
                              width: (fingerPrintDialogWidth-30)*0.4,
                              //margin: EdgeInsets.only(bottom: 0,top:20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFFE4E4E4),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color:Color(0xFF808080).withOpacity(0.6),
                                //     offset: const Offset(0, 8.0),
                                //     blurRadius: 15.0,
                                //     // spreadRadius: 2.0,
                                //   ),
                                // ]
                              ),
                              child: Center(
                                child: Text(Language.no,
                                  style: TextStyle(fontFamily:'RR',color: Color(0xFF808080),fontSize: 16),
                                ),
                              ),
                            ),
                          ),



                          GestureDetector(
                            onTap:(){
                              Get.back();
                              _authenticateWithBiometrics(pin);
                            },
                            child: Container(
                              height: 50.0,
                              width: (fingerPrintDialogWidth-30)*0.4,
                              // margin: EdgeInsets.only(bottom: 0,top:20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorUtil.red,
                                // boxShadow: [
                                //   BoxShadow(
                                //     color:ColorUtil.red.withOpacity(0.6),
                                //     offset: const Offset(0, 8.0),
                                //     blurRadius: 15.0,
                                //     // spreadRadius: 2.0,
                                //   ),
                                // ]
                              ),
                              child: Center(
                                child: Text(Language.yes,
                                  style: TextStyle(fontFamily:'RR',color: Colors.white,fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),



                    ]
                )
            ),
          )
      );
    }
    else{
      createPin(pin);
    }
  }
  final LocalAuthentication auth = LocalAuthentication();
  Future<void> _authenticateWithBiometrics(String pin) async {
    bool authenticated = false;
    try {
      setState(() {});
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() { });
    } on PlatformException catch (e) {
      print(e);
      setState(() {  });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    if(authenticated){
      setSharedPrefBool(true, SP_ALLOWFINGERPRINT);
      createPin(pin);
      //navigateByUserType();
    }
    setState(() {  });
  }

  void createPin(String pin) async{
    List<ParameterModel> params=await getParameterEssential();
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.insertPin));
    params.add(ParameterModel(Key: "UserPINNumber", Type: "String", Value: pin));
    ApiManager().GetInvoke(params).then((response) async {
      if(response[0]){
        var parsed=json.decode(response[1]);
        console("createPin $parsed");
        insertDeviceInfo(pin);

        await setSharedPrefString(pin, SP_PIN);
        pinWidget.clearValues();
        confirmPinWidget.clearValues();
        getPinStatus();
        if(!widget.fromLogin) {
          CustomAlert().successAlert(parsed['TblOutPut'][0]['@Message'], '');
        }
      }
    });
  }

/*  void checkHasCall() async{
    String nb=await getSharedPrefString(SP_NOTIFICATIONBODY);
    if(nb.isEmpty){
      navigateByUserType();
    }
    else{
      checkNotiPurpose(jsonDecode(nb));
      setSharedPrefString("", SP_NOTIFICATIONBODY);
    }
  }*/

  void insertDeviceInfo(pin) async{
    String ft=await getSharedPrefString(SP_FIREBASETOKEN);
    List<ParameterModel> params=await getParameterEssential();
    params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.insertUserDevice));
    params.add(ParameterModel(Key: "MPINNumber", Type: "String", Value: pin));
    params.add(ParameterModel(Key: "DeviceInfo", Type: "String", Value: deviceData.toString()));
    params.add(ParameterModel(Key: "NotificationTokenNumber", Type: "String", Value: ft));
    //log("insertDeviceInfo ${jsonEncode(params)}");
    ApiManager().GetInvoke(params).then((response) async {
      if(response[0]){
        var parsed=json.decode(response[1]);
        console("insertDeviceInfo $parsed");
      }
    });
  }
}
