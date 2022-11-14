import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test2/Model/Categorymodel.dart';
import 'package:test2/Model/SQLSERVERAPI.dart';
import 'package:test2/Model/ittemmodel.dart';
import 'package:test2/Model/storemodel.dart';
import 'package:test2/pages/interfacepage/foodcategory.dart';

import 'addCategory.dart';
import 'itemcategory.dart';

class AllCategory extends StatefulWidget {
  const AllCategory() ;

  @override
  _AllCategoryState createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {
  List<Categories> Category=new List<Categories>();
  List<StoreModel> Stores=new List<StoreModel>();
  List<ItemsModel> items=new List<ItemsModel>();
  @override
  void initState() {
    getallCategorys();
    getallstores();
    getallitems();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: RefreshIndicator(
            onRefresh: getallCategorys,
            child: ListView(
              children: <Widget>[
                SizedBox(height: 5.0),
                itemscategory(),
                SizedBox(height: 10.0),
                showStores(),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      )
    );
  }
  showStores(){
    return Category.length>0? ListView.builder(
            shrinkWrap: true,
            primary: false,
            scrollDirection: Axis.vertical,
            itemCount:Category.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Container(
                      child: Container(
                        height: 350,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20),),
                                  image:DecorationImage(
                                      image:Category[index].image.length>5? MemoryImage(base64Decode(Category[index].image)):AssetImage("Images/store.png"),
                                      fit: BoxFit.fill
                                  )
                              ),
                            ),
                            ListTile(
                              title: Text(Category[index].Nameprodect,style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),),
                              subtitle:Text(Category[index].Descripe),
                              trailing: Text("${Category[index].Price}\$",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                              ),),
                            ),
                            ListTile(
                              title:getnamestore(Category[index].storeid),
                              subtitle:Text("Shop"),
                              leading:CircleAvatar(
                                backgroundImage: AssetImage("Images/resturant/r7.webp"),
                              ),
                              trailing: IconButton(icon: Icon(Icons.favorite_border),onPressed: (){},),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ):Center(child: CircularProgressIndicator());
  }
  Future getallCategorys(){
    return APISERVER.getusers("Prodects").then((res){
      Iterable list=json.decode(res.body);
      List<Categories>joblist=List<Categories>();
      joblist=list.map((model) => Categories.fromObject(model)).toList();
      setState(() {
        Category=joblist;
      });
    });
  }
  Future getallstores(){
    return APISERVER.getusers("Stores").then((res){
      Iterable list=json.decode(res.body);
      List<StoreModel>joblist=List<StoreModel>();
      joblist=list.map((model) => StoreModel.fromObject(model)).toList();
      setState(() {
        Stores=joblist;
      });
    });
  }
 Widget getnamestore(int idstore){
   return Text(Stores[idstore].name);
  }
  Widget showitems(){
    return Container(
      width: 50,
      child: ListView.builder(
        primary: false,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount:items == null ? 0 : items.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 30,
            margin: EdgeInsets.only(top:12,right: 12),

            child: Container(
              color: Colors.white,
              height: 30,

                child: Text("${items[index].name}")),
          );
        },
      ),
    );
  }
  getallitems(){

    APISERVER.getusers("Items").then((res){
      Iterable list=json.decode(res.body);
      List<ItemsModel>joblist=List<ItemsModel>();
      joblist=list.map((model) => ItemsModel.fromObject(model)).toList();
      setState(() {
        items=joblist;
      });
    });
  }
}
