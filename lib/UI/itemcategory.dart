import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test2/Model/SQLSERVERAPI.dart';
import 'package:test2/Model/ittemmodel.dart';

class itemscategory extends StatefulWidget {
  const itemscategory() ;


  @override
  _itemscategoryState createState() => _itemscategoryState();
}
class _itemscategoryState extends State<itemscategory> {
  List<ItemsModel> items=new List<ItemsModel>();

  @override
  void initState() {
   getallitems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ListView.builder(
        primary: false,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount:items == null ? 0 : items.length,
        itemBuilder: (BuildContext context, int index) {


          return Container(

            margin: EdgeInsets.only(top:12,right: 12),

            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),
                padding: EdgeInsets.all(6),

                child: Text("${items[index].name}"),height: 40,),
              onTap:()=>print(items[index].id),
            )
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