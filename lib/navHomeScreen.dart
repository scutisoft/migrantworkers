import 'package:flutter/material.dart';
import '../utils/colorUtil.dart';
import '../utils/sizeLocal.dart';
import 'pages/homePage/CustomerGrid.dart';
import 'pages/loginpage/login.dart';


class Masterpage extends StatefulWidget {
  const Masterpage({Key? key}) : super(key: key);

  @override
  _MasterpageState createState() => _MasterpageState();
}

class _MasterpageState extends State<Masterpage> {
  @override
  GlobalKey <ScaffoldState> scaffoldkey=new GlobalKey<ScaffoldState>();
  int menuSel=1;
  late  double width,height,width2;
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    width2=width-16;
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        key: scaffoldkey,
        drawer: Container(
          height: height,
          width: SizeConfig.screenWidth!*0.8,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color:ColorUtil.primary,
            //    borderRadius: BorderRadius.only(topRight: Radius.circular(15),bottomRight: Radius.circular(15))
          ),

          child:Column(
            children: [
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 30,top: 20),
                    decoration: BoxDecoration(
                        color: ColorUtil.themeWhite,
                        shape: BoxShape.circle
                    ),
                    child: IconButton(onPressed: (){
                      scaffoldkey.currentState!.openEndDrawer();
                      // Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ThemeSettings()));
                    }, icon: Icon(Icons.arrow_back_ios_sharp,color:ColorUtil.primary,size: 20,),),
                  ),
                  SizedBox(width: 5,),
                  Image.asset("assets/logo.png",width: 200,)
                ],
              ),

              SizedBox(height: 5,),
              Container(
                height: SizeConfig.screenHeight!-280,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      DrawerContent(
                        title: 'Customer Details',
                        ontap: (){
                          setState(() {
                            menuSel=1;
                          });
                          scaffoldkey.currentState!.openEndDrawer();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              DrawerContent(
                title: 'LogOut',
                ontap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>loginPage()),);
                },
              ),
              // Divider(color: Color(0xff099FAF),thickness: 0.1,),
            ],
          ),
        ),
        body:menuSel==1?CustomerGrid(
          voidCallback:(){
            scaffoldkey.currentState!.openDrawer();
          },
        ):Container(),
      ),



    );
  }
}

class DrawerContent extends StatelessWidget {
  String title;
  VoidCallback ontap;
  DrawerContent({required this.title,required this.ontap});
  late double width;

  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 40,
        width: width,
        color: Colors.transparent,
        margin: EdgeInsets.only(top: 5,bottom: 5,left:10 ),
        child: Row(
          children: [
            SizedBox(width: 20,),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color:Color(0xff74BE70),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Icon(Icons.date_range_outlined,color: Colors.black,size: 20,),
            ),
            SizedBox(width: 20,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("$title",
                  style: TextStyle(fontFamily: 'RB',fontSize: 16,color: Colors.white,letterSpacing: 0.1),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

