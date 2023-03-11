import 'dart:ui' as ui;

import 'package:flutter/material.dart';

//Add this CustomPaint widget to the Widget Tree
/*CustomPaint(
size: Size(WIDTH, (WIDTH*0.24278605769230768).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
painter: RPSCustomPainter(),
)*/

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(size.width*-1.286058,size.height*0.9950594);
    path_0.arcToPoint(Offset(size.width*-1.307305,size.height*0.9588214),radius: Radius.elliptical(size.width*0.02985096, size.height*0.1229517),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.arcToPoint(Offset(size.width*-1.316106,size.height*0.8712958),radius: Radius.elliptical(size.width*0.02984615, size.height*0.1229319),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.lineTo(size.width*-1.316106,size.height*0.3663403);
    path_0.arcToPoint(Offset(size.width*-1.307305,size.height*0.2788245),radius: Radius.elliptical(size.width*0.02984615, size.height*0.1229319),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.arcToPoint(Offset(size.width*-1.286058,size.height*0.2425767),radius: Radius.elliptical(size.width*0.02985096, size.height*0.1229517),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.lineTo(size.width*-0.9517380,size.height*0.2425767);
    path_0.cubicTo(size.width*-0.9369856,size.height*0.2384578,size.width*-0.9122332,size.height*0.2195467,size.width*-0.8917788,size.height*0.1448133);
    path_0.arcToPoint(Offset(size.width*-0.8872909,size.height*0.1300805),radius: Radius.elliptical(size.width*0.04936298, size.height*0.2033188),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.arcToPoint(Offset(size.width*-0.8697668,size.height*0.07032743),radius: Radius.elliptical(size.width*0.09910337, size.height*0.4081922),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.arcToPoint(Offset(size.width*-0.8161058,size.height*0.004950544),radius: Radius.elliptical(size.width*0.09818510, size.height*0.4044099),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.arcToPoint(Offset(size.width*-0.7624471,size.height*0.07029773),radius: Radius.elliptical(size.width*0.09817788, size.height*0.4043802),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.arcToPoint(Offset(size.width*-0.7452909,size.height*0.1284765),radius: Radius.elliptical(size.width*0.09912981, size.height*0.4083011),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.arcToPoint(Offset(size.width*-0.7402716,size.height*0.1447143),radius: Radius.elliptical(size.width*0.04754808, size.height*0.1958435),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.arcToPoint(Offset(size.width*-0.7156514,size.height*0.2083882),radius: Radius.elliptical(size.width*0.09014423, size.height*0.3712908),rotation: 0 ,largeArc: false,clockwise: false);
    path_0.arcToPoint(Offset(size.width*-0.6920937,size.height*0.2366855),radius: Radius.elliptical(size.width*0.1066442, size.height*0.4392519),rotation: 0 ,largeArc: false,clockwise: false);
    path_0.arcToPoint(Offset(size.width*-0.6801442,size.height*0.2425470),radius: Radius.elliptical(size.width*0.1149038, size.height*0.4732720),rotation: 0 ,largeArc: false,clockwise: false);
    path_0.lineTo(size.width*-0.3485577,size.height*0.2425470);
    path_0.arcToPoint(Offset(size.width*-0.3273101,size.height*0.2787849),radius: Radius.elliptical(size.width*0.02985337, size.height*0.1229616),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.arcToPoint(Offset(size.width*-0.3185096,size.height*0.3663403),radius: Radius.elliptical(size.width*0.02985577, size.height*0.1229715),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.lineTo(size.width*-0.3185096,size.height*0.8712958);
    path_0.arcToPoint(Offset(size.width*-0.3273101,size.height*0.9588115),radius: Radius.elliptical(size.width*0.02985577, size.height*0.1229715),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.arcToPoint(Offset(size.width*-0.3485577,size.height*0.9950594),radius: Radius.elliptical(size.width*0.02985337, size.height*0.1229616),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.close();

/*    Paint paint_0_stroke = Paint()..style=PaintingStyle.stroke..strokeWidth=size.width*0.002403846;
    paint_0_stroke.color=Color(0xff6c6c6c).withOpacity(1.0);
    canvas.drawPath(path_0,paint_0_stroke);*/

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = Color(0xff060606);
    canvas.drawPath(path_0,paint_0_fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}