import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api/apiUtils.dart';
import '../../helper/language.dart';
import '../../widgets/accessWidget.dart';
import '../../utils/utils.dart';
import '../../widgets/customCheckBox.dart';

import '../../../HappyExtension/extensionHelper.dart';
import '../../../HappyExtension/utilWidgets.dart';
import '../../../utils/colorUtil.dart';
import '../../../utils/constants.dart';
import '../../../utils/general.dart';
import '../../../utils/sizeLocal.dart';
import '../../../widgets/customWidgetsForDynamicParser/searchDrp2.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/fittedText.dart';
import '../../widgets/loader.dart';


class CustomerView extends StatefulWidget {
  String? dataJson;
  Function? closeCb;
  CustomerView({this.closeCb,this.dataJson=""});
  @override
  _CustomerViewState createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> with HappyExtensionHelper  implements HappyExtensionHelperCallback {

  List<dynamic> imgList = [];
  List<Widget> widgets = [];
  ScrollController? silverController;
  int _current = 0;
  final CarouselController _controller = CarouselController();

  List<dynamic> LandParcelView = [];

  var isNeedApproval=false.obs;

  @override
  void initState() {
    silverController = ScrollController();
    assignWidgets();
    super.initState();
  }

  var node;
  var isNewsFeed=false.obs;

  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);
    return SafeArea(
        bottom: MyConstants.bottomSafeArea,
        child: Scaffold(
          backgroundColor: Color(0XFFF3F3F3),
          resizeToAvoidBottomInset: true,
          body: Stack(
            children: [
              NestedScrollView(
                headerSliverBuilder: (BuildContext context,
                    bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      backgroundColor: Color(0XFFF3F3F3),
                      expandedHeight: 160.0,
                      floating: true,
                      snap: true,
                      pinned: false,
                      leading: ArrowBack(
                        iconColor: ColorUtil.themeBlack,
                        onTap: () {
                          Get.back();
                        },
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        //expandedTitleScale: 1.8,
                        background: Container(
                          height: 160,
                          width: SizeConfig.screenWidth,
                          color: Colors.white,
                          child: Stack(
                            children: [
                              CarouselSlider(
                                options: CarouselOptions(
                                    height: 160,
                                    viewportFraction: 1.0,
                                    enlargeCenterPage: false,
                                    scrollDirection: Axis.horizontal,
                                    reverse: false,
                                    autoPlay: true,
                                    enableInfiniteScroll: false,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _current = index;
                                      });
                                    }
                                ),
                                carouselController: _controller,
                                items: imgList
                                    .map((item) => Image.network(
                                  GetImageBaseUrl()+item["ImagePath"], fit: BoxFit.contain,
                                  width: SizeConfig.screenWidth,
                                )
                                )
                                    .toList(),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: imgList
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    return GestureDetector(
                                      onTap: () =>
                                          _controller.animateToPage(entry.key),
                                      child: Container(
                                        width: 12.0,
                                        height: 12.0,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 4.0),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: (Theme
                                                .of(context)
                                                .brightness == Brightness.dark
                                                ? Colors.white
                                                : ColorUtil.primary)
                                                .withOpacity(
                                                _current == entry.key ? 0.9 : 0.4)),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body: Stack(
                  children: [
                    ListView(
                      shrinkWrap: true,
                      children: [
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            widgets[0],
                            // Image.asset('assets/Slice/status-tick.png',width: 30,)
                          ],
                        ),
                        const SizedBox(height: 2,),
                        widgets[1],
                        const  SizedBox(height: 5,),
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Table(
                            // defaultColumnWidth: FixedColumnWidth(160.0),
                            border: TableBorder.all(
                                color: ColorUtil.greyBorder, style: BorderStyle.solid, width: 1),
                            children: [
                              for(int i=0;i<LandParcelView.length;i++)
                                tableView(LandParcelView[i]['Title'],"${LandParcelView[i]['Value']}",ColorUtil.greyBorder,ColorUtil.themeBlack),

                            ],
                          ),
                        ),
                        AccessWidget(
                          hasAccess: isHasAccess(accessId['LandParcelApproval']) && isNeedApproval.value,
                          needToHide: true,
                          onTap: (){
                            isNewsFeed.value=!isNewsFeed.value;
                          },
                          widget: Obx(() => Container(
                            margin: const EdgeInsets.only(left: 10, right: 10,top: 10),
                            padding: const EdgeInsets.only(left: 10, right: 10,top: 10,bottom: 10),
                            decoration: BoxDecoration(
                                color: isNewsFeed.value? ColorUtil.primary:ColorUtil.text4,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomCheckBox(
                                  isSelect: isNewsFeed.value,
                                  selectColor: ColorUtil.primary,
                                  onlyCheckbox: true,
                                ),
                                const SizedBox(width: 5,),
                                FittedText(
                                  alignment: Alignment.centerLeft,
                                  text: Language.newsFeedChkBox,
                                  textStyle: ts14(isNewsFeed.value?ColorUtil.themeWhite:ColorUtil.themeBlack,),
                                ),
                              ],
                            ),

                          )),
                        ),
                        const SizedBox(height: 100,),

                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      child: AccessWidget(
                        hasAccess: isHasAccess(accessId['LandParcelApproval']) && isNeedApproval.value,
                        needToHide: true,
                        widget: Container(
                          height: 70,
                          width: SizeConfig.screenWidth,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap:(){
                                  approveRejHandler(false);
                                },
                                child: Container(
                                  width: SizeConfig.screenWidth!*0.4,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    border: Border.all(color: ColorUtil.red),
                                    color: ColorUtil.red.withOpacity(0.3),
                                  ),
                                  child:Center(child: Text(Language.reject,style: ts16(ColorUtil.red,), )) ,
                                ),
                              ),
                              GestureDetector(
                                onTap:(){
                                  approveRejHandler(true);
                                },
                                child: Container(
                                  width: SizeConfig.screenWidth!*0.4,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: ColorUtil.primary,
                                  ),
                                  child:Center(child: Text(Language.accept,style: ts16(ColorUtil.themeWhite,), )) ,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ShimmerLoader()
                  ],
                ),
              ),

            ],
          )
        )
    );

  }
  TableRow tableView(String tabelHead,String tablevalue,Color textcolor1,Color textcolor2 ){
    return TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(tabelHead,style: TextStyle(fontSize: 15,fontFamily: 'RR',color: textcolor1),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(tablevalue,style: TextStyle(fontSize: 15,fontFamily: 'RM',color: textcolor2),),
          ),
        ]
    );
  }
  @override
  void assignWidgets() async {

    widgets.add(HE_Text(dataname: "PageTitle",  contentTextStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: ColorUtil.themeBlack,fontFamily:'RB'),),);
    widgets.add(HE_Text(dataname: "LandDistrictVillage", contentTextStyle: TextStyle(fontSize: 13,color: ColorUtil.themeBlack,fontFamily:'RR'),textAlign: TextAlign.center,),);

    widgets.add(HiddenController(dataname: "LandParcelId"));
    widgets.add(HiddenController(dataname: "IsNewsFeed"));
    widgets.add(HiddenController(dataname: "IsAccept"));
    await parseJson(widgets, General.addLandParcelViewIdentifier,dataJson: widget.dataJson);
    try{

      LandParcelView=valueArray.where((element) => element['key']=="LandParcelView").toList()[0]['value'];
      isNewsFeed.value=valueArray.where((element) => element['key']=="IsNewsFeed").toList()[0]['value'];
      imgList=valueArray.where((element) => element['key']=="LandImagesList").toList()[0]['value'];
      var x=valueArray.where((element) => element['key']=="IsNeedApproval").toList();
      isNeedApproval.value=x.isNotEmpty?x[0]['value']:MyConstants.defaultActionEnable;
      setState((){});

    }catch(e,t){
      assignWidgetErrorToast(e, t);
    }
  }


  void approveRejHandler(isAccept){
    sysSubmit(widgets,isEdit: true,
        needCustomValidation: true,
        onCustomValidation: (){
          foundWidgetByKey(widgets,"IsNewsFeed",needSetValue: true,value: isNewsFeed.value);
          foundWidgetByKey(widgets,"IsAccept",needSetValue: true,value: isAccept);
          return true;
        },
        successCallback: (e){
          if(widget.closeCb!=null){
            widget.closeCb!(e);
          }
        }
    );
  }

  @override
  String getPageIdentifier(){
    return General.addLandParcelViewIdentifier;
  }

}
