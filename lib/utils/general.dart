import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../api/apiUtils.dart';
import '../notifier/getUiNotifier.dart';
import 'colorUtil.dart';
import 'constants.dart';


class General{
  //Bala bro please note this ("users/HOME-PAGE-USER-9898") (users/fileName)
  //Add user json files in assets/json/users..........
  static String donateIdentifier=!MyConstants.fromUrl?"assets/json/users/donate.json":"E01D3C01-213D-49D0-A2AC-406FC72B1478";
  static String volunteerDetailIdentifier=!MyConstants.fromUrl?"assets/json/users/volunteerDetail.json":"02BEE340-2EB9-45A7-B89E-1129414BC238";
  static String addVolunteerIdentifier=!MyConstants.fromUrl?"assets/json/users/add-volunteer.json":"85C7DE06-9E9B-4532-9D3E-B740F164BBA6";
  static String viewVolunteerIdentifier=!MyConstants.fromUrl?"assets/json/users/volunteerView.json":"AF0D9D82-F943-48A3-BD89-46118B1D3174";
  static String addLandParcelIdentifier=!MyConstants.fromUrl?"assets/json/users/landParcelJSON/landParcel.json":"DACF7963-7A17-42A8-82B3-8DC83C072BCE";
  static String addLandParcelGirdIdentifier=!MyConstants.fromUrl?"assets/json/users/landParcelJSON/landParcelGrid.json":"C54B3AE0-24A6-4BC0-849B-C5F9C6FF9E07";
  static String addLandParcelViewIdentifier=!MyConstants.fromUrl?"assets/json/user/customerView.json":"4F219F7A-3203-420A-A816-D41627A002D3";
  static String addSeedCollectionFrmIdentifier=!MyConstants.fromUrl?"assets/json/users/seedCollectionForm.json":"9D888643-85F0-4EF7-80F0-E66150C99E82";
  static String addSeedGridViewIdentifier=!MyConstants.fromUrl?"assets/json/users/SeedingGrid.json":"24FEEB47-777D-4277-B2A4-D3066360FFC6";
  static String addSeedviewListIdentifier=!MyConstants.fromUrl?"assets/json/users/seedingView.json":"31741AB5-1321-413D-9457-7C73E5C10B15";
  static String addNurseryFormIdentifier=!MyConstants.fromUrl?"assets/json/users/NurseryForm.json":"204F5289-BD4A-4777-9C21-BB2CB5EEAEA8";
  static String NurseryGridIdentifier=!MyConstants.fromUrl?"assets/json/users/nurseryGrid.json":"7FA6DA79-4B5A-4D49-9F00-B793E327B0F9";
  static String NurseryViewIdentifier=!MyConstants.fromUrl?"assets/json/users/nurseryView.json":"012B1F87-406B-47C3-B40E-AB0BF1B6DB71";
  static String ProfileViewIdentifier=!MyConstants.fromUrl?"assets/json/users/MyProfile.json":"DEF0DF35-8B09-49DF-9560-06453BEFB043";
  static String EditProfileViewIdentifier=!MyConstants.fromUrl?"assets/json/users/Edit-Profile.json":"DEF0DF35-8B09-49DF-9560-06453BEFB043";
  static String HomePageViewIdentifier=!MyConstants.fromUrl?"assets/json/users/HomePage.json":"6F4207A7-8DF9-458B-9B99-D1386FCB2B93";
  static String PlantationGirdPageViewIdentifier=!MyConstants.fromUrl?"assets/json/users/plantationGrid.json":"26A643B8-C971-4E74-8892-FB729944678D";
  static String PlantationAddFormPageViewIdentifier=!MyConstants.fromUrl?"assets/json/users/plantationAddForm.json":"F7DD2926-CC63-4F3D-AC52-CA8AF87B3F84";
  static String PlantationViewPageViewIdentifier=!MyConstants.fromUrl?"assets/json/users/plantationView.json":"105E7E2B-D49C-4540-B05E-5D8F67FDEF4F";
  static String OurTreePageViewIdentifier=!MyConstants.fromUrl?"assets/json/users/ourtree.json":"590BFDD6-A659-4D53-B7C1-B0FE33F04E6B";
  static String TreeViewIdentifier=!MyConstants.fromUrl?"assets/json/users/treeView.json":"017525C2-4A67-4D5E-99E0-135F9DD1F880";
  static String TreeUsesViewIdentifier=!MyConstants.fromUrl?"assets/json/users/treeUsesView.json":"BF0756A9-441E-4DE8-89A4-F0276256D1DE";
  static String EventsGridViewIdentifier=!MyConstants.fromUrl?"assets/json/users/eventGrid.json":"105E7E2B-D49C-4540-B05E-5D8F67FDEF4F";
  static String NewsFeedGridViewIdentifier=!MyConstants.fromUrl?"assets/json/users/newsFeedGrid.json":"105E7E2B-D49C-4540-B05E-5D8F67FDEF4F";
  static String NewsFeedFormViewIdentifier=!MyConstants.fromUrl?"assets/json/users/newsFeedGrid.json":"105E7E2B-D49C-4540-B05E-5D8F67FDEF4F";
  static String EventsFormViewIdentifier=!MyConstants.fromUrl?"assets/json/users/newsFeedForm.json":"105E7E2B-D49C-4540-B05E-5D8F67FDEF4F";
  static String EventsViewIdentifier=!MyConstants.fromUrl?"assets/json/users/eventsView.json":"105E7E2B-D49C-4540-B05E-5D8F67FDEF4F";
  static String EventsInterestedIdentifier=!MyConstants.fromUrl?"assets/json/users/eventInterestedGrid.json":"105E7E2B-D49C-4540-B05E-5D8F67FDEF4F";
  static String CSRDashboardIdentifier=!MyConstants.fromUrl?"assets/json/users/csrDashbdGrid.json":"105E7E2B-D49C-4540-B05E-5D8F67FDEF4F";
  static String CSRGridIdentifier=!MyConstants.fromUrl?"assets/json/users/csrGrid.json":"105E7E2B-D49C-4540-B05E-5D8F67FDEF4F";
  static String CSRFormIdentifier=!MyConstants.fromUrl?"assets/json/users/csrForm.json":"105E7E2B-D49C-4540-B05E-5D8F67FDEF4F";
  static String ViewCSRGridIdentifier=!MyConstants.fromUrl?"assets/json/users/ViewCSRGrid.json":"105E7E2B-D49C-4540-B05E-5D8F67FDEF4F";
  static String ViewCustomerGridIdentifier=!MyConstants.fromUrl?"assets/json/user/customerGrid.json":"105E7E2B-D49C-4540-B05E-5D8F67FDEF4F";
  static String ViewDonorFormIdentifier=!MyConstants.fromUrl?"assets/json/users/donorForm.json":"105E7E2B-D49C-4540-B05E-5D8F67FDEF4F";
  static String DonorViewDetailsIdentifier=!MyConstants.fromUrl?"assets/json/users/donorViewGrid.json":"105E7E2B-D49C-4540-B05E-5D8F67FDEF4F";
  static String CSRAddAmountIdentifier=!MyConstants.fromUrl?"assets/json/users/csrAddAmountForm.json":"105E7E2B-D49C-4540-B05E-5D8F67FDEF4F";
  static String DonorAddAmountIdentifier=!MyConstants.fromUrl?"assets/json/users/DonorAddAmountForm.json":"105E7E2B-D49C-4540-B05E-5D8F67FDEF4F";
  static String PlantingAmtGridIdentifier=!MyConstants.fromUrl?"assets/json/users/plantingAmtGrid.json":"105E7E2B-D49C-4540-B05E-5D8F67FDEF4F";


