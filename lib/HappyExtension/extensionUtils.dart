import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import '../api/ApiManager.dart';
import '../api/apiUtils.dart';
import '../api/sp.dart';
import '../model/parameterMode.dart';
import 'extensionHelper.dart';

Future<List> getMasterDrp(String page,String typeName, dynamic refId,dynamic refTypeName,  dynamic hiraricalId) async {

  List<ParameterModel> parameters= await getParameterEssential();
  parameters.add(ParameterModel(Key: "SpName", Type: "String", Value: "${Sp.MasterdropDown}"));
  parameters.add(ParameterModel(Key: "TypeName", Type: "String", Value: typeName));
  parameters.add(ParameterModel(Key: "Page", Type: "String", Value: page));
  parameters.add(ParameterModel(Key: "RefId", Type: "String", Value: refId));
  parameters.add(ParameterModel(Key: "RefTypeName", Type: "String", Value: refTypeName??typeName));
  parameters.add(ParameterModel(Key: "HiraricalId", Type: "String", Value: hiraricalId));

  //console(jsonEncode(parameters));
  var result=[];
  try{
    await ApiManager().GetInvoke(parameters).then((value) {
      // print(value);
      if(value[0]){
        var parsed=jsonDecode(value[1]);
        //print(parsed);
        var table=parsed['Table'] as List;
        if(table.isNotEmpty){
          result=table;
        }
      }
    });
    return result;
  }
  catch(e){
    return result;
    //CustomAlert().commonErrorAlert(Get.context!, "Error G01", "Contact Administration");
  }
}
Future<Map> getMasterDrpMap(String page,String typeName, dynamic refId,  dynamic hiraricalId) async {

  List<ParameterModel> parameters= await getParameterEssential();
  parameters.add(ParameterModel(Key: "SpName", Type: "String", Value: "${Sp.MasterdropDown}"));
  parameters.add(ParameterModel(Key: "TypeName", Type: "String", Value: typeName));
  parameters.add(ParameterModel(Key: "Page", Type: "String", Value: page));
  parameters.add(ParameterModel(Key: "RefId", Type: "String", Value: refId));
  parameters.add(ParameterModel(Key: "RefTypeName", Type: "String", Value: typeName));
  parameters.add(ParameterModel(Key: "HiraricalId", Type: "String", Value: hiraricalId));

  var body={
    "Fields": parameters.map((e) => e.toJson()).toList()
  };
 // print(body);
  var result={};
  try{
    await ApiManager().GetInvoke(parameters,).then((value) {
      // print(value);
      if(value[0]){
        var parsed=jsonDecode(value[0]);
        result=parsed;
        // var table=parsed['Table'] as List;
        // if(table.isNotEmpty){
        //   result=table;
        // }
      }
    });
    return result;
  }
  catch(e){
    return result;
    //CustomAlert().commonErrorAlert(Get.context!, "Error G01", "Contact Administration");
  }
}

bool HE_IsMap(value){
  return value.runtimeType.toString()=="_InternalLinkedHashMap<String, dynamic>" ||
      value.runtimeType.toString()=="_Map<String, dynamic>" ||
      value.runtimeType.toString() =="_InternalLinkedHashMap<dynamic, dynamic>" ||
      value.runtimeType.toString() =="_Map<String, Object?>" ;
}
bool HE_IsList(value){
  return value.runtimeType.toString()=="List<dynamic>" || value.runtimeType.toString()=="List<Widget>";
}
bool HE_IsInt(value){
  return value.runtimeType.toString()=="int";
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  /*if (!serviceEnabled) {
      return Future.error('Location services are disabled ${serviceEnabled}.');
    }*/
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition();
}

List searchGrid(v,primaryArr,secondaryArr){
  if(v.toString().isEmpty){
    secondaryArr=primaryArr;
  }
  else{
    String sv=v.toString().toLowerCase();
    secondaryArr=primaryArr.where((element) => getValuesFromMap(element).contains(sv)).toList();
  }
  return secondaryArr;
}

String getValuesFromMap(map){
  var valArr= [];
  map.forEach((key, value) {
    valArr.add(value);
  });
  return jsonEncode(valArr).toLowerCase();
}

enum ActionType{
  add,
  update,
  deleteById,
  deleteAll
}


void updateArrById(primaryKey,updatedValueMap,arr,{ActionType action=ActionType.update,List<dynamic> primaryArr=const []}){
  if(action==ActionType.update){
    var foundEle=arr.where((ele)=>ele[primaryKey]==updatedValueMap[primaryKey]).toList();
    if(foundEle.length>0){
      updatedValueMap.forEach((key, value) {
        if(foundEle[0].containsKey(key)){
          foundEle[0][key]=value;
        }
      });
    }
  }
  else if(action==ActionType.deleteById){
    int index=arr.indexWhere((ele)=>ele[primaryKey]==updatedValueMap[primaryKey]);
    if(index!=-1){
      arr.removeAt(index);
    }
    int index1=primaryArr.indexWhere((ele)=>ele[primaryKey]==updatedValueMap[primaryKey]);
    if(index1!=-1){
      primaryArr.removeAt(index1);
    }
  }
  else if(action==ActionType.add){
    arr.insert(0, updatedValueMap);
  }
}



String getDataJsonForGrid(x){
  if(HE_IsMap(x)){
    return jsonEncode(x);
  }
  else if(x.runtimeType.toString()=="String"){
    return x;
  }
  return "[]";
}

WidgetType getWidgetType(var widgets){
  if(HE_IsList(widgets)){
    return WidgetType.list;
  }
  return WidgetType.map;
}
