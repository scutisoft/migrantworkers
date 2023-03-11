import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
/*import 'package:image_cropper/image_cropper.dart';*/
import 'package:image_picker/image_picker.dart';
import '/HappyExtension/extensionUtils.dart';
import '/api/apiUtils.dart';
import '/utils/constants.dart';
import '/utils/utils.dart';

import '../HappyExtension/extensionHelper.dart';
import '../helper/helper.dart';
import '../helper/language.dart';
import '../utils/colorUtil.dart';
import '../utils/sizeLocal.dart';
import 'validationErrorText.dart';

int imageQuality=50;


class LogoPicker extends StatelessWidget {
  String imageUrl;
  File? imageFile;
  Function(File) onCropped;
  String description;
  String btnTitle;
  bool isEnable;
  LogoPicker({required this.imageUrl,this.imageFile,required this.onCropped,this.description="Upload Your Company Logo",
    this.btnTitle="Choose File",this.isEnable=true});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LogoAvatar(imageUrl: imageUrl, imageFile: imageFile,radius: 100,),
        const SizedBox(height: 20,),
        Align(
          alignment: Alignment.center,
          child: Text(description,
            style: TextStyle(fontFamily: 'RR',fontSize: 14,color: ColorUtil.text1),
          ),
        ),
        const SizedBox(height: 10,),
        Visibility(
          visible: isEnable,
          child: GestureDetector(
            onTap:isEnable?  (){
              getImage(onCropped);
            }:null,
            child:  Align(
              alignment: Alignment.center,
              child: Container(
                width: 150,
                height:45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: ColorUtil.secondary,
                  boxShadow: [
                    BoxShadow(
                      color: ColorUtil.secondary.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(1, 8), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                    child: Text(btnTitle,style: TextStyle(color:Colors.white,fontSize:16,fontFamily: 'RM'),
                    )
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LogoAvatar extends StatelessWidget {
  String imageUrl;
  File? imageFile;
  double radius;
  double height;
  LogoAvatar({Key? key,required this.imageUrl,required this.imageFile,this.radius=100,this.height=100}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: radius,
      decoration: BoxDecoration(
        color: ColorUtil.avatarBorderColor,
        //shape: BoxShape.circle
      ),
      alignment: Alignment.center,
      child: Container(
        height: height-3,
        width: radius-3,
        decoration: BoxDecoration(
          //shape: BoxShape.circle,
            color: Colors.white
        ),
        alignment: Alignment.center,
        clipBehavior: Clip.antiAlias,
        child: imageFile!=null?Image.file(imageFile!,):
        Image.network(imageUrl,
            errorBuilder: (a,b,c){
              return SvgPicture.asset("assets/icons/upload.svg",height: height-30,width: radius-30,fit: BoxFit.cover,color: ColorUtil.secondary,);
            },
            fit: BoxFit.contain,
            height: height-3, width: radius-3
        ),
      ),
    );
  }
}

Future getImage( Function(File) onCropped) async
{
  XFile? temp=await (ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: imageQuality));
  if(temp==null)return;
  File tempImage = File(temp.path);
  onCropped(tempImage);
  //_cropImage(tempImage,onCropped);
}

/*
_cropImage(File picked,Function(File) onCropped) async {
  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: picked.path,
    aspectRatioPresets: [
      CropAspectRatioPreset.square,

    ],
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.red,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          showCropGrid: false,
        hideBottomControls: true
      ),
      IOSUiSettings(
        title: 'Crop Image',
      ),
    ],
    cropStyle: CropStyle.circle,
    maxWidth: 400
  );
  if (croppedFile != null) {
    onCropped(File(croppedFile.path));
  }
  // CroppedFile? cropped = await ImageCropper().cropImage(
  //   uiSettings: AndroidUiSettings(
  //       statusBarColor: Colors.red,
  //       toolbarColor: Colors.red,
  //       toolbarTitle: "Crop Image",
  //       toolbarWidgetColor: Colors.white,
  //       showCropGrid: false,
  //       hideBottomControls: true
  //   ),
  //   sourcePath: picked.path,
  //   aspectRatioPresets: [
  //     CropAspectRatioPreset.square
  //   ],
  //   maxWidth: 400,
  //   cropStyle: CropStyle.circle,
  // );
  // if (cropped != null) {
  //   onCropped(cropped);
  // }
}*/


class SingleImagePicker extends StatelessWidget implements ExtensionCallback{
  bool hasInput;
  bool required;
  String dataname;
  String folder;
  bool enabled;
  String description;
  String btnTitle;
  SingleImagePicker({required this.dataname,this.hasInput=false,this.required=false,required this.folder,this.enabled=true,
    this.description="", this.btnTitle=""});

  Rxn<File> imageFile=Rxn<File>();
  Rxn<String> imageName=Rxn<String>();

  var orderBy=1.obs;
  var isValid=true.obs;
  var errorText="* Required".obs;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() => LogoAvatar(imageUrl: "${GetImageBaseUrl()}$folder/${imageName.value??""}", imageFile: imageFile.value,radius: 100,)),
        const SizedBox(height: 20,),
        Align(
          alignment: Alignment.center,
          child: Text(description.isEmpty?Language.uploadImage:description,
            style: ts14(ColorUtil.text1),
          ),
        ),
        Obx(
                ()=>isValid.value?Container():ValidationErrorText(title: errorText.value,alignment: Alignment.center,leftPadding: 0,)
        ),
        const SizedBox(height: 10,),
        Visibility(
          visible: enabled,
          child: GestureDetector(
            onTap:enabled?  (){
              getImage((file){
                imageFile.value=file;
              });
            }:null,
            child:  Align(
              alignment: Alignment.center,
              child: Container(
                width: 150,
                height:45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: ColorUtil.secondary,
                  boxShadow: [
                    BoxShadow(
                      color: ColorUtil.secondary.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(1, 8), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                    child: Text(btnTitle.isEmpty?Language.chooseFile:btnTitle,
                      style: ts14(Colors.white,),textAlign: TextAlign.center,
                    )
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }

  @override
  void clearValues() {
    imageFile.value=null;
  }

  @override
  String getDataName() {
    return dataname;
  }

  @override
  int getOrderBy() {
    return orderBy.value;
  }

  @override
  String getType() {
    return 'singleImagePicker';
  }

  @override
  getValue() async{
    if(imageFile.value!=null){
      imageName.value=await MyHelper.uploadFile(folder, imageFile.value!);
    }
    return imageName.value;
  }

  @override
  setOrderBy(int oBy) {
    orderBy.value=oBy;
  }

  @override
  setValue(value) {
    imageName.value=value;
  }

  @override
  bool validate() {
    isValid.value=(imageName.value != null && imageName.value!.isNotEmpty) || imageFile.value != null;
    return isValid.value;
  }
}



class MultiImagePicker extends StatelessWidget implements ExtensionCallback{
  bool hasInput;
  bool required;
  String dataname;
  String folder;
  DevelopmentMode developmentMode;
  String imageFileNameKey;
  String imagePathKey;
  MultiImagePicker({required this.dataname,this.hasInput=false,this.required=false,required this.folder,
  this.developmentMode=MyConstants.developmentMode,this.imageFileNameKey="ImageFileName",this.imagePathKey="ImagePath"});

  /*MultiImagePicker({});*/
  RxList<XFile> imageFileList=RxList<XFile>();
  RxList<dynamic> imagesList=RxList<dynamic>();
  double imgWidth=0.0;

  var orderBy=1.obs;
  var isValid=true.obs;
  var errorText="* Required".obs;

  @override
  Widget build(BuildContext context) {
    imgWidth=SizeConfig.screenWidth!-60;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: ()async{
            var _image = await ImagePicker().pickMultiImage(imageQuality: imageQuality);
            if(_image!=null && _image.isNotEmpty){
              imageFileList.addAll(_image);
            }
           // console("imageFileList ${imageFileList.value}");
          },
          child: Container(
            margin: EdgeInsets.only(right: 15,left: 15,top: 10),
            width: SizeConfig.screenWidth,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: ColorUtil.primary),
              color: ColorUtil.primary.withOpacity(0.3),
            ),
            child:Center(child: Text(Language.uploadImage,
              style: ts16(ColorUtil.primary), )
            ) ,
          ),
        ),
        Obx(
                ()=>isValid.value?Container():ValidationErrorText(title: errorText.value,)
        ),
        Obx(() => Container(
          margin: EdgeInsets.only(top: 10),
          child: Wrap(
            runSpacing: 0,
            spacing: 10,
            children: [
              for(int i=0;i<imagesList.length;i++)
                SizedBox(
                  height: 120,
                  width: imgWidth*0.33,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      LogoAvatar(imageUrl: GetImageBaseUrl()+imagesList[i][imagePathKey], imageFile: null,height: 100,radius: (imgWidth*0.33)-20),
                      Positioned(
                          top: 0,
                          right: 0,
                          child:  GestureDetector(
                            onTap: (){
                              imagesList.removeAt(i);
                            },
                            child: Container(
                                height: 25,
                                width: 25 ,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle
                                ),
                                child: Center(
                                  child: Icon(Icons.remove,color: Colors.white,size: 20,),
                                )
                            ),
                          )
                      )
                    ],
                  ),
                ),
              for(int i=0;i<imageFileList.length;i++)
                 SizedBox(
                    height: 120,
                    width: imgWidth*0.33,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        LogoAvatar(imageUrl: "", imageFile: File(imageFileList[i].path),height: 100,radius: (imgWidth*0.33)-20),
                        Positioned(
                            top: 0,
                            right: 0,
                            child:  GestureDetector(
                              onTap: (){
                                imageFileList.removeAt(i);
                              },
                              child: Container(
                                  height: 25,
                                  width: 25 ,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle
                                  ),
                                  child: Center(
                                    child: Icon(Icons.remove,color: Colors.white,size: 20,),
                                  )
                              ),
                            )
                        )
                      ],
                    ),
                  ),
            ],
          ),
        ))
      ],
    );
  }

  @override
  void clearValues() {
    imageFileList.clear();
  }

  @override
  String getDataName() {
    return dataname;
  }

  @override
  int getOrderBy() {
    return orderBy.value;
  }

  @override
  String getType() {
    return "multiImage";
  }

  @override
  getValue() async{
    List<dynamic> images=[];
    if(imageFileList.isNotEmpty){
      String files=await MyHelper.uploadMultiFile(folder, imageFileList.value);
      files.split(",").forEach((element) {
        images.add({"FolderName":folder,imageFileNameKey:element,imagePathKey:"$folder/$element"});
      });
    }
    if(imagesList.isNotEmpty){
      images.addAll(imagesList);
    }
    return developmentMode==DevelopmentMode.json?images:jsonEncode(images);
  }

  @override
  setOrderBy(int oBy) {
    orderBy.value=oBy;
  }

  @override
  setValue(value) {
    //console("mutiImageSset $value ${HE_IsList(value)}");
    if(HE_IsList(value)){
      imagesList.value=value;
    }
  }

  @override
  bool validate() {
    isValid.value=imageFileList.isNotEmpty || imagesList.isNotEmpty;
    return isValid.value;
  }
}
