import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/utils/colorUtil.dart';
import '/utils/utils.dart';

import '../../HappyExtension/extensionHelper.dart';
import '../../HappyExtension/extensionUtils.dart';
import '../../helper/language.dart';
import '../../utils/sizeLocal.dart';
import '../searchDropdown/dropdown_search.dart';
import '../searchDropdown/search2.dart';
import '../validationErrorText.dart';

class SearchDrp2 extends StatelessWidget  implements ExtensionCallback{
  Map map;
  bool hasInput;
  bool required;
  Function(dynamic)? onchange;
  List<dynamic>? dataList;
  SearchDrp2({super.key, required this.map,this.hasInput=true,this.required=true,this.onchange,this.dataList}){
    search2 = Search2(
      dataName: map['dataName'],
      width: SizeConfig.screenWidth,
      dialogWidth: SizeConfig.screenWidth!,
      selectWidgetHeight: 50,
      hinttext: map['hintText'],
      data: dataList??[],
      showSearch: map['showSearch']??false,
      onitemTap: (i){},
      selectedValueFunc: (e){
        if(onchange!=null){
          onchange!(e);
        }
      },
      scrollTap: (){},
      isToJson: true,
      margin: map['margin']?? ColorUtil.formMargin,
      dialogMargin: map['dialogMargin']?? const EdgeInsets.only(left: 15,right: 15,top: 0),
      selectWidgetBoxDecoration: BoxDecoration(
          border: Border.all(color: const Color(0xffEBEBEB)),
        color: Colors.white
      ),
      mode: map['mode']??Mode.MENU,
      maxHeight: 500,
      labelText: map['labelText']??"Select",
    );
  }

  late Search2 search2;
  var isValid=true.obs;
  var orderBy=1.obs;
  var errorText="* ${Language.required}".obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        search2,
        Obx(() => Visibility(visible:!isValid.value,child: ValidationErrorText()))
      ],
    );
  }

  @override
  getType() {
    return 'searchDrp2';
  }

  @override
  getValue() {
    return search2.getValue();
  }

  getValueMap() {
    return search2.getValueMap();
  }

  @override
  validate() {
    isValid.value=search2.validate();
    return isValid.value;
  }

  @override
  void clearValues() {
    search2.clearValues();
  }

  @override
  String getDataName() {
    return search2.getDataName();
  }

  @override
  setValue(value) {
    if(HE_IsMap(value)){
      if(value.containsKey("DropDownOptionList")){
        search2.setDataArray(value['DropDownOptionList']);
      }
      if(value.containsKey("SelectedId") && value['SelectedId']!="" && value['SelectedId']!=null){
        search2.setValues({map['propertyId']??"Id":value['SelectedId']});
      }
    }
    else if(HE_IsList(value)){
      search2.setDataArray(value);
    }
    else if(HE_IsInt(value)){
      search2.setValues({map['propertyId']??"Id":value});
    }
  }

  @override
  int getOrderBy() {
    return orderBy.value;
  }

  @override
  setOrderBy(int oBy) {
    orderBy.value=oBy;
  }
}

class SearchDrpMulti2 extends StatelessWidget  implements ExtensionCallback{
  Map map;
  bool hasInput;
  bool required;
  Function(dynamic)? onchange;
  List<dynamic>? dataList;
  SearchDrpMulti2({super.key, required this.map,this.hasInput=true,this.required=true,this.onchange,this.dataList}){
    search2 = Search2MultiSelect(
      dataName: map['dataName'],
      width: SizeConfig.screenWidth,
     /* dialogWidth: SizeConfig.screenWidth!,
      selectWidgetHeight: 50,*/
      hinttext: map['hintText'],
      data: dataList??[],
      showSearch: map['showSearch']??false,
      onitemTap: (i){
      },
      selectedValueFunc: (e){
        if(onchange!=null){
          onchange!(e);
        }
      },
      scrollTap: (){},
      isToJson: true,
      margin: const EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 0),
      dialogMargin: map['dialogMargin']?? const EdgeInsets.only(left: 15,right: 15,top: 0),
      selectWidgetBoxDecoration: BoxDecoration(
          border: Border.all(color: const Color(0xffEBEBEB)),
        color: Colors.white
      ),
      mode: map['mode']??Mode.MENU,
      maxHeight: 500,
     // labelText: map['labelText']??"Select",
      doneCallback: (String ) {
        console("doneCallback $String");
      },
    );
  }

  late Search2MultiSelect search2;
  var isValid=true.obs;
  var orderBy=1.obs;
  var errorText="* ${Language.required}".obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        search2,
        Obx(() => Visibility(visible:!isValid.value,child: ValidationErrorText()))
      ],
    );
  }

  @override
  getType() {
    return 'searchDrp2';
  }

  @override
  getValue() {
    return search2.getValue();
  }

/*  getValueMap() {
    return search2.getValueMap();
  }*/

  @override
  validate() {
    isValid.value=search2.validate();
    return isValid.value;
  }

  @override
  void clearValues() {
    search2.clearValues();
  }

  @override
  String getDataName() {
    return search2.getDataName();
  }

  @override
  setValue(value) {
    if(HE_IsMap(value)){
      if(value.containsKey("DropDownOptionList")){
        search2.setDataArray(value['DropDownOptionList']);
      }
      if(value.containsKey("SelectedId") && value['SelectedId']!="" && value['SelectedId']!=null){
        //search2.setValues({map['propertyId']??"Id":value['SelectedId']});
      }
    }
    else if(HE_IsList(value)){
      search2.setDataArray(value);
    }
  }

  @override
  int getOrderBy() {
    return orderBy.value;
  }

  @override
  setOrderBy(int oBy) {
    orderBy.value=oBy;
  }
}
