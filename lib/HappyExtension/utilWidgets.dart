import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../utils/utils.dart';
import '../widgets/validationErrorText.dart';

import '../HappyExtension/extensionHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../helper/language.dart';
import '../utils/colorUtil.dart';
import '../utils/constants.dart';
import '../utils/sizeLocal.dart';
import 'extensionUtils.dart';

TextStyle errorTS=TextStyle(fontFamily: 'RR',fontSize: 14,color: Color(0xFFE34343));

class HiddenController extends StatelessWidget implements ExtensionCallback{
  bool hasInput;
  String dataname;
 // var value="".obs;

  HiddenController({this.hasInput=true,required this.dataname});

  Rxn value=Rxn();
  var orderBy=1.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0,
      child: Obx(() => Text("${value.value}")),
    );
  }
  @override
  getType(){
    return 'hidden';
  }
  @override
  getValue(){
    return value.value;
  }
  @override
  setValue(var val){
    value.value=val;
  }
  @override
  String getDataName(){
    return dataname;
  }

  @override
  void clearValues() {
    value.value="";
  }

  @override
  int getOrderBy() {
    return orderBy.value;
  }

  @override
  setOrderBy(int oBy) {
    orderBy.value=oBy;
  }

  @override
  bool validate() {
    return true;
  }
}

Color addNewTextFieldText=Color(0xFF787878);

Color addNewTextFieldBorder=Color(0xFFCDCDCD);
const Color addNewTextFieldFocusBorder=Color(0xFF6B6B6B);
class AddNewLabelTextField extends StatelessWidget {
  bool isEnabled;
  String? labelText;
  double scrollPadding;
  TextInputType textInputType;
  Widget? prefixIcon;
  Widget? suffixIcon;
  Function(String)? onChange;
  VoidCallback? ontap;
  TextInputFormatter? textInputFormatter;
  VoidCallback? onEditComplete;
  bool isObscure;
  int? maxlines;
  int? textLength;
  String? regExp;

  bool hasInput;
  bool required;
  String dataname;
  int minLength;
  bool needMinLengthCheck;
  bool needEmailCheck;
  late TextEditingController textEditingController;

