import '../HappyExtension/extensionUtils.dart';
import '../model/parameterMode.dart';

getFrmCollection(Map widgets) async{

  //parameterList.add(ParameterModel(Key: element.labelText, Type: 'string', Value: element.getValue()));


  List<ParameterModel> parameterList=[];
  //List<ParameterModel> temp=await getParameterEssential();
  //parameterList.addAll(temp);

  widgets.forEach((key, widget) {
      String elementType="";
      try{
        elementType=widget.getType();
      }catch(e){}

      if(elementType=='inputTextField'){
        if(widget.hasInput??false){
          if(widget.required??false){
            if(widget.validate()){
              parameterList.add(ParameterModel(Key: key, Type: 'string', Value: widget.getValue()));
            }
          }
          else{
            parameterList.add(ParameterModel(Key: key, Type: 'string', Value: widget.getValue()));
          }
        }
      }
      if(elementType=='searchDrp'){
        if(widget.hasInput??false){
          if(widget.required??false){
            if(widget.typeAheadSearchState.validate()){
              parameterList.add(ParameterModel(Key: key, Type: 'string', Value: widget.typeAheadSearchState.getValue()));
            }
          }
          else{
            parameterList.add(ParameterModel(Key: key, Type: 'string', Value: widget.typeAheadSearchState.getValue()));
          }
        }
      }
      if(elementType=='hidden'){
        if(widget.hasInput??false){
          parameterList.add(ParameterModel(Key: key, Type: 'string', Value: widget.getValue()));
        }
      }

  });
  return parameterList;
}
Future<List<ParameterModel>> getFrmCollectionV2(List widgets) async{

  //parameterList.add(ParameterModel(Key: element.labelText, Type: 'string', Value: element.getValue()));


  List<ParameterModel> parameterList=[];
  //List<ParameterModel> temp=await getParameterEssential();
  //parameterList.addAll(temp);

  widgets.forEach((widget) {
      String elementType="";
      try{
        elementType=widget.getType();
      }catch(e){}

      if(elementType=='inputTextField'){
        if(widget.hasInput??false){
          if(widget.required??false){
            if(widget.validate()){
              parameterList.add(ParameterModel(Key: widget.getDataName(), Type: 'string', Value: widget.getValue()));
            }
          }
          else{
            parameterList.add(ParameterModel(Key: widget.getDataName(), Type: 'string', Value: widget.getValue()));
          }
        }
      }
      if(elementType=='searchDrp'){
        if(widget.hasInput??false){
          if(widget.required??false){
            if(widget.validate()){
              parameterList.add(ParameterModel(Key: widget.getDataName(), Type: 'string', Value: widget.getValue()));
            }
          }
          else{
            parameterList.add(ParameterModel(Key: widget.getDataName(), Type: 'string', Value: widget.getValue()));
          }
        }
      }
      if(elementType=='hidden'){
        if(widget.hasInput??false){
          parameterList.add(ParameterModel(Key: widget.getDataName(), Type: 'string', Value: widget.getValue()));
        }
      }

  });
  return parameterList;
}

setFrmValues(Map widgets,List response){
  /* response
  [{AgencyId: 5, AgencyName: Radiant E Serve, ServiceCenterName: Mi Authorized Service Center, AgencyAddress: No.5,West Perumaln Maistry St, Chennai Silks Road,Opp to Canara ATM, Madurai-625001, Tamil Nadu, AgencyCity: Madurai, AgencyPinCode: 625001, AgencyContactNumber: 9994630000, AgencyGSTNumber: 33ACIFS5122M2ZY, AgencyStateName: Tamil Nadu, AgencyEmail: vivekmurugan@scutisoft.in}]
   */
  if(response!=null){
    if(response.isNotEmpty){
      for(int i=0;i<response.length;i++){
       // print(response[i]);
        for (MapEntry e in response[i].entries) {
          var widget=widgets[e.key];
          if(widget!=null){
            String widgetType="";
            try{
              widgetType=widget.getType();
            }catch(e){}

            if(widgetType=='hidden'){
              widget.setValue(e.value??"");
            }
            else if(widgetType=='inputTextField'){
              widget.setValue(e.value.toString());
            }
            else if(widgetType=='searchDrp'){
              widget.setValues({"Id",e.value});
            }
          }
        }
      }
    }
  }
}
setFrmValuesV2(List widgets,List response){
  /* response
  [{AgencyId: 5, AgencyName: Radiant E Serve, ServiceCenterName: Mi Authorized Service Center, AgencyAddress: No.5,West Perumaln Maistry St, Chennai Silks Road,Opp to Canara ATM, Madurai-625001, Tamil Nadu, AgencyCity: Madurai, AgencyPinCode: 625001, AgencyContactNumber: 9994630000, AgencyGSTNumber: 33ACIFS5122M2ZY, AgencyStateName: Tamil Nadu, AgencyEmail: vivekmurugan@scutisoft.in}]
   */
  //log("${widgets.length} $response");
  if(response!=null){
    if(response.isNotEmpty){
      for(int i=0;i<response.length;i++){

        response[i].forEach((key,value){
          //log("Key $key $value");
          var widget=null;
          var foundWid=widgets.where((x) => x.getDataName()==key).toList();
          if(foundWid.length==1){
            widget=foundWid[0];
          }
          if(widget!=null){
            String widgetType="";
            try{
              widgetType=widget.getType();
            }catch(e){}

            if(widgetType=='hidden'){
              widget.setValue(value??"");
            }
            else if(widgetType=='inputTextField'){
              widget.setValue(value.toString());
            }
            else if(widgetType=='searchDrp'){
              widget.setValues({"Id":value});
            }
          }
        });

        /*for (MapEntry e in response[i].entries) {

        }*/
      }
    }
  }
}
