class Regesteruser{
  int _Id;
  String _Name;
  String _Email;
  String _Password;

  Regesteruser(this._Name,this._Email,this._Password);
  Regesteruser.withid(this._Id,this._Name,this._Email,this._Password);

  int get id=>_Id;
  String get name=>_Name;
  String get email=>_Email;
  String get password=>_Password;

  set name(String newuser){
    _Name=newuser;
  }
  set email(String newemail){
    _Email=newemail;
  }
  set password(String newpassword){
    _Password=newpassword;
  }

  Map<String,dynamic>tomap(){
    var map=Map<String,dynamic>();
    map["NameUser"]=_Name;
    map["Email"]=_Email;
    map["Password"]=_Password;
    if(_Id!=null){
      map["Id"]=_Id;
    }
    return map;
  }
  Regesteruser.fromObject(dynamic o){
    this._Id=o["Id"];
    this.name=o["NameUser"];
    this.email=o["Email"];
    this.password=o["Password"];
  }
}