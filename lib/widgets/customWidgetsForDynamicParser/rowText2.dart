import 'package:flutter/material.dart';
import 'package:get/get.dart';





// class RowText2 extends StatelessWidget implements MyCallback2{
//   Map map;
//   MyCallback myCallback;
//   Rxn ts=Rxn();
//   Rxn text=Rxn();
//   Rxn ts2=Rxn();
//   Rxn text2=Rxn();
//   RowText2({required this.map,required this.myCallback}){
//     ts.value=map['style1'];
//     text.value=map['value1'];
//
//     ts2.value=map['style2'];
//     text2.value=map['value2'];
//
//    /*
//     if(map.containsKey('onlyText')){
//       onlyText=map['onlyText'];
//     }*/
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//      crossAxisAlignment: WrapCrossAlignment.center,
//      spacing: 5.0,
//       children: [
//         Obx(
//               ()=> Text(
//             "${text.value??""}",
//             style: map.containsKey('style1') ? parseTextStyle(ts.value,myCallback) : null,
//             textAlign: parseTextAlign(map['textAlign']),
//
//           ),
//         ),
//         Obx(
//               ()=> Text(
//             "${text2.value??""}",
//             style: map.containsKey('style2') ? parseTextStyle(ts2.value,myCallback) : null,
//             textAlign: parseTextAlign(map['textAlign']),
//
//           ),
//         ),
//       ],
//     );
//   }
//
//   @override
//   getType() {
//     return map['type'];
//   }
//
//   @override
//   getValue() {
//     // TODO: implement getValue
//     throw UnimplementedError();
//   }
//
//   @override
//   validate() {
//     // TODO: implement validate
//     throw UnimplementedError();
//   }
//
//
//   updateValues(value){
//    // print("RowText3 ${value.runtimeType}");
//     if(value.runtimeType.toString()=="_InternalLinkedHashMap<String, dynamic>" || value.runtimeType.toString()=="_InternalLinkedHashMap<dynamic, dynamic>" ){
//       Map parsedValue=value["value"];
//       if(parsedValue.containsKey("value2")){
//         text2.value=parsedValue["value2"];
//         map["value2"]=parsedValue["value2"];
//       }
//       if(parsedValue.containsKey("style2")){
//         ts2.value=parsedValue["style2"];
//         map["style2"]=parsedValue["style2"];
//       }
//       if(parsedValue.containsKey("value1")){
//         text.value=parsedValue["value1"];
//         map["value1"]=parsedValue["value1"];
//       }
//       if(parsedValue.containsKey("style1")){
//         ts.value=parsedValue["style1"];
//         map["style1"]=parsedValue["style1"];
//       }
//     }
//   }
// }
