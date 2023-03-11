import 'package:flutter/material.dart';
class AccessWidget extends StatelessWidget {
  bool needToHide;
  bool hasAccess;
  VoidCallback? onTap;
  Widget widget;
  AccessWidget({this.needToHide=false,required this.hasAccess,this.onTap,required this.widget});
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: needToHide?hasAccess:true,
    //  replacement: Container(width: 0,),
      child: GestureDetector(
        onTap: hasAccess?onTap:null,
        //onTap: onTap,
        child: Opacity(
          opacity: hasAccess?1:0.3,
          child: widget,
        ),
      ),
    );
  }
}
