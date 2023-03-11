import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../helper/language.dart';
import '../../navHomeScreen.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/loader.dart';
import '../../api/ApiManager.dart';
import '../../api/sp.dart';
import '../../model/parameterMode.dart';
import '../../notifier/configuration.dart';
import '../../utils/colorUtil.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../widgets/alertDialog.dart';
// import '../navHomeScreen.dart';
import 'pinScreenSettings.dart';


class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);
  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final _text = TextEditingController();
  final _text1 = TextEditingController();
  bool obsureText = true;

  @override
  void initState(){
    // menuSel.value=13;
    // loadCredentials();
    // allowAccess();
    super.initState();
  }

  @override
  void dispose() {
    _text.dispose();
    _text1.dispose();
    super.dispose();
  }

  // allowAccess() async{
  //   //  final PermissionHandler _permissionHandler = PermissionHandler();
  //   var result = await Permission.storage.request();
  //   console("result ${result.isGranted}");
  //   if(result == PermissionStatus.granted) {
  //
  //   }
  // }

  // void loadCredentials() async{
  //   _text.text=await getSharedPrefString(SP_USEREMAIL);
  //   _text1.text=await getSharedPrefString(SP_USERPASSWORD);
  // }

  late  double width,height,width2,height2;
  var isKeyboardVisible=false.obs;
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    width2=width-16;
    height2=height-16;
    isKeyboardVisible.value = MediaQuery.of(context).viewInsets.bottom != 0;
    return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0XFFFFFFFF),
                        Color(0XFFFFFFFF),
                      ],
                    )
                ),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/logo.png',width: 250,),
                      Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.all(20.0),
                            padding: EdgeInsets.only(top: 50.0,bottom: 150,left: 20,right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              // color: ColorUtil.themeWhite
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(Language.loginTitle['Value'],style: TextStyle(fontSize: Language.loginTitle['FontSize'],fontFamily: Language.loginTitle['FontFamily'],color: Color(0XFF000000)),),
                                const SizedBox(height: 5,),
                                Text(Language.yourAccount['Value'],style: TextStyle(fontSize: Language.yourAccount['FontSize'],fontFamily: Language.yourAccount['FontFamily'],color: ColorUtil.text4),),
                                const SizedBox(height: 20,),
                                TextField(
                                  controller: _text,
                                  textAlignVertical: TextAlignVertical.center,
                                  textAlign: TextAlign.left,
                                  maxLines: 1,
                                  style:TextStyle(fontSize: 14,fontFamily:'RR',color:Color(0XFF000000),letterSpacing: 1.0,),
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    enabledBorder: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        borderSide: BorderSide(color: ColorUtil.text4)
                                    ),
                                    border: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        borderSide: BorderSide(color: Colors.white)
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.green),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    prefixIcon: Icon(Icons.person_outline_outlined,size: 20,color: ColorUtil.text4),
                                    hintText: Language.enterEmail,
                                    errorStyle: TextStyle(fontSize: 14,fontFamily:Language.regularFF,color:Color(0XFFBCBBCD),),
                                    hintStyle:TextStyle(fontSize: 14,fontFamily:Language.regularFF,color:Color(0XFFBCBBCD),),
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(top:10),
                                  child: TextField(
                                    controller: _text1,
                                    textAlignVertical: TextAlignVertical.center,
                                    textAlign: TextAlign.left,
                                    maxLines: 1,
                                    obscureText: obsureText,
                                    style:TextStyle(fontSize: 14,fontFamily:'RR',color:Color(0XFF000000),letterSpacing: 1.0,),
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      enabledBorder: UnderlineInputBorder(
                                          borderRadius: BorderRadius.circular(30.0),
                                          borderSide: BorderSide(color: ColorUtil.text4)
                                      ),
                                      border: UnderlineInputBorder(
                                          borderRadius: BorderRadius.circular(30.0),
                                          borderSide: BorderSide(color: Colors.white)
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.green),
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      prefixIcon: Icon(Icons.lock,size: 20,color: ColorUtil.text4),
                                      hintText: Language.enterPassword,
                                      errorStyle: TextStyle(fontSize: 14,fontFamily:Language.regularFF,color:Color(0XFFBCBBCD),),
                                      hintStyle:TextStyle(fontSize: 14,fontFamily:Language.regularFF,color:Color(0XFFBCBBCD),),
                                      suffixIcon: GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            obsureText=!obsureText;
                                          });
                                        },
                                        child: Container(
                                            height: 30,
                                            width: 30,
                                            alignment: Alignment.center,
                                            margin: const EdgeInsets.only(right: 10),
                                            child: Icon(!obsureText?Icons.visibility_off_outlined:Icons.visibility_outlined,color: ColorUtil.primary,)
                                        ),
                                      ),
                                    ),

                                    // onEditingComplete: (){
                                    //   login();
                                    // },
                                  ),
                                ),
                                const SizedBox(height: 40,),
                                GestureDetector(
                                  onTap: (){
                                    // Get.to(Masterpage());
                                    // Get.to(CooardinatorHomePage());

                                    // login();
                                   fadeRoute(Masterpage());
                                  },
                                  child: Container(
                                    width: width*0.6,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: ColorUtil.primary.withOpacity(0.7),
                                          blurRadius: 15.0, // soften the shadow
                                          spreadRadius: 0.0, //extend the shadow
                                          offset: Offset(
                                            0.0, // Move to right 10  horizontally
                                            0.0, // Move to bottom 10 Vertically
                                          ),
                                        )
                                      ],
                                      color: ColorUtil.primary,
                                    ),
                                    child:Center(child: Text(Language.login['Value'],style: TextStyle(fontSize: Language.login['FontSize'],color: Color(0xffffffff),fontFamily:Language.login['FontFamily']), )) ,
                                  ),
                                ),
                                const SizedBox(height: 20,),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Positioned(
              //   top: 20,
              //   right: 20,
              //   child: LanguageSwitch(
              //     onChange: (){
              //       setState(() {});
              //     },
              //   ),
              // ),
              Obx(() => Visibility(
                  visible: !isKeyboardVisible.value,
                  child:  Align(
                alignment: Alignment.bottomCenter,
                child: Text("v - ${MyConstants.appVersion}",style: const TextStyle(height: 3),),
              ))),
              Obx(() => Loader(value: showLoader.value,))
            ],
          ),
        ),
    );
  }
  // login() async{
  //  /* Get.to(MyHomePage());
  //   return;*/
  //   if(_text.text.isEmpty){
  //     CustomAlert().cupertinoAlert("${Language.enterEmail}....");
  //     return;
  //   }
  //   if(_text1.text.isEmpty){
  //     CustomAlert().cupertinoAlert("${Language.enterPassword}....");
  //     return;
  //   }
  //   List<ParameterModel> params=[];
  //   params.add(ParameterModel(Key: "SpName", Type: "String", Value: Sp.loginSp));
  //   params.add(ParameterModel(Key: "UserName", Type: "String", Value: _text.text));
  //   params.add(ParameterModel(Key: "Password", Type: "String", Value: _text1.text));
  //   params.add(ParameterModel(Key: "DeviceId", Type: "String", Value: getDeviceId()));
  //   ApiManager().GetInvoke(params).then((value){
  //     if(value[0]){
  //       console(value);
  //       var parsed=json.decode(value[1]);
  //       try{
  //         setUserSessionDetail(parsed["Table"][0]);
  //         accessData=parsed['Table1'];
  //         Get.close(2);
  //         Get.to(PinScreenSettings(fromLogin: true,));
  //         //Get.to(MyHomePage());
  //       }catch(e){}
  //       //print(parsed);
  //     }
  //   });
  // }
}
