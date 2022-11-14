class StoreModel{
  int _Id;
  String _NameStore;
  String _Descripe;
  String _Picure;

  StoreModel(this._NameStore,this._Descripe,this._Picure);
  StoreModel.withid(this._Id,this._NameStore,this._Descripe,this._Picure);

  int get id=>_Id;
  String get name=>_NameStore;
  String get descripe=>_Descripe;
  String get picure=>_Picure;

  set name(String newuser){
    _NameStore=newuser;
  }
  set descripe(String newdes){
    _Descripe=newdes;
  }
  set picure(String newpic){
    _Picure=newpic;
  }
  Map<String,dynamic>tomap(){
    var map=Map<String,dynamic>();
    map["NameStore"]=_NameStore;
    map["Descripe"]=_Descripe;
    map["Picure"]=_Picure;
    if(_Id!=null){
      map["Id"]=_Id;
    }
    return map;
  }
  StoreModel.fromObject(dynamic o){
    this._Id=o["Id"];
    this.name=o["NameStore"];
    this.descripe=o["Descripe"];
    this.picure=o["Picure"];
  }
}