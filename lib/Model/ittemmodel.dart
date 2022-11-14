class ItemsModel{
  int _Id;
  String _NameItem;

  ItemsModel(this._NameItem);
  ItemsModel.withid(this._Id,this._NameItem);

  int get id=>_Id;
  String get name=>_NameItem;

  set name(String newuser){
    _NameItem=newuser;
  }

  Map<String,dynamic>tomap(){
    var map=Map<String,dynamic>();
    map["NameItem"]=_NameItem;
    if(_Id!=null){
      map["Id"]=_Id;
    }
    return map;
  }
  ItemsModel.fromObject(dynamic o){
    this._Id=o["Id"];
    this.name=o["NameItem"];
  }
}