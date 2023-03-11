
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api/sp.dart';
import '../../utils/utils.dart';
import '../../widgets/customWidgetsForDynamicParser/searchDrp2.dart';
import '../../widgets/loader.dart';
import '../../../HappyExtension/extensionHelper.dart';
import '../../../HappyExtension/utilWidgets.dart';
import '../../../utils/colorUtil.dart';
import '../../../utils/constants.dart';
import '../../../utils/general.dart';
import '../../../utils/sizeLocal.dart';
import '../../helper/language.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/logoPicker.dart';
import '../../widgets/searchDropdown/dropdown_search.dart';


class CustomerAddForm extends StatefulWidget {
  bool isEdit;
  String dataJson;
  Function? closeCb;
  CustomerAddForm({this.closeCb,this.dataJson="",this.isEdit=false});

  @override
  _CustomerAddFormState createState() => _CustomerAddFormState();
}

class _CustomerAddFormState extends State<CustomerAddForm> with HappyExtensionHelper  implements HappyExtensionHelperCallback{


  List<dynamic> widgets=[];
  ScrollController? silverController;

  @override
  void initState(){
    silverController= ScrollController();
    assignWidgets();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    });
    super.initState();
  }
  var node;

  String page="Events";
  var isKeyboardVisible=false.obs;
  @override
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    isKeyboardVisible.value = MediaQuery.of(context).viewInsets.bottom != 0;
    return SafeArea(
        bottom: MyConstants.bottomSafeArea,
        child: Scaffold(
          backgroundColor: Color(0XFFF3F3F3),
          resizeToAvoidBottomInset: true,
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  elevation: 0,
                  toolbarHeight: 60,
                  backgroundColor: ColorUtil.themeWhite,
                  leading: Container(),
                  actions: [
                    Container(
                      width: SizeConfig.screenWidth,
                      height: 80,
                      child: Container(
                        child:  Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ArrowBack(
                              iconColor: ColorUtil.themeBlack,
                              onTap: (){
                                Get.back();
                              },
                            ),
                            Text('Add Customer Info',style: ts18(ColorUtil.themeBlack,fontfamily: 'Bold'),textAlign: TextAlign.left,),
                          ],
                        ),
                      ),
                    ),
                  ],
                  floating: true,
                  snap: true,
                  pinned: true,
                ),
              ];
            },
            body:Stack(
              children: [
                Container(
                  height: SizeConfig.screenHeight,
                  child:  ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                          padding: const EdgeInsets.only(left: 15,top: 15,bottom: 10),
                          child: Text('Personal Details',
                            style: ts16(ColorUtil.themeBlack,fontfamily: 'Med'), )
                      ),
                     Row(
                       children: [
                         Container(
                           width: SizeConfig.screenWidth!*0.5,
                           child:  widgets[0],
                         ) ,
                         Container(
                           width: SizeConfig.screenWidth!*0.5,
                           child:  widgets[1],
                         )
                       ],
                     ),
                      widgets[2],
                      widgets[3],
                      widgets[4],
                      widgets[5],
                      widgets[6],
                      widgets[7],
                      Container(
                          padding: const EdgeInsets.only(left: 15,top: 15,bottom: 10),
                          child: Text('Roof Details',
                            style: ts16(ColorUtil.themeBlack,fontfamily: 'Med'), )
                      ),
                      widgets[8],
                      SizedBox(height: 20,),
                      widgets[9],
                      widgets[10],
                      widgets[11],
                      widgets[12],
                      widgets[13],
                      widgets[14],
                      widgets[15],
                      widgets[16],
                      widgets[17],
                      const SizedBox(height: 100,),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Obx(() => Container(
                    margin: const EdgeInsets.only(top: 0,bottom: 0),
                    height: isKeyboardVisible.value?0:70,
                    width: SizeConfig.screenWidth,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: Container(
                            width: SizeConfig.screenWidth!*0.4,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(color: ColorUtil.primary),
                              color: ColorUtil.primary.withOpacity(0.3),
                            ),
                            child:Center(child: Text(Language.cancel,style: ts16(ColorUtil.primary,), )) ,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            sysSubmit(widgets,
                                isEdit: widget.isEdit,
                                successCallback: (e){
                                  if(widget.closeCb!=null){
                                    widget.closeCb!(e);
                                  }
                                },
                                developmentMode: DevelopmentMode.traditional,
                              traditionalParam: TraditionalParam(
                                getByIdSp: Sp.getByIdNewsFeedDetail,
                                insertSp: Sp.insertNewsFeedDetail,
                                updateSp: Sp.updateNewsFeedDetail
                              )
                            );
                          },
                          child: Container(
                            width: SizeConfig.screenWidth!*0.4,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: ColorUtil.primary,
                            ),
                            child:Center(child: Text(Language.save,style: ts16(ColorUtil.themeWhite,), )) ,
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
                ShimmerLoader(),
              ],
            ),
          ),
        )
    );
  }

  @override
  void assignWidgets() async{

    widgets.add(AddNewLabelTextField(
      dataname: 'FirstName',
      hasInput: true,
      required: true,
      maxlines: 1,
      labelText: 'First Name',
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//0
    widgets.add(AddNewLabelTextField(
      dataname: 'Last Name',
      hasInput: true,
      required: true,
      maxlines: 1,
      labelText: 'Name',
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//1
    widgets.add(AddNewLabelTextField(
      dataname: 'PhoneNo',
      hasInput: true,
      required: true,
      maxlines: 1,
      textLength: 10,
      textInputType: TextInputType.number,
      labelText: 'Contact Number',
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//2
    widgets.add(AddNewLabelTextField(
      dataname: 'Address',
      hasInput: true,
      required: true,
      maxlines: null,
      labelText: 'Address',
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//3


    widgets.add(AddNewLabelTextField(
      dataname: 'City',
      hasInput: true,
      required: true,
      maxlines: null,
      labelText: 'City',
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//4
    widgets.add(AddNewLabelTextField(
      dataname: 'State',
      hasInput: true,
      required: true,
      maxlines: 1,
      labelText: 'State',
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//5
    widgets.add(AddNewLabelTextField(
      dataname: 'Pincode',
      hasInput: true,
      required: true,
      maxlines: null,
      textInputType: TextInputType.number,
      labelText: 'Pincode',
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//6
    widgets.add(AddNewLabelTextField(
      dataname: 'LandMark',
      hasInput: true,
      required: true,
      maxlines: 1,
      labelText: 'Land Mark',
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//7
    widgets.add(AddNewLabelTextField(
      dataname: 'TotalRoof',
      hasInput: true,
      required: true,
      maxlines: 1,
      textInputType: TextInputType.number,
      labelText: 'Total Roof Top Area',
      suffixIcon: Padding(
        padding: const EdgeInsets.only(top:12.0),
        child: Text("SQFT",style:ts18(ColorUtil.primary),textAlign: TextAlign.center,),
      ),
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//8
    widgets.add(AddNewLabelTextField(
      dataname: 'AvailShadowFreeSpace',
      hasInput: true,
      required: true,
      maxlines: 1,
      textInputType: TextInputType.number,
      labelText: 'Available Shadow Free Space',
      suffixIcon: Icon(Icons.percent_outlined,color: ColorUtil.primary,),
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//9
    widgets.add(AddNewLabelTextField(
      dataname: 'SolorPanelCAp',
      hasInput: true,
      required: true,
      maxlines: 1,
      textInputType: TextInputType.number,
      labelText: 'Solor Panel Capacity',
      suffixIcon: Padding(
        padding: const EdgeInsets.only(top:12.0),
        child: Text("KW",style:ts18(ColorUtil.primary),),
      ),
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//10
    widgets.add(AddNewLabelTextField(
      dataname: 'CustomerBudget',
      hasInput: true,
      required: true,
      maxlines: 1,
      textInputType: TextInputType.number,
      labelText: 'Customer Budget',
      suffixIcon:Icon(Icons.currency_rupee,color: ColorUtil.primary,),
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//11
    widgets.add(SearchDrp2(map:  {"dataName":"BuildingTypeID","hintText":"Building Type","labelText":"Building Type","showSearch":true,"mode":Mode.DIALOG,"dialogMargin":EdgeInsets.all(0.0)},));//12
    widgets.add(AddNewLabelTextField(
      dataname: 'AverageElectricityCost',
      hasInput: true,
      required: true,
      maxlines: 1,
      textInputType: TextInputType.number,
      labelText: 'Average Electricity Cost',
      suffixIcon:Icon(Icons.currency_rupee,color: ColorUtil.primary,),
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//13
    widgets.add(SearchDrp2(map:  {"dataName":"RequiedSystem","hintText":"Requied System","labelText":"Requied System","showSearch":true,"mode":Mode.DIALOG,"dialogMargin":EdgeInsets.all(0.0)},));//14
    widgets.add(SearchDrp2(map:  {"dataName":"RequiedModules","hintText":"Requied Modules","labelText":"Requied Modules","showSearch":true,"mode":Mode.DIALOG,"dialogMargin":EdgeInsets.all(0.0)},));//15
    widgets.add(MultiImagePicker(dataname: "UserImage", folder: "Image",hasInput: true,required: true,));//16
    widgets.add(AddNewLabelTextField(
      dataname: 'Comments',
      hasInput: true,
      required: true,
      maxlines: null,
      labelText: 'Comments',
      regExp: null,
      onChange: (v){},
      onEditComplete: (){
        node.unfocus();
      },
    ));//17
    widgets.add(HiddenController(dataname: 'NewsFeedId'));

    await parseJson(widgets, General.ViewDonorFormIdentifier,dataJson: widget.dataJson,developmentMode: DevelopmentMode.json,
    traditionalParam: TraditionalParam(getByIdSp: Sp.getByIdNewsFeedDetail),resCb: (res){
      console("res $res");
      if(res['Table1']!=null && res['Table1'].isNotEmpty){
        widgets[1].setValue(res['Table1']);
      }
        });
  }


  @override
  String getPageIdentifier(){
    return General.ViewDonorFormIdentifier;
  }

}