  AddNewLabelTextField({this.labelText,this.scrollPadding=270.0,this.textInputType:TextInputType.text,
    this.prefixIcon,this.ontap,this.onChange,this.textInputFormatter,this.isEnabled=true,this.suffixIcon,this.onEditComplete,
    this.isObscure=false,this.maxlines=1,this.textLength=null,this.regExp='[A-Za-z0-9@.,]',this.hasInput=true,this.required=false,required this.dataname,
  this.minLength=1,this.needMinLengthCheck=false,this.needEmailCheck=false}){
    textEditingController= new TextEditingController();
  }
  var isValid=true.obs;
  var orderBy=1.obs;
  var errorText="* ${Language.required}".obs;
  var reload=false.obs;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  maxlines!=null? Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: ColorUtil.formMargin,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.transparent
          ),
          child:  Obx(() => TextFormField(
            enabled: reload.value?isEnabled:isEnabled,
            onTap: ontap,
            obscureText: isObscure,
            obscuringCharacter: '*',
            scrollPadding: EdgeInsets.only(bottom: scrollPadding),
            style:  TextStyle(fontFamily: Language.regularFF,fontSize: 16,color:ColorUtil.text3,letterSpacing: 0.2),
            controller: textEditingController,
            cursorColor:ColorUtil.text4,
            decoration: InputDecoration(
              fillColor:isEnabled?Colors.white:ColorUtil.disableColor,
              filled: true,
              labelStyle: TextStyle(fontFamily: Language.regularFF,fontSize: 16,color: ColorUtil.text3),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(3)),
                borderSide: BorderSide(
                  width: 0.2,
                  color: ColorUtil.text4,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(3)),
                borderSide: BorderSide(
                  width: 0.2,
                  color: ColorUtil.text4,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(3)),
                borderSide: BorderSide(
                  width: 0.2,
                  color:ColorUtil.primary,
                ),
              ),
              labelText: labelText,
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
            ),
            maxLines: maxlines,
            keyboardType: textInputType,
            textInputAction: TextInputAction.done,
            // inputFormatters:  <TextInputFormatter>[
            //
            //   //textInputFormatter
            // ],

            inputFormatters:regExp!=null? [
              LengthLimitingTextInputFormatter(textLength),
              FilteringTextInputFormatter.allow(RegExp(regExp!)),
            ]:[
              LengthLimitingTextInputFormatter(textLength),
            ],
            onChanged: (v){
              onChange!(v);
            },
            onEditingComplete: (){
              onEditComplete!();
            },
          )),
        ),
        Obx(
                ()=>isValid.value?Container():Container(
                margin:  const EdgeInsets.only(left:20,right:20,bottom:5,),
                child: Text(errorText.value,style: errorTS,)
            )
        ),
      ],
    ):
    Container(

      margin: const EdgeInsets.only(left:20,right:20,top:15,),
      //    height: 50,

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Colors.transparent
      ),
      child:  TextFormField(
        enabled: isEnabled,
        onTap: ontap,
        obscureText: isObscure,
        obscuringCharacter: '*',
        scrollPadding: EdgeInsets.only(bottom: scrollPadding),
        style:  TextStyle(fontFamily: Language.regularFF,fontSize: 15,color:addNewTextFieldText,letterSpacing: 0.2),
        controller: textEditingController,
        decoration: InputDecoration(
            fillColor:isEnabled?Colors.white: Color(0xFFe8e8e8),
            filled: true,
            labelStyle: TextStyle(fontFamily: Language.regularFF,fontSize: 15,color: addNewTextFieldText.withOpacity(0.9)),
            border:  OutlineInputBorder(
                borderSide: BorderSide(color: addNewTextFieldBorder)
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: addNewTextFieldBorder)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color:addNewTextFieldFocusBorder)
            ),
            labelText: labelText,
            contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon



        ),
        maxLines: maxlines,
        keyboardType: textInputType,
        textInputAction: TextInputAction.done,

        onChanged: (v){
          onChange!(v);
        },
        onEditingComplete: (){

          onEditComplete!();
        },
      ),

    );
  }

  getType(){
    return 'inputTextField';
  }

  getValue(){
    return textEditingController.text;
  }

  setValue(var value){
    textEditingController.text=value.toString();
  }

  String getDataName(){
    return dataname;
  }

  void clearValues(){
    textEditingController.text="";
  }

  validate(){
    requiredCheck();
    if(needMinLengthCheck){
      minLengthCheck(minLength);
    }
    if(needEmailCheck){
      emailValidation();
    }
    return isValid.value;
  }
  requiredCheck(){
    if(textEditingController.text.isEmpty){
      isValid.value=false;
      errorText.value="* ${Language.required}";
    }
    else{
      isValid.value=true;
    }
    // return isValid.value;
  }
  minLengthCheck(dynamic min){
    if(textEditingController.text.isEmpty){
      isValid.value=false;
      errorText.value="* Minimum Length is $min";
    }
    else if(textEditingController.text.length<int.parse(min.toString())){
      isValid.value=false;
      errorText.value="* Minimum Length is $min";

    }
    else{
      isValid.value=true;
    }
    //  return isValid.value;
  }
  maxLengthCheck(dynamic max){
    if(textEditingController.text.isEmpty){
      isValid.value=false;
      errorText.value="* Maximum Length is $max";
    }
    else if(textEditingController.text.length>int.parse(max.toString())){
      isValid.value=false;
      errorText.value="* Maximum Length is $max";

    }
    else{
      isValid.value=true;
    }
    // return isValid.value;
  }
  emailValidation(){

    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex =  RegExp(pattern as String);

    if (!regex.hasMatch(textEditingController.text)) {
      isValid.value=false;
      errorText.value='* Email format is invalid';
    }
    else {
      isValid.value=true;
    }
    // return isValid.value;
  }

  int getOrderBy() {
    return orderBy.value;
  }

  setOrderBy(int oBy) {
    orderBy.value=oBy;
  }
}

