import 'dart:convert';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/utils.dart';


final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
Map<String, dynamic> deviceData = <String, dynamic>{};

Future<void> initPlatformState() async {
  try {
    if (Platform.isAndroid) {
      deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
    } else if (Platform.isIOS) {
       deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
    }
  } on PlatformException {
    deviceData = <String, dynamic>{
      'Error:': 'Failed to get platform version.'
    };
  }

/*  Directory? directory=await getApplicationPath();
  final dir = Directory(directory!.path);
  dir.deleteSync(recursive: true);*/
}

Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
  return <String, dynamic>{
    'version.securityPatch': build.version.securityPatch,
    'version.sdkInt': build.version.sdkInt,
    'version.release': build.version.release,
    'version.previewSdkInt': build.version.previewSdkInt,
    'version.incremental': build.version.incremental,
    'version.codename': build.version.codename,
    'version.baseOS': build.version.baseOS,
    'board': build.board,
    'bootloader': build.bootloader,
    'brand': build.brand,
    'device': build.device,
    'display': build.display,
    'fingerprint': build.fingerprint,
    'hardware': build.hardware,
    'host': build.host,
    'id': build.id,
    'manufacturer': build.manufacturer,
    'model': build.model,
    'product': build.product,
    'supported32BitAbis': build.supported32BitAbis,
    'supported64BitAbis': build.supported64BitAbis,
    'supportedAbis': build.supportedAbis,
    'tags': build.tags,
    'type': build.type,
    'isPhysicalDevice': build.isPhysicalDevice,
    'androidId': build.androidId,
    'systemFeatures': build.systemFeatures,
    'ver':build.version.toString()
  };
}

Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
  return <String, dynamic>{
    'name': data.name,
    'systemName': data.systemName,
    'systemVersion': data.systemVersion,
    'model': data.model,
    'localizedModel': data.localizedModel,
    'identifierForVendor': data.identifierForVendor,
    'isPhysicalDevice': data.isPhysicalDevice,
    'utsname.sysname:': data.utsname.sysname,
    'utsname.nodename:': data.utsname.nodename,
    'utsname.release:': data.utsname.release,
    'utsname.version:': data.utsname.version,
    'utsname.machine:': data.utsname.machine,
  };
}

getDeviceId(){
  return deviceData['id'];
}

setSharedPrefBool(bool value,String key) async{
  SharedPreferences sp=await SharedPreferences.getInstance();
  sp.setBool(key, value);
}
getSharedPrefBool(String key) async{
  SharedPreferences sp=await SharedPreferences.getInstance();
  return sp.getBool(key)??false;
}

setSharedPrefString(dynamic value,String key) async{
  SharedPreferences sp=await SharedPreferences.getInstance();
  sp.setString(key, value ==null?"":value.toString());
}
Future<String> getSharedPrefString(String key) async{
  SharedPreferences sp=await SharedPreferences.getInstance();
  return sp.getString(key)??"";
}

void setSharedPrefList(key, value) async{
  SharedPreferences sp=await SharedPreferences.getInstance();
  sp.setString(key, json.encode(value));
}

getSharedPrefList(key) async{
  SharedPreferences sp=await SharedPreferences.getInstance();
  return json.decode(sp.getString(key)??"");
}



const String SP_USER_ID="userid";
const String SP_PIN="pin";
const String SP_USERTYPEID="UserTypeId";
const String SP_USERTYPENAME="UserGroup";
const String SP_TOKEN="tokennumber";
const String SP_USEREMAIL="c1";
const String SP_USERPASSWORD="c2";
const String SP_ISDEVICESUPPORT="devicesupport";
const String SP_HASFINGERPRINT="hasfingerprint";
const String SP_ALLOWFINGERPRINT="allowfingerprint";
const String SP_USERNAME="username";
const String SP_COMPANYID="companyid";
const String SP_CURRENTCALLAPPOINTMENTID="appointmentid";
const String SP_CURRENTCALLCLIENTOUTLETID="curroutletid";
const String SP_FIREBASETOKEN="ft";
const String SP_NOTIFICATIONBODY="nb";

enum UserType{
  defaultt,
  shopKeeper,
  customer
}

void setUserSessionDetail(userDetail){
  setSharedPrefString(userDetail["UserId"], SP_USER_ID);
  setSharedPrefString(userDetail["Name"], SP_USERNAME);
  setSharedPrefString(userDetail["UserEmail"], SP_USEREMAIL);
  setSharedPrefString(userDetail["UserPassword"], SP_USERPASSWORD);
  setSharedPrefString(userDetail["UserGroupName"], SP_USERTYPENAME);
  setSharedPrefString(userDetail["UserGroupId"], SP_USERTYPEID);
}

void clearUserSessionDetail(){
  setSharedPrefString("", SP_USER_ID);
  setSharedPrefString("", SP_USERNAME);
  setSharedPrefString("", SP_USERTYPENAME);
  setSharedPrefString("", SP_USERTYPEID);
  setSharedPrefString("", SP_PIN);
  setSharedPrefString("", SP_TOKEN);
  //Get.off(()=>const SlideSwipe());
}

navigateByUserType() async{
  String ut=await getSharedPrefString(SP_USERTYPEID);
  if(ut=="1" || ut=="2" || ut=="11"){
   // setPageNumber(14);

    if(!isHasAccess(accessId["DashBoardView"])){

     // setPageNumber(1);
    }
  }
  else {
    //setPageNumber(13);
    if(!isHasAccess(accessId["HomeView"])){
      //setPageNumber(1);
    }
  }
 // Get.off(()=>MyHomePage());
}