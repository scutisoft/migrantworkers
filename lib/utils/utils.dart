import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../helper/language.dart';
import '../widgets/alertDialog.dart';
import '../widgets/recase.dart';

import '../utils/colorUtil.dart';
import 'package:flutter/material.dart';

Map<String,dynamic> accessId={
  "ManageUsersView":3,
  "ManageUsersAdd":4,
  "ManageUsersEdit":5,
  "ManageUsersDelete":6,
  "UserAccessView":7,
  "UserAccessEdit":8,
  "SettingsMainView":9,
  "SettingsZoneView":9,
  "SettingsCompanyView":9,
  "SettingsCoordinatorView":9,
  "SettingsZoneAdd":10,
  "SettingsCoordinatorAdd":10,
  "SettingsZoneEdit":11,
  "SettingsCoordinatorEdit":11,
  "SettingsZoneDelete":12,
  "SettingsCoordinatorDelete":12,
  "VolunteerView":13,
  "VolunteerDelete":14,
  "VolunteerApproval":15,
  "LandParcelView":16,
  "LandParcelAdd":17,
  "LandParcelEdit":18,
  "LandParcelDelete":19,
  "LandParcelApproval":20,
  "DashBoardView":21,
  "HomeView":22,
  "SeedCollectionView":23,
  "SeedCollectionAdd":24,
  "SeedCollectionEdit":25,
  "SeedCollectionDelete":26,
  "SeedCollectionApproval":27,
  "NurseryView":28,
  "NurseryAdd":29,
  "NurseryEdit":30,
  "NurseryDelete":31,
  "NurseryApproval":36,
  "PlantationView":32,
  "PlantationAdd":33,
  "PlantationEdit":34,
  "PlantationDelete":35,
  "PlantationApproved":37,
  "CSRDashboardView":38,
  "EventsView":39,
  "EventsAdd":40,
  "EventsEdit":41,
  "EventsDelete":42,
  "EventsApproved":43,
  "EventsInterestedView":44,
  "NewsFeedView":45,
  "NewsFeedAdd":46,
  "NewsFeedEdit":47,
  "NewsFeedDelete":48,
  "DonorView":49,
  "DonorAdd":50,
  "EGFZoneApproval":51
};
List<dynamic> accessData=[];
bool isHasAccess(int uniqueId){
  try{
    int IsHasAccess=accessData.where((element) => element['UniqueId']==uniqueId).toList()[0]['IsHasAccess'];
    return IsHasAccess==1;
  }catch(e){
    return false;
  }
}


parseDouble(var value){
  try{
    return double.parse(value.toString());
  }catch(e){}
  return 0.0;
}

parseInt(var value){
  try{
    return int.parse(value.toString());
  }catch(e){}
  return 0;
}


void console(var content){
  log(content.toString());
}
enum PayStatus{
  payStatus,
  pay,
  paid,
  partiallyPaid,
  approved,
  rejected,
  completed,
  partialApproved,
  pending
}
Color getPaymentStsClr(String? id){
  if(id.toString().toLowerCase()=="paid"){
    return ColorUtil.paidClr;
  }
  else if(id.toString().toLowerCase()=="cancelled"){
    return ColorUtil.rejectClr;
  }
  else if(id.toString().toLowerCase()=="cancel"){
    return ColorUtil.rejectClr;
  }
  return ColorUtil.rejectClr;
}

Color getStatusClr(String status){
  if(status=="Approved"){
    return ColorUtil.approvedClr;
  }
  else{
    return ColorUtil.rejectClr;
  }
}

String getTitleCase(value){
  return value.toString().titleCase;
}

//Nested ScrollView
double flexibleSpaceBarHeight=160.0;
double toolBarHeight=50.0;
double triggerOffset=60.0;
double triggerEndOffset=80.0;

void assignWidgetErrorToast(e,t){
  CustomAlert().cupertinoAlert("$e\n\n\n$t");
}

Widget formGridContainer(List<Widget> children){
  return Container(
      margin: const EdgeInsets.only(top: 15,bottom: 20,left: 15,right: 15),
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
      color: ColorUtil.primary.withOpacity(0.3),
      borderRadius: BorderRadius.circular(5)
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    ),
  );
}

Widget formTableHeader(String title,{bool needFittedBox=false}){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child:needFittedBox? Container(
        height: 15,
        child: FittedBox(
            alignment: Alignment.centerLeft,
            child: Text(title,style: ColorUtil.formTableHeaderTS,)
        )
    ):Text(title,style: ColorUtil.formTableHeaderTS,),
  );
}

Widget gridCardText(String title,var value,{bool isBold=false,TextOverflow? textOverflow,int? maxLines}){
  return Padding(
    padding: const EdgeInsets.only(bottom: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$title : ",style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: Language.regularFF),),
        Flexible(
            child: Text("$value",style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: isBold?Language.boldFF:Language.regularFF),overflow: textOverflow,
            maxLines: maxLines,)
        ),
      ],
    ),
  );
}
Widget gridCardText2(String title,var value,{bool isBold=false,TextOverflow? textOverflow}){
  return Padding(
    padding: const EdgeInsets.only(bottom: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(child: Text("$title : ",style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: Language.regularFF),)),
        const SizedBox(width: 5,),
        Flexible(
          flex: 2,
            child: Text("$value",style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: isBold?Language.boldFF:Language.regularFF),overflow: textOverflow,)
        ),
      ],
    ),
  );
}

Map tamilText={
  "Thavaraviyal Peyar":"தாவரவியல் பெயர்",
  "Thavara Kudumbam":"தாவர குடும்பம்",
  "Thavaraviyal Peyar":"தாவரவியல் பெயர்",
  "Man Vagai":"மண் வகை",
  "Matra Peyaragal":"மற்ற பெயர்கள்"
};

String getTamilWord(String text){
  return tamilText[text]??text;
}

const String egfCompanyId="1";

enum PaymentGateway{
  razorpay,
  cashFree
}

Map getParamsFromUrl(url) {
  var params = {};
  try{
    url.split('?')[1].split('&').forEach((i) {
      params[i.split('=')[0]] = i.split('=')[1];
    });
  }catch(e){}
  return params;
}

Future<Directory?> getApplicationPath() async{
  if(Platform.isAndroid){
    return await getExternalStorageDirectory();
  }
  return await getApplicationDocumentsDirectory();
}

String getFileNameFromFolderPath(String dbPath){
  try{
    return dbPath.split("/")[1];
  }catch(e){}
  return '';
}


String getFolderNameFromFolderPath(String dbPath){
  try{
    return dbPath.split("/")[0];
  }catch(e){}
  return '';
}