class HE_Text extends StatelessWidget implements ExtensionCallback{
  bool hasInput;
  bool required;
  String dataname;
  String content;
  TextStyle contentTextStyle;
  TextOverflow? textOverFlow;
  TextAlign textAlign;
  bool needRupeeFormat;
  HE_Text({this.hasInput=false,this.required=false,required this.dataname,this.content="Hello",required this.contentTextStyle,this.textOverFlow,
    this.textAlign=TextAlign.start,this.needRupeeFormat=false
  }){
    setValue(content);
    textStyle.value=contentTextStyle;
  }
  Rxn text=Rxn();
  Rxn<TextStyle> textStyle=Rxn<TextStyle>();

  var orderBy=1.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=>Text("${text.value}",style: textStyle.value,overflow: textOverFlow,textAlign: textAlign,)
    );
  }

  @override
  void clearValues() {
    text.value="";
  }

  @override
  String getDataName() {
    return dataname;
  }

  @override
  String getType() {
    return 'HE_Text';
  }

  @override
  getValue() {
    return text;
  }

  @override
  setValue(value) {
    if(needRupeeFormat){
      text.value="${MyConstants.rupeeString} ${formatCurrency.format(parseDouble(value))}";
    }
    else{
      text.value=value.toString();
    }
  }

  @override
  bool validate() {
    return text.value.isNotEmpty;
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

class HE_WrapText extends StatelessWidget implements ExtensionCallback{
  bool hasInput;
  bool required;
  String dataname;
  String content;
  TextStyle contentTextStyle;
  String content2;
  TextStyle contentTextStyle2;

  HE_WrapText({this.hasInput=false,this.required=false,required this.dataname,this.content="Hello",required this.contentTextStyle,
    this.content2="Hello",required this.contentTextStyle2}){
    text.value=content;
    text2.value=content2;
    textStyle.value=contentTextStyle;
    textStyle2.value=contentTextStyle2;
  }
  Rxn text=Rxn();
  Rxn text2=Rxn();
  Rxn<TextStyle> textStyle=Rxn<TextStyle>();
  Rxn<TextStyle> textStyle2=Rxn<TextStyle>();

  var orderBy=1.obs;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 5.0,
      children: [
        Obx(
              ()=> Text(
            "${text.value??""}",
            style: textStyle.value,

          ),
        ),
        Obx(
              ()=> Text(
            "${text2.value??""}",
            style: textStyle2.value,
          ),
        ),
      ],
    );
  }

  @override
  void clearValues() {
    // TODO: implement clearValues
  }

  @override
  String getDataName() {
    return dataname;
  }

  @override
  String getType() {
    return 'HE_WrapText';
  }

  @override
  getValue() {
    // TODO: implement getValue
    throw UnimplementedError();
  }

  @override
  setValue(value) {
    print(value);
    if(value.runtimeType.toString()=="_InternalLinkedHashMap<String, dynamic>" || value.runtimeType.toString()=="_InternalLinkedHashMap<dynamic, dynamic>" ){
      Map parsedValue=value;
      if(parsedValue.containsKey("value2")){
        text2.value=parsedValue["value2"].toString();
      }
      if(parsedValue.containsKey("style2")){
        textStyle2.value=parsedValue["style2"];
      }
      if(parsedValue.containsKey("value1")){
        text.value=parsedValue["value1"].toString();
      }
      if(parsedValue.containsKey("style1")){
        textStyle.value=parsedValue["style1"];
      }
    }
  }

  @override
  bool validate() {
    // TODO: implement validate
    throw UnimplementedError();
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
class HE_WrapText2 extends StatelessWidget implements ExtensionCallback{
  bool hasInput;
  bool required;
  String dataname;
  String content;
  TextStyle contentTextStyle;
  String content2;
  TextStyle contentTextStyle2;

  HE_WrapText2({this.hasInput=false,this.required=false,required this.dataname,this.content="Hello",required this.contentTextStyle,
    this.content2="Hello",required this.contentTextStyle2}){
    text.value=content;
    text2.value=content2;
    textStyle.value=contentTextStyle;
    textStyle2.value=contentTextStyle2;
  }
  Rxn text=Rxn();
  Rxn text2=Rxn();
  Rxn<TextStyle> textStyle=Rxn<TextStyle>();
  Rxn<TextStyle> textStyle2=Rxn<TextStyle>();

  var orderBy=1.obs;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
   //   crossAxisAlignment: WrapCrossAlignment.center,
 //     spacing: 5.0,
      children: [
        Obx(
              ()=> Text(
            "${text.value??""}",
            style: textStyle.value,

          ),
        ),
        Obx(
              ()=> Flexible(
                child: Text(
            "${text2.value??""}",
            style: textStyle2.value,
          ),
              ),
        ),
      ],
    );
  }

  @override
  void clearValues() {
    // TODO: implement clearValues
  }

  @override
  String getDataName() {
    return dataname;
  }

  @override
  String getType() {
    return 'HE_WrapText';
  }

  @override
  getValue() {
    // TODO: implement getValue
    throw UnimplementedError();
  }

  @override
  setValue(value) {
    print(value);
    if(value.runtimeType.toString()=="_InternalLinkedHashMap<String, dynamic>" || value.runtimeType.toString()=="_InternalLinkedHashMap<dynamic, dynamic>" ){
      Map parsedValue=value;
      if(parsedValue.containsKey("value2")){
        text2.value=parsedValue["value2"].toString();
      }
      if(parsedValue.containsKey("style2")){
        textStyle2.value=parsedValue["style2"];
      }
      if(parsedValue.containsKey("value1")){
        text.value=parsedValue["value1"].toString();
      }
      if(parsedValue.containsKey("style1")){
        textStyle.value=parsedValue["style1"];
      }
    }
  }

  @override
  bool validate() {
    // TODO: implement validate
    throw UnimplementedError();
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

class HE_LocationPicker extends StatelessWidget implements ExtensionCallback{
  bool hasInput;
  bool required;
  String dataname;
  String content;
  TextStyle contentTextStyle;
  Function(dynamic) locationPickCallback;
  bool isEnabled;
  HE_LocationPicker({this.hasInput=false,this.required=false,required this.dataname,this.content="Address",required this.contentTextStyle,
    required this.locationPickCallback,this.isEnabled=true}){
    //text.value=content;
  }

  RxString text=RxString("");
  Rxn addressDetail=Rxn();

  var isValid=true.obs;
  var errorText="* ${Language.required}".obs;
  var orderBy=1.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          width: SizeConfig.screenWidth,
          margin: ColorUtil.formMargin,
          padding: EdgeInsets.only(left:10,),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: isEnabled?Colors.white: ColorUtil.disableColor,
              border: Border.all(color: addNewTextFieldBorder)
          ),
          child: Row(
            children: [
              Expanded(
                child: Obx(() => Text(text.value.isEmpty ? content:text.value,
                  style: text.value.isEmpty ?ts15(addNewTextFieldText.withOpacity(0.9)):contentTextStyle,
                )),
              ),
              GestureDetector(
                onTap: !isEnabled?null: (){
                  locationClick();
                },
                child: Container(
                  height: 50,
                  width: 50,
                  color: Colors.transparent,
                  child: Icon(Icons.my_location,color: ColorUtil.secondary,),
                ),
              )
            ],
          ),
        ),
        Obx(
                ()=>isValid.value?Container():ValidationErrorText(title: errorText.value,)
        ),
      ],
    );
  }

  locationClick() async {
    Position? position;
    position=await determinePosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude,localeIdentifier: "enUS");
    String delim1=placemarks.first.thoroughfare.toString().isNotEmpty?", ":"";
    String delim2=placemarks.first.subLocality.toString().isNotEmpty?", ":"";
    String delim3=placemarks.first.administrativeArea.toString().isNotEmpty?", ":"";

    String location = placemarks.first.street.toString() +
        delim1 +  placemarks.first.thoroughfare.toString()+
        delim2+placemarks.first.subLocality.toString();
    // delim3 +placemarks.first.administrativeArea.toString();


    addressDetail.value={
      "Street":placemarks.first.street,
      "Sublocality":placemarks.first.subLocality,
      "Locality":placemarks.first.locality,
      "State":placemarks.first.administrativeArea,
      "Country":placemarks.first.country,
      "PostalCode":placemarks.first.postalCode,
      "Thoroughfare":placemarks.first.thoroughfare,
      "Latitude":position.latitude,
      "Longitude":position.longitude,
    };
    text.value=location;
    locationPickCallback(addressDetail.value);
  }

  @override
  void clearValues() {
    text.value="";
    addressDetail.value="";
  }

  @override
  String getDataName() {
    return dataname;
  }

  @override
  String getType() {
    return 'locationPicker';
  }

  @override
  getValue() {
    //print("addressDetail.runtimeType.toString() ${addressDetail.value.runtimeType.toString()}");
    if(addressDetail.value.runtimeType==String){
      return addressDetail.value={
        "Address":text.value
      };
    }

    else if(HE_IsMap(addressDetail.value)){
      addressDetail.value["Address"]=text.value;
    }
    return addressDetail.value;
  }

  @override
  setValue(value) {
    if(HE_IsMap(value) || addressDetail.value.runtimeType.toString() =="_InternalLinkedHashMap<String, Object?>"){
      addressDetail.value=value;
      text.value=value["Address"]??"";
    }
  }

  @override
  bool validate() {
    isValid.value=true;
    if(text.value==""){
      isValid.value=false;
      return false;
    }
    if(addressDetail.value==null){
      isValid.value=false;
      return false;
    }
    return isValid.value;
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

















//Json Parsing Functions

TextStyle? parseTextStyle(var textStyle) {
  var map=textStyle;
  if (map == null) {
    return null;
  }
  // else if(textStyle.runtimeType== String){
  //   map=myCallback.getWidgetMapFromTemplate(textStyle);
  // }

  //TODO: more properties need to be implemented, such as decorationColor, decorationStyle, wordSpacing and so on.
  String? color = map['color'];
  String? debugLabel = map['debugLabel'];
  String? decoration = map['decoration'];
  String? decorationColor = map['decorationColor'];
  String? shadowColor = map['shadowColor'];
  String? fontFamily = map['fontFamily'];
  double? fontSize = map['fontSize']?.toDouble();
  String? fontWeight = map['fontWeight'];
  FontStyle fontStyle =
  'italic' == map['fontStyle'] ? FontStyle.italic : FontStyle.normal;

  return TextStyle(
    color: parseHexColor(color),
    debugLabel: debugLabel,
    decoration: parseTextDecoration(decoration),
    decorationColor: parseHexColor(decorationColor),
    fontSize: fontSize,
    fontFamily: fontFamily,
    fontStyle: fontStyle,
    shadows:map.containsKey('shadowColor')? [
      Shadow(
          color: parseHexColor(shadowColor)!,
          offset: Offset(0, map['offsetDy'])
      )
    ]:null,
    //   fontWeight: parseFontWeight(fontWeight),
  );
}
Color? parseHexColor(String? hexColorString) {
  if (hexColorString == null) {
    return Colors.transparent;
  }
  if(hexColorString.contains("*")){
    //return myCallback.ontap({"eventName":"parseColor","color":hexColorString});
    return Colors.transparent;
  }
  else{
    hexColorString = hexColorString.toUpperCase().replaceAll("#", "");
    if(hexColorString=='red'.toUpperCase()){
      return Colors.red;
    }
    else if(hexColorString=='green'.toUpperCase()){
      return Colors.green;
    }
    else if(hexColorString=='transparent'.toUpperCase()){
      return Colors.transparent;
    }
    else if(hexColorString=='hide'.toUpperCase()){
      return null;
    }
    else{
      if (hexColorString.length == 6) {
        hexColorString = "FF" + hexColorString;
      }
      int colorInt = int.parse(hexColorString, radix: 16);
      return Color(colorInt);
    }
  }
}
TextDecoration parseTextDecoration(String? textDecorationString) {
  TextDecoration textDecoration = TextDecoration.none;
  switch (textDecorationString) {
    case "lineThrough":
      textDecoration = TextDecoration.lineThrough;
      break;
    case "overline":
      textDecoration = TextDecoration.overline;
      break;
    case "underline":
      textDecoration = TextDecoration.underline;
      break;
    case "none":
    default:
      textDecoration = TextDecoration.none;
  }
  return textDecoration;
}
