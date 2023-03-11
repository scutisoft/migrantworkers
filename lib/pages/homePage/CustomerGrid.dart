
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../HappyExtension/extensionUtils.dart';
import '../../api/sp.dart';
import '../../helper/language.dart';
import '../../utils/utils.dart';
import '../../../HappyExtension/extensionHelper.dart';
import '../../../utils/colorUtil.dart';
import '../../../utils/constants.dart';
import '../../../utils/general.dart';
import '../../../utils/sizeLocal.dart';
import '../../widgets/accessWidget.dart';
import '../../widgets/animatedSearchBar.dart';
import '../../widgets/customAppBar.dart';
import '../../widgets/listView/HE_ListView.dart';
import '../../widgets/loader.dart';
import '../../widgets/navigationBarIcon.dart';
import 'CustomerViewPage.dart';
import 'customeAddFormr.dart';





class CustomerGrid extends StatefulWidget {
  VoidCallback voidCallback;
  CustomerGrid({required this.voidCallback});
  @override
  _CustomerGridState createState() => _CustomerGridState();
}

class _CustomerGridState extends State<CustomerGrid> with HappyExtensionHelper  implements HappyExtensionHelperCallback{


  List<Widget> widgets=[];
  List<dynamic> CustomerList=[];
  ScrollController silverController=ScrollController();
  TextEditingController textController = TextEditingController();
  late HE_ListViewBody he_listViewBody;
  double cardWidth=SizeConfig.screenWidth!-(20+20+25);


  RxDouble silverBodyTopMargin=RxDouble(0.0);

  @override
  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((_){

      silverBodyTopMargin.value=0.0;
      silverController.addListener(() {
        if(silverController.offset>triggerOffset){
          silverBodyTopMargin.value=toolBarHeight-(-(silverController.offset-flexibleSpaceBarHeight));
          if(silverBodyTopMargin.value<0){
            silverBodyTopMargin.value=0;
          }
        }
        else if(silverController.offset<triggerEndOffset){
          silverBodyTopMargin.value=0;
        }
      });
    });

    he_listViewBody=HE_ListViewBody(
      data: [],
      getWidget: (e){
        return HE_ViewDonorGridContent(
          data: e,
          cardWidth: cardWidth,
          onDelete: (dataJson){
          },
          onEdit: (updatedMap){
            he_listViewBody.updateArrById("NewsFeedId", updatedMap);
          },
          globalKey: GlobalKey(),
          refresh: assignWidgets,
        );
      },
    );

    assignWidgets();
    super.initState();
  }

  var node;



  @override
  Widget build(BuildContext context) {
    node=FocusScope.of(context);
    //cardWidth=SizeConfig.screenWidth!-(20+15+25);
    return SafeArea(
        bottom: MyConstants.bottomSafeArea,
        child: Scaffold(
          backgroundColor: Color(0XFFF3F3F3),
          resizeToAvoidBottomInset: true,
          body:Stack(
            children: [
              ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  Container(
                    height: 60,
                    width: SizeConfig.screenWidth,
                    color: ColorUtil.themeWhite,
                    child: Row(
                      children: [
                        NavBarIcon(
                          onTap:  (){
                            widget.voidCallback();
                          },
                        ),
                        Container(
                          child: Text('Customer Details',style: ts20(ColorUtil.themeBlack),),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Container(
                    // height: SizeConfig.screenHeight,
                    padding: const EdgeInsets.only(right: 5.0,),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(() => SizedBox(height: silverBodyTopMargin.value,)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AnimSearchBar(
                              width: SizeConfig.screenWidth!-80,
                              color: ColorUtil.asbColor,
                              boxShadow: ColorUtil.asbBoxShadow,
                              textController: textController,
                              closeSearchOnSuffixTap: ColorUtil.asbCloseSearchOnSuffixTap,
                              searchIconColor: ColorUtil.asbSearchIconColor,
                              suffixIcon: ColorUtil.getASBSuffix(),
                              onSubmitted: (a){
                              },
                              onChange: (a){
                                he_listViewBody.searchHandler(a);
                              },
                              onSuffixTap: (clear) {
                                if(clear){
                                  he_listViewBody.searchHandler("");
                                }
                              },
                            ),
                            const SizedBox(width: 5,),
                            FilterIcon(
                              // onTap: (){
                              //   fadeRoute(FilterItems());
                              // },
                            ),
                            const SizedBox(width: 5,),
                            GridAddIcon(
                              onTap: (){
                                fadeRoute(CustomerAddForm(closeCb: (e){
                                },));
                              },
                            ),
                            const SizedBox(width: 5,),
                          ],
                        ),
                        Flexible(child: he_listViewBody),
                        Obx(() => NoData(show: he_listViewBody.widgetList.isEmpty,topPadding: 20,)),
                      ],
                    ),
                  ),
                ],
              ),
              ShimmerLoader()
            ],
          ),
        )
    );
  }

  @override
  void assignWidgets() async{
    await parseJson(widgets, getPageIdentifier(),developmentMode: DevelopmentMode.json,);
  try{

      List<dynamic> CustomerList=valueArray.where((element) => element['key']=="CustomerList").toList()[0]['value'];
      he_listViewBody.assignWidget(CustomerList);

    }catch(e){}
  }

  @override
  String getPageIdentifier(){
    return General.ViewCustomerGridIdentifier;
  }
}

