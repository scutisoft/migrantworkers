
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helper/language.dart';

import '../api/ApiManager.dart';
import '../utils/colorUtil.dart';
import '../utils/sizeLocal.dart';
import 'shimmer.dart';

class Loader extends StatelessWidget {
  bool? value;
  Loader({this.value});
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: value??false,
      //ignoring:value!?false: true,
      child: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          color:Colors.black26,
          child: Center(
            child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                 child: Image.asset("assets/login/Loader.gif",filterQuality: FilterQuality.high,gaplessPlayback: true,isAntiAlias: true,)
                //child: CircularProgressIndicator(color: ColorUtil.secondary,)
            ),
          )
      ),
    );
  }
}

/*class Blur extends StatelessWidget {
  bool? value;
  Blur({this.value});
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring:value!?false: true,
      child: AnimatedOpacity(
        duration: animeDuration,
        curve: animeCurve,
        opacity: value!?1:0,
        // opacity: 1,
        child: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            color:Colors.black54,
        ),
      ),
    );
  }
}*/

class NoData extends StatelessWidget {
  bool show;
  double topPadding;
  NoData({this.show=true,this.topPadding=0});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: show,
      child: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: topPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/no-data-available.jpg",height: 120,),
              const SizedBox(height: 10,),
              Text(Language.noData,
                style: TextStyle(fontFamily: Language.regularFF,fontSize: 18,color: ColorUtil.text5),
              ),
            ],
          )
      ),
    );
  }
}


//Shimmmer Loaders
class BannerPlaceholder extends StatelessWidget {
  const BannerPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200.0,
       margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
      ),
    );
  }
}

class TitlePlaceholder extends StatelessWidget {
  final double width;

  const TitlePlaceholder({
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            height: 12.0,
            color: Colors.white,
          ),
          SizedBox(height: 8.0),
          Container(
            width: width,
            height: 12.0,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

enum ContentLineType {
  twoLines,
  threeLines,
}

class ContentPlaceholder extends StatelessWidget {
  final ContentLineType lineType;

  const ContentPlaceholder({
    Key? key,
    required this.lineType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 96.0,
            height: 72.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 10.0,
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 8.0),
                ),
                if (lineType == ContentLineType.threeLines)
                  Container(
                    width: double.infinity,
                    height: 10.0,
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 8.0),
                  ),
                Container(
                  width: 100.0,
                  height: 10.0,
                  color: Colors.white,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


class ShimmerLoader extends StatelessWidget {

  ShimmerLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Visibility(
        visible: showLoader.value,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          color: Colors.white,
          child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: Column(
                /*shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),*/
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const BannerPlaceholder(),
                  const TitlePlaceholder(width: double.infinity),
                  const SizedBox(height: 16.0),
                  const ContentPlaceholder(
                    lineType: ContentLineType.threeLines,
                  ),
                  const SizedBox(height: 16.0),
                  const TitlePlaceholder(width: 200.0),
                  const SizedBox(height: 16.0),
                  const ContentPlaceholder(
                    lineType: ContentLineType.twoLines,
                  ),
                  const SizedBox(height: 16.0),
                  const TitlePlaceholder(width: 200.0),
                  const SizedBox(height: 16.0),
                  const ContentPlaceholder(
                    lineType: ContentLineType.twoLines,
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }
}
