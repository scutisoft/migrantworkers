
class ParameterModel{
  String Key;
  String Type;
  dynamic Value;
  int orderBy;
  ParameterModel({required this.Key, required this.Type,required this.Value,this.orderBy=1});

/*  factory ParameterModel.fromJson(Map<String,dynamic> json){
    return ParameterModel(
      MaterialCategoryId: json['MaterialCategoryId'],
      MaterialCategoryName: json['MaterialCategoryName'],
    );
  }*/

  Map<String, dynamic> toJson() => {
    "Key": Key,
    "Type": Type,
    "Value": Value,
    "OrderBy": orderBy,
  };
  Map<String, dynamic> toJsonHE() => {
    "key": Key,
    "value": Value,
  };
  dynamic get(String propertyName) {
    var _mapRep = toJson();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('property not found');
  }
}