class HE_ViewDonorGridContent extends StatelessWidget implements HE_ListViewContentExtension{
  double cardWidth;
  Map data;
  Function(Map)? onEdit;
  Function(String)? onDelete;
  GlobalKey globalKey;
  VoidCallback refresh;
  HE_ViewDonorGridContent({Key? key,required this.data,required this.cardWidth,this.onEdit,this.onDelete,required this.globalKey,required this.refresh}) : super(key: key){
    dataListener.value=data;
   // dataListener['DataJson']={"NewsFeedId":data['NewsFeedId']};
  }
  var dataListener={}.obs;
  var separatorHeight = 50.0.obs;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(globalKey.currentContext!=null){
        separatorHeight.value=parseDouble(globalKey.currentContext!.size!.height)-30;
      }
    });
    return Obx(
            ()=> Container(
              key: globalKey,
              margin: const EdgeInsets.only(bottom: 10,left: 15,right: 10),
              padding: const EdgeInsets.only(left: 10.0,right: 10.0),
              width: cardWidth+25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorUtil.themeWhite,
              ),
              clipBehavior:Clip.antiAlias,
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: cardWidth-120,
                    alignment: Alignment.topLeft  ,
                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start ,
                      children: [
                        gridCardText(Language.name ,dataListener['CustomerName']??"",isBold: true),
                        gridCardText(Language.phoneNo, dataListener['ContactNo'],),
                        gridCardText(Language.address, dataListener['Address'],),
                        gridCardText('Consulted Engineer', dataListener['ConsultedEngineer'],),
                       //  Row(
                       //    crossAxisAlignment: CrossAxisAlignment.start,
                       //    children: [
                       //      Text('${Language.status}  : ',style: TextStyle(color: ColorUtil.text4,fontSize: 14,fontFamily: 'RR'),),
                       //      //  Spacer(),
                       //      Flexible(child: Text("${dataListener['PaymentStatus']}",
                       //        style: TextStyle(color: getPaymentStsClr( dataListener['PaymentStatus']),fontSize: 14,fontFamily: 'RM'),)),
                       //    ],
                       //  ),
                      ],
                    ),
                  ),
                  Container(
                    width: 15,
                    alignment:Alignment.topRight,
                    child: Column(
                      children: [
                        Container(
                          width: 15,
                          height:10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft:Radius.circular(50) ),
                            color: Color(0xFFF2F3F7),
                          ),
                        ),
                        Obx(() => Container(width: 1,height:separatorHeight.value,color: const Color(0xFFF2F3F7),)),
                        Container(
                          width: 15,
                          height:10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft:Radius.circular(50) ),
                            color: Color(0xFFF2F3F7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 120,
                    padding: const EdgeInsets.only(top: 10,bottom: 10),
                    // color:Colors.red,
                    child:  Column(
                      crossAxisAlignment:CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Visited On',style: TextStyle(color: ColorUtil.themeBlack,fontSize: 14,fontFamily: Language.regularFF),),
                        const SizedBox(height: 3,),
                        Text("${dataListener['VisitedOn']}",style: ColorUtil.textStyle18),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            EyeIcon(
                              onTap: (){
                                fadeRoute(CustomerView());
                                // fadeRoute(ViewCSRGrid(dataJson: getDataJsonForGrid(dataListener['DataJson']),));
                              },
                            ),
                            // const SizedBox(width: 10,),
                            GridEditIcon(
                              hasAccess: true,
                              margin: actionIconMargin,
                              onTap: (){

                                // fadeRoute(CSRForm(dataJson: getDataJsonForGrid(dataListener['DataJson']),isEdit: true,closeCb: (e){
                                //   updateDataListener(e['Table'][0]);
                                //   if(onEdit!=null){
                                //     onEdit!(e['Table'][0]);
                                //   }
                                // },));
                              },
                            ),
                            //  const SizedBox(width: 10,),
                            GridDeleteIcon(
                              hasAccess: true,
                              margin: actionIconMargin,
                              onTap: (){
                                if(onDelete!=null){
                                  onDelete!(getDataJsonForGrid(dataListener['DataJson']));
                                }
                              },
                            ),

                          ],
                        ),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ],
              ),
            )
    );
  }

  @override
  updateDataListener(Map data) {
    data.forEach((key, value) {
      if(dataListener.containsKey(key)){
        dataListener[key]=value;
      }
    });
  }
}