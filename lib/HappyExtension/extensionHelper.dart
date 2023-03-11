import '../api/ApiManager.dart';
import '../api/apiUtils.dart';
import '../notifier/getUiNotifier.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';
import '../widgets/alertDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:convert';
import '../model/parameterMode.dart';
import '../widgets/listView/HE_ListView.dart';
import 'extensionUtils.dart';
bool needLog=false;
enum WidgetType{
  list,
  map
}

enum DevelopmentMode{
  json,
  traditional
}

class TraditionalParam{
  List<ParameterModel> paramList;
  String insertSp;
  String updateSp;
  String getByIdSp;
  String? executableSp;
  TraditionalParam({this.paramList=const [],this.getByIdSp="",this.insertSp="",this.updateSp="",this.executableSp});
}

abstract class ExtensionCallback {
  String getType();
  getValue();
  setValue(var value);
  bool validate();
  String getDataName();
  void clearValues();
  int getOrderBy();
  setOrderBy(int oBy);
}

mixin HappyExtensionHelper implements HappyExtensionHelperCallback2{
  Future<List<ParameterModel>> getFrmCollection(var widgets) async{

    List<bool> validateList=[];
    List<ParameterModel> parameterList=[];
    bool validate=false;

    Future widgetValidation(var widget) async{
      String elementType="";
      try{
        elementType=widget.getType();
      }catch(e){}

      if(elementType=='inputTextField' || elementType=='HE_Text'){
        if(widget.hasInput??false){
          if(widget.required??false){
            validate=widget.validate();
            validateList.add(validate);
            if(validate){
              parameterList.add(ParameterModel(Key: widget.getDataName(), Type: 'string', Value: widget.getValue(), orderBy: widget.getOrderBy()));
            }
          }
          else{
            parameterList.add(ParameterModel(Key: widget.getDataName(), Type: 'string', Value: widget.getValue(), orderBy: widget.getOrderBy()));
          }
        }
      }
      if(elementType=='searchDrp' || elementType=='searchDrp2'){
        if(widget.hasInput??false){
          if(widget.required??false){
            validate=widget.validate();
            validateList.add(validate);
            if(validate){
              parameterList.add(ParameterModel(Key: widget.getDataName(), Type: 'string', Value: widget.getValue(), orderBy: widget.getOrderBy()));
            }
          }
          else{
            parameterList.add(ParameterModel(Key: widget.getDataName(), Type: 'string', Value: widget.getValue(), orderBy: widget.getOrderBy()));
          }
        }
      }
      if(elementType=='hidden'){
        if(widget.hasInput??false){
          parameterList.add(ParameterModel(Key: widget.getDataName(), Type: 'string', Value: widget.getValue(), orderBy: widget.getOrderBy()));
        }
      }
      if(elementType=='locationPicker'){
        if(widget.hasInput??false){
          if(widget.required??false){
            validate=widget.validate();
            validateList.add(validate);
            if(validate){
              parameterList.add(ParameterModel(Key: widget.getDataName(), Type: 'string', Value: widget.getValue(), orderBy: widget.getOrderBy()));
            }
          }
          else{
            parameterList.add(ParameterModel(Key: widget.getDataName(), Type: 'string', Value: widget.getValue(), orderBy: widget.getOrderBy()));
          }
        }
      }
      if(elementType=='multiImage' || elementType=='singleImagePicker'){
        if(widget.hasInput??false){
          if(widget.required??false){
            validate=widget.validate();
            validateList.add(validate);
            if(validate){
              parameterList.add(ParameterModel(Key: widget.getDataName(), Type: 'string', Value: await widget.getValue(), orderBy: widget.getOrderBy()));
            }
          }
          else{
            parameterList.add(ParameterModel(Key: widget.getDataName(), Type: 'string', Value: await widget.getValue(), orderBy: widget.getOrderBy()));
          }
        }
      }
    }

    WidgetType widgetType=getWidgetType(widgets);
    if(widgetType==WidgetType.list){
      for (var widget in widgets){
         await widgetValidation(widget);
      }
    }
    else if(widgetType==WidgetType.map){
      for (var widget in widgets.entries){
        await widgetValidation(widget.value);
      }
    }


    bool isValid=!validateList.any((element) => element==false);
    console("valid ${isValid}");
    return isValid?parameterList:[];
  }

  //Not in use ,WidgetType widgetType=WidgetType.list,Map<String,dynamic> widgetMap=const {}
  setFrmValuesV2(var widgets,List response){
    void widgetValueUpdate(value,widget){
      String widgetType="";
      try{
        widgetType=widget.getType();
        if(widgetType.isNotEmpty){
          widget.setValue(value);
          //widget.setOrderBy(value['orderBy']??1);
        }
      }catch(e){
        // CustomAlert().cupertinoAlert("${widget.getDataName()} Error HE001 \n $e");
      }
    }
    if (response!=null && response.isNotEmpty) {
      for(int i=0;i<response.length;i++){
        response[i].forEach((key,value){

          var widget=null;
          WidgetType widgetType=getWidgetType(widgets);
          if(widgetType==WidgetType.list){
            var foundWid=widgets.where((x) => x.getDataName()==key).toList();
            if(foundWid.length==1){
              widget=foundWid[0];
            }
          }
          else if(widgetType==WidgetType.map){
            widget=widgets[key.toString()];
          }
          if(widget!=null){
            widgetValueUpdate(value, widget);
          }
        });
      }
    }
  }

  setFrmValues(var widgets,List valueArray,{bool fromClearAll=false}){
    void widgetValueUpdate(value,widget){
      String widgetType="";
      try{
        widgetType=widget.getType();
        if(widgetType.isNotEmpty){
          if(fromClearAll){
            widget.clearValues();
          }
          widget.setValue(value['value']);
          widget.setOrderBy(value['orderBy']??1);
        }
      }catch(e){
        // CustomAlert().cupertinoAlert("${widget.getDataName()} Error HE001 \n $e");
      }
    }

    if (valueArray!=null && valueArray.isNotEmpty) {
      for (var value in valueArray) {
        var widget=null;
        WidgetType widgetType=getWidgetType(widgets);
        if(widgetType==WidgetType.list){
          var foundWid=widgets.where((x) => x.getDataName()==value['key']).toList();
          if(foundWid.length==1){
            widget=foundWid[0];
          }
        }
        else if(widgetType==WidgetType.map){
          widget=widgets[value['key'].toString()];
        }
        if(widget!=null){
          widgetValueUpdate(value, widget);
        }
      }
    }


  }

  var parsedJson;
  List<dynamic> valueArray=[];



  parseJson(var widgets,String pageIdentifier,{String? dataJson,bool needToSetValue=true,
    DevelopmentMode developmentMode= MyConstants.developmentMode,TraditionalParam? traditionalParam,Function(dynamic)? resCb}) async{

    if(developmentMode==DevelopmentMode.json){
      if(MyConstants.fromUrl){
        await getUIFromDb(widgets,pageIdentifier, dataJson);
      }
      else{
        String data = await DefaultAssetBundle.of(Get.context!).loadString(pageIdentifier);
        parsedJson=jsonDecode(data);
        if(parsedJson.containsKey('valueArray')){
          valueArray=parsedJson['valueArray'];
        }
        if(valueArray.isNotEmpty){
          setFrmValues(widgets, valueArray);
        }
        //print(valueArray);
      }
    }
    else if(developmentMode==DevelopmentMode.traditional){
      bool isGetById=(dataJson!=null && dataJson!='');

      //console("(traditionalParam.executableSp!=null || isGetById) ${(traditionalParam!.executableSp!=null || isGetById)}");
      if(traditionalParam != null && (traditionalParam.executableSp!=null || isGetById)){
      //  console("isGetById ${isGetById}");
        List<ParameterModel> finalParams=traditionalParam.paramList.isNotEmpty?traditionalParam.paramList:[];
        finalParams.add(ParameterModel(Key: "SpName", Type: "String", Value:isGetById?traditionalParam.getByIdSp: traditionalParam.executableSp));
        if(isGetById){
          var parsedDataJson=jsonDecode(dataJson);
          if(HE_IsMap(parsedDataJson)){
            parsedDataJson.forEach((key, value) {
              finalParams.add(ParameterModel(Key: key, Type: "String", Value: value));
            });
          }
        }
        finalParams.addAll(await getParameterEssential());

        await ApiManager().GetInvoke(finalParams,isNeedErrorAlert: false).then((value){
          if(value[0]){
            var parsed=jsonDecode(value[1]);
            if(parsed['Table']!=null){
              if(isGetById && needToSetValue){
                setFrmValuesV2(widgets, parsed['Table']);
              }
            }
            if(resCb!=null){
              resCb(parsed);
            }
            else{
              valueArray=parsed['Table'];
            }

          }
          else{
            CustomAlert().cupertinoAlert(value[1]);
          }
        });
      }
      /*else{
        assignWidgetErrorToast("Params Not Found...", "");
      }*/
    }

  }

  Future<void> getUIFromDb(var widgets,String pageIdentifier,String? dataJson) async{
    await GetUiNotifier().getUiJson(pageIdentifier,await getLoginId(),true,dataJson: dataJson).then((value){
      print("----getUIFromDb-----");
      if(needLog)console(value);
      if(value!="null" && value.toString().isNotEmpty){
        var parsed=jsonDecode(value);
        parsedJson=jsonDecode(parsed['Table'][0]['PageJson']);
        if(parsedJson.containsKey('valueArray')){
          valueArray=parsedJson['valueArray'];
        }

        if(valueArray.isNotEmpty){
          setFrmValues(widgets, valueArray);
        }
      }
    });
  }

  Future<void> postUIJson(String pageIdentifier,String dataJson,String action,{Function? successCallback,
    DevelopmentMode developmentMode= MyConstants.developmentMode,TraditionalParam? traditionalParam}) async{
    //"N'$dataJson'"
    if(developmentMode==DevelopmentMode.json){
      console("Post ui $dataJson");
      //"N'$dataJson'"
      await GetUiNotifier().postUiJson(await getLoginId(), pageIdentifier, "N'$dataJson'", {"actionType":action}).then((value){
        //print("----- post    $value");
        if(value[0]){
          // console(value);
          var parsed=jsonDecode(value[1]);
          String errorMsg=parsed["TblOutPut"][0]["@Message"]??"";
          if(successCallback!=null){
            successCallback(parsed);
          }
          else{
            addNotifications(NotificationType.success,msg: errorMsg);
            //CustomAlert().successAlert(errorMsg, "");
          }
        }
        else{
          CustomAlert().cupertinoAlert(value[1]);
        }
      });
    }
    else if(developmentMode==DevelopmentMode.traditional){
      if(traditionalParam != null && traditionalParam.executableSp!=null){
        List<ParameterModel> finalParams=traditionalParam.paramList.isNotEmpty?traditionalParam.paramList:[];
        finalParams.add(ParameterModel(Key: "SpName", Type: "String", Value: traditionalParam.executableSp));
        finalParams.addAll(await getParameterEssential());
        if(dataJson.isNotEmpty){
          var parsedDataJson=jsonDecode(dataJson);
          if(HE_IsMap(parsedDataJson)){
            parsedDataJson.forEach((key, value) {
              finalParams.add(ParameterModel(Key: key, Type: "String", Value: value));
            });
          }
        }

        await ApiManager().GetInvoke(finalParams,isNeedErrorAlert: false).then((value){
          if(value[0]){
            // console(value);
            var parsed=jsonDecode(value[1]);
            String errorMsg=parsed["TblOutPut"][0]["@Message"]??"";
            if(successCallback!=null){
              successCallback(parsed);
            }
            else{
              addNotifications(NotificationType.success,msg: errorMsg);
              //CustomAlert().successAlert(errorMsg, "");
            }
          }
          else{
            CustomAlert().cupertinoAlert(value[1]);
          }
        });
      }
      else{
        assignWidgetErrorToast("Params Not Found...", "");
      }
    }
  }

  void sysSubmit(List<dynamic> widgets,{
    Function? successCallback,
    String action="",
    bool isEdit=false,
    bool needCustomValidation=false,
    Function? onCustomValidation,
    bool clearFrm=true,
    bool closeFrmOnSubmit=true,
    DevelopmentMode developmentMode= MyConstants.developmentMode,
    TraditionalParam? traditionalParam,
    bool needSuccessCb=false
  }) async{

    void successCbHandler(e){
      String errorMsg=e["TblOutPut"][0]["@Message"]??"";
      if(closeFrmOnSubmit){
        Get.back();
      }
      addNotifications(NotificationType.success,msg: errorMsg);
      //CustomAlert().successAlert(errorMsg, "");
      if(clearFrm){
        clearAll(widgets);
      }
      if(successCallback!=null && e['Table']!=null && e['Table'].length>0){
        successCallback(e);
      }
      else if(needSuccessCb){
        successCallback!(e);
      }
    }

    bool isValid=true;
    if(needCustomValidation){
      isValid=onCustomValidation!();
    }
    List<ParameterModel> params= await getFrmCollection(widgets);
    if(params.isNotEmpty && isValid){
      if(isValid){
        try{
          params.sort((a,b)=>a.orderBy.compareTo(b.orderBy));
        }catch(e){
          CustomAlert().cupertinoAlert("Error HE002 $e");
        }

        if(developmentMode==DevelopmentMode.json){
          postUIJson(getPageIdentifier(),
              jsonEncode(params.map((e) => e.toJsonHE()).toList()),
              action.isNotEmpty?action: isEdit?"Update":"Insert",
              successCallback: successCbHandler,
              developmentMode: developmentMode
          );
        }
        else if(developmentMode==DevelopmentMode.traditional){
          if(traditionalParam==null){
            assignWidgetErrorToast("Traditional Params not found...", "");
            return;
          }
          traditionalParam.executableSp=isEdit?traditionalParam.updateSp:traditionalParam.insertSp;
          traditionalParam.paramList=params;
          postUIJson(getPageIdentifier(), "", "", successCallback: successCbHandler,
              developmentMode: developmentMode, traditionalParam: traditionalParam
          );
        }
      }
    }

  }

  void sysDelete(arr,primaryKey,primaryArr,{Function? successCallback,String dataJson="",String content="Are you sure want to delete ?",}){
    CustomAlert(
        callback: (){
          postUIJson(getPageIdentifier(),
              dataJson,
              "Delete",
              successCallback: (e){
                String errorMsg=e["TblOutPut"][0]["@Message"];
                addNotifications(NotificationType.success,msg: errorMsg);
                //CustomAlert().successAlert(errorMsg, "");
                if(successCallback!=null){
                  successCallback(e);
                }
                //updateArrById(primaryKey, e["Table"][0], arr,action: ActionType.deleteById,primaryArr:primaryArr );
              }
          );
        },
        cancelCallback: (){

        }
    ).yesOrNoDialog2('assets/Slice/like.png', content, false);
  }

  void sysDeleteHE_ListView(HE_ListViewBody he_listViewBody,String primaryKey,{Function? successCallback,String dataJson="",
    String content="Are you sure want to delete ?",DevelopmentMode developmentMode=MyConstants.developmentMode,TraditionalParam? traditionalParam}){
    CustomAlert(
        callback: (){
          postUIJson(getPageIdentifier(),
              dataJson,
              "Delete",
              successCallback: (e){
                String errorMsg=e["TblOutPut"][0]["@Message"];
                addNotifications(NotificationType.success,msg: errorMsg);
                //CustomAlert().successAlert(errorMsg, "");
                if(successCallback!=null){
                  successCallback(e);
                }
                he_listViewBody.updateArrById(primaryKey, e["Table"][0],action: ActionType.deleteById);
                //updateArrById(primaryKey, e["Table"][0], arr,action: ActionType.deleteById,primaryArr:primaryArr );
              },
              developmentMode: developmentMode,
              traditionalParam:  traditionalParam
          );
        },
        cancelCallback: (){

        }
    ).yesOrNoDialog2('assets/Slice/like.png', content, false);
  }

  fillTreeDrp(var widgets,String key,{var refId,var page,bool clearValues=true,var refType,bool toggleRequired=false}) async{
    var fWid=foundWidgetByKey(widgets, key);
    if(fWid!=null){
      if(clearValues){
        fWid.clearValues();
      }
      getMasterDrp(page, key, refId, refType,null).then((value){
        //console("$key    ${value.runtimeType}");
        fWid.setValue(value);
        if(toggleRequired){
          fWid.required=value.isNotEmpty;
          try{
            fWid.isValid.value=true;
          }catch(e){assignWidgetErrorToast("IsValid",e);}
        }
      });
    }
  }

  foundWidgetByKey(var widgets,String key,{bool needSetValue=false,dynamic value}){
    WidgetType widgetType=getWidgetType(widgets);
    if(widgetType==WidgetType.list){
      for (var widget in widgets) {
        if(widget.getDataName()==key){
          if(needSetValue){
            widget.setValue(value);
          }
          return widget;
        }
      }
    }
    else if(widgetType==WidgetType.map){
      var foundWidg=widgets[key];
      if(needSetValue && foundWidg!=null){
        foundWidg.setValue(value);
      }
      return foundWidg;
    }
    return null;
  }

  void clearAll(var widgets){
    setFrmValues(widgets, valueArray,fromClearAll: true);
  }

  void updateEnable(var widgets,key,{bool isEnabled=false}){
    var fWid=foundWidgetByKey(widgets, key);
    if(fWid!=null){
      fWid.isEnabled=isEnabled;
      fWid.reload.value=!fWid.reload.value;
      if(!isEnabled){
        fWid.clearValues();
      }
    }
  }

  @override
  String getPageIdentifier(){
    return "";
  }
}

abstract class HappyExtensionHelperCallback{
  void assignWidgets() async{}
}

abstract class HappyExtensionHelperCallback2{
  String getPageIdentifier();
}

/*v-1.0.2*/
