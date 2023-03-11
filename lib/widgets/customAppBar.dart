
import 'package:flutter/material.dart';
import '/utils/sizeLocal.dart';
import '/widgets/fittedText.dart';
import '../helper/language.dart';
import '../utils/colorUtil.dart';
import '../utils/constants.dart';
import 'accessWidget.dart';

class CustomAppBar extends StatelessWidget {
  String title;
  Widget? prefix;
  Widget? suffix;
  CustomAppBar({required this.title,this.prefix,this.suffix});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      // width: SizeConfig.screenWidth,
      child: Row(
        children: [
          prefix==null?GestureDetector(
            onTap:(){
              Navigator.pop(context);
            },
            child: Container(
                height:50,
                width:50,
                color: Colors.transparent,
                child: Icon(Icons.arrow_back_ios_new_outlined,color: ColorUtil.themeBlack,size: 20,)
            ),
          ):prefix!,
          FittedText(
            height: 40,
            width: SizeConfig.screenWidth!-200,
            text: title,
            textStyle: ts18(ColorUtil.primaryTextColor2,fontfamily: 'Med'),
          ),
          //Text(title,style:  ts18(ColorUtil.primaryTextColor2,fontfamily: Language.regularFF),),
          const Spacer(),
          suffix??Container()
        ],
      ),
    );
  }
}

class ArrowBack extends StatelessWidget {

  VoidCallback? onTap;
  double height;
  double? imageheight;
  Color iconColor;
  ArrowBack({this.onTap,this.height=50,this.imageheight,this.iconColor=Colors.white});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
          height: 50,
          width: 50 ,
          color: Colors.transparent,
          child: Center(
            child: Icon(Icons.arrow_back_ios_outlined,color: iconColor,size: 20,),
          )
      ),
    );
  }
}


class EyeIcon extends StatelessWidget {
  VoidCallback? onTap;
  EyeIcon({Key? key,this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        width: 30,
        height: 30,
        alignment:Alignment.center,
        decoration: BoxDecoration(
            color: ColorUtil.primary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5)
        ),
        child: Icon(Icons.remove_red_eye_outlined,color: ColorUtil.primary,size: 20,),
      ),
    );
  }
}

class FilterIcon extends StatelessWidget {
  VoidCallback? onTap;
  FilterIcon({Key? key,this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        width: 0,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorUtil.primary,
        ),
        child: Icon(Icons.filter_alt_outlined,color:ColorUtil.theme,),
      ),
    );
  }
}
class RefreshIcon extends StatelessWidget {
  VoidCallback? onTap;
  bool visible;
  Color bg;
  Color iconColor;
  BoxShape boxShape;
  RefreshIcon({Key? key,this.onTap,this.visible=true,this.bg= Colors.white,this.iconColor=const Color(0xff5A8418),
  this.boxShape= BoxShape.rectangle}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: GestureDetector(
        onTap:onTap,
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: bg,
            shape: boxShape
          ),
          child: Icon(Icons.refresh,color:iconColor,),
        ),
      ),
    );
  }
}

class GridAddIcon extends StatelessWidget {
  VoidCallback? onTap;
  GridAddIcon({Key? key,this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorUtil.primary,
        ),
        child: Icon(Icons.add,color:ColorUtil.theme,),
      ),
    );
  }
}

EdgeInsets actionIconMargin=const EdgeInsets.only(left: 5);

class GridDeleteIcon extends StatelessWidget {
  VoidCallback? onTap;
  double height;
  bool hasAccess;
  EdgeInsets margin;
  GridDeleteIcon({Key? key,this.onTap,this.height=30,required this.hasAccess,this.margin=const EdgeInsets.all(0)}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AccessWidget(
      onTap:onTap,
      hasAccess: hasAccess,
      needToHide: true,
      widget: Container(
        width: height,
        height: height,
        alignment:Alignment.center,
        margin: margin,
        decoration: BoxDecoration(
            color: ColorUtil.primary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5)
        ),
        child: Icon(Icons.delete_outline,color: ColorUtil.red,size: 20,),
        //child:Text('View ',style: TextStyle(color: ColorUtil.primaryTextColor2,fontSize: 14,fontFamily: 'RR'),),
      ),
    );
  }
}
class GridEditIcon extends StatelessWidget {
  VoidCallback? onTap;
  double height;
  bool hasAccess;
  EdgeInsets margin;
  GridEditIcon({Key? key,this.onTap,this.height=30,required this.hasAccess,this.margin=const EdgeInsets.all(0)}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AccessWidget(
      onTap:onTap,
      hasAccess: hasAccess,
      needToHide: true,
      widget: Container(
        width: height,
        height: height,
        alignment:Alignment.center,
        margin: margin,
        decoration: BoxDecoration(
            color: ColorUtil.primary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5)
        ),
        child: Icon(Icons.edit,color: ColorUtil.themeBlack,size: 20,),
        //child:Text('View ',style: TextStyle(color: ColorUtil.primaryTextColor2,fontSize: 14,fontFamily: 'RR'),),
      ),
    );
  }
}


class LanguageSwitch extends StatelessWidget {
  VoidCallback onChange;
  LanguageSwitch({required this.onChange});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(selectedLanguage.value==1){
          selectedLanguage.value=2;
        }
        else if(selectedLanguage.value==2){
          selectedLanguage.value=1;
        }
        Language.parseJson(selectedLanguage.value).then((value){
          onChange();
        });

      },
      child: Container(
        height: 50,
        width: 50,
        margin: const EdgeInsets.only(right: 10),
        alignment: Alignment.center,
        color: Colors.transparent,
        child: Image.asset(selectedLanguage.value==1?"assets/icons/English.png":"assets/icons/Tamil.png",height: 30,),
      ),
    );
  }
}




