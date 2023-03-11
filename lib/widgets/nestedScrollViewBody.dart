import 'package:flutter/material.dart';

import '../utils/colorUtil.dart';
import '../utils/sizeLocal.dart';

class NestedScrollViewLayout extends StatefulWidget {
  Widget child;
  Widget actionWidget;
  Widget flexibleWidget;
  double expandedHeight;
  NestedScrollViewLayout({required this.child,required this.actionWidget,required this.flexibleWidget,this.expandedHeight=200.0});

  @override
  State<NestedScrollViewLayout> createState() => _NestedScrollViewLayoutState();
}

class _NestedScrollViewLayoutState extends State<NestedScrollViewLayout> {
  ScrollController? silverController;
  double silverBodyTopMargin=0;

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_){
      silverController=new ScrollController();

      setState(() {
        silverBodyTopMargin=0;
      });
      silverController!.addListener(() {
        if(silverController!.offset>(widget.expandedHeight-50)){
          setState(() {
            silverBodyTopMargin=50-(-(silverController!.offset-widget.expandedHeight));
            if(silverBodyTopMargin<0){
              silverBodyTopMargin=0;
            }
          });
        }
        else if(silverController!.offset<(widget.expandedHeight-30)){
          setState(() {
            silverBodyTopMargin=0;
          });
        }
      });
/*      silverController!.addListener(() {
        if(silverController!.offset>150){
          setState(() {
            silverBodyTopMargin=50-(-(silverController!.offset-200));
            if(silverBodyTopMargin<0){
              silverBodyTopMargin=0;
            }
          });
        }
        else if(silverController!.offset<170){
          setState(() {
            silverBodyTopMargin=0;
          });
        }
      });*/
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: silverController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            elevation: 0,
            toolbarHeight: 50,
            backgroundColor: ColorUtil.themeWhite,
            leading: Container(),
            actions: [
              widget.actionWidget
            ],
            expandedHeight: widget.expandedHeight,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                background: widget.flexibleWidget
            ),
          ),
        ];
      },
      body: Container(
          width: SizeConfig.screenWidth,
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.only(top: silverBodyTopMargin),
          padding: EdgeInsets.only(top: 0,bottom: 10),
          decoration: BoxDecoration(
           // borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
            //color: Color(0xFFF6F7F9),
            color: ColorUtil.bgColor,
          ),
          child: widget.child
      ),
    );
  }
}