
import 'package:flutter/material.dart';
import '/utils/colorUtil.dart';
import '/utils/constants.dart';

class CustomCheckBox extends StatelessWidget {
  bool isSelect;
  VoidCallback? ontap;
  double height;
  Color selectColor;
  Color unSelectColor;
  EdgeInsets margin;
  double icnSize;
  String content;
  bool onlyCheckbox;
  CustomCheckBox({required this.isSelect,this.ontap,this.height=22,this.selectColor=const Color(0xff019342),
  this.unSelectColor=const Color(0xffE5E5ED),this.margin=const EdgeInsets.only(left: 0),this.icnSize=20.0,
  this.content="",this.onlyCheckbox=false});

  @override
  Widget build(BuildContext context) {
    return onlyCheckbox?GestureDetector(
      onTap: ontap,
      child: AnimatedContainer(
        duration: MyConstants.animeDuration,
        curve: Curves.easeIn,
        height: height,
        width: height,
        margin: margin,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color:isSelect?selectColor: unSelectColor,
        ),
        child: isSelect?Icon(Icons.done,color:Colors.white,size: icnSize,):Container(),
      ),
    ):
    GestureDetector(
      onTap: ontap,
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            AnimatedContainer(
              duration: MyConstants.animeDuration,
              curve: Curves.easeIn,
              height: height,
              width: height,
              margin: margin,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color:isSelect?selectColor: unSelectColor,
              ),
              child: isSelect?Icon(Icons.done,color:Colors.white,size: icnSize,):Container(),
            ),
            const SizedBox(width: 10,),
            Flexible(
              child: Text(content,style: ts18(ColorUtil.chkBoxText),),
            )
          ],
        ),
      ),
    );
  }
}
