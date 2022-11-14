import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:test2/Model/regesterModel.dart';
import 'package:test2/Model/storemodel.dart';

import 'Categorymodel.dart';
import 'ittemmodel.dart';
class APISERVER{
  static String urlapi="http://192.168.43.151:62311/api/";

   static Future getusers(String action)async{
     return await http.get(urlapi+action);
   }
  static Map<String,String>header={
    'Content-type':'application/json',
    'Accept':'application/json'
  };
  static Future<bool>postuser(Regesteruser regester,String action)async{
     var myuser=regester.tomap();
     var userbody=json.encode(myuser);
     var result=await http.post(urlapi+action,headers: header,body:userbody);
     return  Future.value(result.statusCode==200||result.statusCode==201?true:false);

  }

  static Future<bool>postItem(ItemsModel item,String action)async{
    var myitem=item.tomap();
    var userbody=json.encode(myitem);
    var result=await http.post(urlapi+action,headers: header,body:userbody);
    return  Future.value(result.statusCode==200||result.statusCode==201?true:false);

  }
  static Future<bool>poststore(StoreModel store,String action)async{
    var mystore=store.tomap();
    var userbody=json.encode(mystore);
    var result=await http.post(urlapi+action,headers: header,body:userbody);
    return  Future.value(result.statusCode==200||result.statusCode==201?true:false);

  }

  static Future<bool>postcategory(Categories categore,String action)async{
    var mycategore=categore.tomap();
    var userbody=json.encode(mycategore);
    var result=await http.post(urlapi+action,headers: header,body:userbody);
    return  Future.value(result.statusCode==200||result.statusCode==201?true:false);

  }


  static Future chekuser(String username,String password)async{
    var s= await http.get(urlapi+"Users?nameuser=$username&password=$password");
    return s;
  }

  static Future<bool>Deleteitem(String action,int id)async{
    var result=await http.delete(urlapi+action+"/"+id.toString(),headers: header);
    return  Future.value(result.statusCode==200||result.statusCode==201?true:false);
  }

  static Future<bool>Updateitem(ItemsModel item,String action,int id)async{
    var Myitem=item.tomap();
    var userbody=json.encode(Myitem);
    var result=await http.put(urlapi+action+"/"+id.toString(),headers: header,body: userbody);
    return  Future.value(result.statusCode>=200||result.statusCode<=300?true:false);
  }
  static Future<bool>Updatestore(StoreModel store,String action,int id)async{
    var Mystore=store.tomap();
    var userbody=json.encode(Mystore);
    var result=await http.put(urlapi+action+"/"+id.toString(),headers: header,body: userbody);
    return  Future.value(result.statusCode>=200||result.statusCode<=300?true:false);
  }
  static Future<bool>Updatcategory(Categories categore,String action,int id)async{
    var Mycategore=categore.tomap();
    var userbody=json.encode(Mycategore);
    var result=await http.put(urlapi+action+"/"+id.toString(),headers: header,body: userbody);
    return  Future.value(result.statusCode>=200||result.statusCode<=300?true:false);
  }


}