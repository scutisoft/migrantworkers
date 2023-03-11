
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../utils/colorUtil.dart';
import '../utils/constants.dart';
import '../utils/sizeLocal.dart';
import 'validationErrorText.dart';

final otpInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: const EdgeInsets.symmetric(vertical: 15),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);
OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color:  Color(0xFFf3f3f3)),
  );
}
InputBorder inputBorder(){
  return InputBorder.none;
}

class PinWidget extends StatelessWidget {

  int pinLength;
  VoidCallback onComplete;
  PinWidget({required this.pinLength,required this.onComplete}){
    init();
  }

  void init(){
    textControllers.clear();
    for(int i=0;i<pinLength;i++){
      textControllers.add(new TextEditingController());
      focusNodes.add(new FocusNode());
    }
  }

  void nextField(String value,int index) {
    if (value.length == 1) {
      focusNodes[index+1].requestFocus();
    }
    else if(value.isEmpty){
      if(index>0){
        focusNodes[index-1].requestFocus();
      }
    }
  }

  List<TextEditingController> textControllers=[];
  List<FocusNode> focusNodes=[];

  String getValue(){
    String pin="";
    textControllers.forEach((element) {
      if(element.text.isNotEmpty){
        pin+=element.text;
      }
    });
    return pin;
  }

  validate(){
    if(getValue().length!=pinLength){
      isValid.value=false;
    }
    else{
      isValid.value=true;
    }
    return isValid.value;
  }

  void clearValues(){
    textControllers.forEach((element) {
      element.text="";
    });
  }

  void requestFocus(){
    if(focusNodes.length>0){
      focusNodes[0].requestFocus();
    }
  }

  var isValid=true.obs;
  var errorText="* Required".obs;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for(int i=0;i<textControllers.length;i++)
                SizedBox(
                  width: 45,
                  height: 45,
                  child: TextFormField(
                    controller: textControllers[i],
                    focusNode: focusNodes[i],
                    autofocus: true,
                    obscureText: true,
                    obscuringCharacter: '*',
                    style: const TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.allow(RegExp(MyConstants.digitRegEx)),
                    ],

                    onChanged: (value) {
                      if(i==pinLength-1 && value.isNotEmpty){
                        focusNodes[i].unfocus();
                        onComplete();
                      }
                      else if(value.length==pinLength){
                        focusNodes[i].unfocus();
                        onComplete();
                      }
                      else{
                        nextField(value,i);
                      }
                    },
                  ),
                ),
                /*Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RawKeyboardListener(
                        focusNode: focusNodes[i],
                        child: const SizedBox.shrink(),
                        onKey: (e){
                          if(textControllers[i].text.isNotEmpty && !e.repeat){
                            nextField(e.data.keyLabel, i);
                          }

                        },
                    ),

                  ],
                )*/
            ],
          ),
        ),
        Obx(() => Visibility(
          visible: !isValid.value,
          child: ValidationErrorText(title: errorText.value,),
        ))
      ],
    );
  }
}

class DoneBtn extends StatelessWidget {
  String title;
  VoidCallback onDone;
  DoneBtn({required this.onDone,required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDone,
      child: Container(
        height: 50,
        width: SizeConfig.screenWidth!*0.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: ColorUtil.secondary,
        ),
        alignment: Alignment.center,
        child: Text(title,style: ts18(Colors.white,fontsize: 18,fontfamily: 'Med'),textAlign: TextAlign.center,),
      ),
    );
  }
}
class LeftAlignHeader extends StatelessWidget {
  String title;
  LeftAlignHeader({required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 20),
      child: Text(title,style: ts18(ColorUtil.primaryTextColor2),),
    );
  }
}