import 'package:flutter/material.dart';

import '../utils/colorUtil.dart';
import '../utils/utils.dart';

class StackIcon extends StatelessWidget {

  Widget icon;
  double top;
  double right;
  StackIcon({super.key, required this.icon,this.top=0,this.right=0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 42,
      height: 42,
      //color: Colors.red,
      child: Stack(
        children: [
          Positioned(
            bottom:0,
            child: Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                  color: ColorUtil.primary.withOpacity(0.1),
                  shape: BoxShape.circle
              ),
            ),
          ),
          Positioned(
            top: top,
            right: right,
            child: icon,
          )
        ],
      ),
    );
  }
}

class EGFEmblem extends StatelessWidget {
  dynamic companyId;
  bool isGov;
  EdgeInsets margin;
  double imgHeight;
  EGFEmblem({Key? key,required this.companyId,this.margin=const EdgeInsets.only(left: 5),this.imgHeight=30,required this.isGov}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: companyId.toString()==egfCompanyId && !isGov,
      child: Container(
        height: imgHeight,
        width: imgHeight,
        margin: margin,
        alignment: Alignment.center,
        child: Image.asset("assets/eco-green-logo.png"),
      ),
    );
  }
}

