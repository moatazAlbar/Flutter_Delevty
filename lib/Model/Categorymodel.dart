class Categories{
   int _Id;
   String _Nameprodect;
   int _typeprodect;
   int _Price;
   String _Descripe;
   int _storeid;
   String _image;


  Categories(this._Nameprodect,this._typeprodect, this._Price,this._Descripe,this._storeid,this._image,);
  Categories.withid(this._Id,this._Nameprodect,this._typeprodect, this._Price,this._Descripe,this._storeid,this._image,);

   int get id=>_Id;
   String get Nameprodect=>_Nameprodect;
   int get typeprodect=>_typeprodect;
   int get Price=>_Price;
   String get Descripe=>_Descripe;
   int get storeid=>_storeid;
   String get image=>_image;

   set Nameprodect(String newname){
     _Nameprodect=newname;
   }
   set typeprodect(int newtype){
     _typeprodect=newtype;
   }
   set Price(int newprice){
     _Price=newprice;
   }
   set Descripe(String newdescripe){
     _Descripe=newdescripe;
   }
   set storeid(int newatoreid){
     _storeid=newatoreid;
   }
   set image(String newimage){
     _image=newimage;
   }

   Map<String,dynamic>tomap(){
     var map=Map<String,dynamic>();
     map["Nameprodect"]=_Nameprodect;
     map["typeprodect"]=_typeprodect;
     map["Price"]=_Price;
     map["Descripe"]=_Descripe;
     map["storeid"]=_storeid;
     map["image"]=_image;
     if(_Id!=null){
       map["Id"]=_Id;
     }
     return map;
   }

   Categories.fromObject(dynamic o){
     this._Id=o["Id"];
     this._Nameprodect=o["Nameprodect"];
     this._typeprodect=o["typeprodect"];
     this._Price=o["Price"];
     this._Descripe=o["Descripe"];
     this._storeid=o["storeid"];
     this._image=o["image"];
   }
}