  static String eventName="eventName";
  static String FormSubmit="FormSubmit";
  static String Navigation="Navigation";
  static String openDrawer="OpenDrawer";
  static String formSubmitNavigate="FormSubmitNavigate";
  static String formDataJson_ApiCall="formDataJson_ApiCall";

  static String changeValues="changeValues";
  static String changeValuesArray="changeValuesArray";
  static String locationClick="locationClick";
  static String navigateToPage="navigateToPage";
  static String typeOfNavigation="typeOfNavigation";
  static String actionType="actionType";
  static String openMap="openMap";
  static String dynamicPageGuid="dynamicPageGuid";
  static String changePageViewIndex="changePageViewIndex";
  static String pageViewPrevious="pageViewPrevious";
  static String openDialer="OpenDialer";
  static String openDialog="openDialog";
  static String openDatePicker="openDatePicker";
  static String reload="reload";
  static String getByIdArray="getByIdArray";

  checkApiCall(Map clickEvent,var res,String pageId) async{
    var val="";
    Get.defaultDialog(
      title: "",
      content: CircularProgressIndicator(),
      barrierDismissible: false,
    );
    await GetUiNotifier().postUiJson( await getLoginId(), pageId, res,clickEvent).then((value){
      Get.back();
      log("checkApiCall response $value");
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
      //val=value;

    });
    return val;
  }


  showAlertPopUp(String message){
    Get.defaultDialog(
        title: "",
        titleStyle: TextStyle(height: 0.0),
        middleTextStyle: TextStyle(height: 0.0),
        middleText: "",
        content: Column(
          children: [
            Image.asset("assets/icons/sucess.gif",height: 150,),
            SizedBox(height: 15,),
            Text("$message",style: ts18(ColorUtil.text2),textAlign: TextAlign.center,),
            SizedBox(height: 15,),
            GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Container(
                height: 35,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: ColorUtil.theme
                ),
                alignment: Alignment.center,
                child: Text("Ok",style: ts15(ColorUtil.primary),),
              ),
            )
          ],
        )
    );
  }

  showSuccessPopUp(String message){
    Get.defaultDialog(
        title: "",
        titleStyle: TextStyle(height: 0.0),
        middleTextStyle: TextStyle(height: 0.0),
        middleText: "",
        content: Column(
          children: [
            Image.asset("assets/icons/sucess.gif",height: 150,),
            SizedBox(height: 15,),
            Text("$message",style: ts18(ColorUtil.text2),textAlign: TextAlign.center,),
            SizedBox(height: 15,),
            GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Container(
                height: 35,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: ColorUtil.theme
                ),
                alignment: Alignment.center,
                child: Text("Ok",style: ts15(ColorUtil.primary),),
              ),
            )
          ],
        )
    );
  }


  getPage(String page,{String dynamicPageIdentifier="",String dataJson=""}){
    switch(page){
    }
    return Container();
  }


}