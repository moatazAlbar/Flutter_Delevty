import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test2/Model/SQLSERVERAPI.dart';
import 'package:test2/Model/ittemmodel.dart';
import 'package:test2/pages/interfacepage/foodcategory.dart';

import 'editedeleteItems.dart';
import 'favoritescreen.dart';

class AddItems extends StatefulWidget {
  final ItemsModel _itemsModel;
  const AddItems(this._itemsModel);

  @override
  _AddItemsState createState() => _AddItemsState(_itemsModel);
}

class _AddItemsState extends State<AddItems> {
  ItemsModel _itemsMod;
  _AddItemsState(this._itemsMod);
  TextEditingController NameItems = new TextEditingController();
  List<ItemsModel> items=new List<ItemsModel>();
  @override
  Widget build(BuildContext context) {
getallitems();
    return Scaffold(
        appBar: AppBar(
            title: Text("Add new Items"),
            centerTitle: true,
            leading: IconButton(
              onPressed: () =>
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Favorite())),
              icon: Icon(Icons.shopping_bag_outlined),
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () =>
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Favorite())),
                      icon: Icon(Icons.favorite),
                    ),
                    Icon(Icons.home)
                  ],
                ),
              )
            ]),
        body:
        Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
            child: ListView(
              children: <Widget>[
                addItems(NameItems),
                SizedBox(height: 5.0),
                showitems(),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        )
    );
  }
  Widget addItems(TextEditingController NameItem){
    return Center(
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.all(20),
              child: textfiled(
                  Icons.drive_file_rename_outline, "Write the name of Item",
                  "Name Item", NameItem)),
          Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.all(20),
            width: 250,
            height: 60,
            child: MaterialButton(
              onPressed: () {
                additems();
              },
              child: Text("Add",
                style: TextStyle(color: Colors.white, fontSize: 20,),
              ),

            ),
          ),
        ],
      ),
    );
  }
  Widget textfiled(IconData _icon, String _hinttext, String _lable,
      TextEditingController _controlle) {
    return Container(
      padding: EdgeInsets.all(12),
      child: TextField(
        textCapitalization: TextCapitalization.words,

        decoration: InputDecoration(

          border: UnderlineInputBorder(),
          icon: Icon(_icon,),
          hintText: _hinttext,


          labelText: _lable,

        ),
        controller: _controlle,
        onChanged:(val)=> {
        setState(() {
        _itemsMod.name=NameItems.text;
        })
        },
      ),
    );
  }
  changetext(){

  }
  showdilg(String username) {
    showDialog(

        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text("DONE ADD" + username),
              content: Text("done to add new item  " + username),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.done_outline),
                      Text("OK")
                    ],
                  ),
                ),

              ],

            )


    );
  }

  Widget showitems(){
    return Container(
      child: ListView.builder(
        primary: false,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount:items == null ? 0 : items.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            margin: EdgeInsets.only(bottom: 10),

            child: InkWell(
              child: ListTile(
                onTap: ()=>Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>EditeDeleteItem(ItemsModel.withid(items[index].id,items[index].name)),
                  ),),
                title: Text(items[index].name,),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
          );
        },
      ),
    );
  }
  Future<bool> additems()async{
    var SaveRespone=await APISERVER.postItem(_itemsMod,"Items");
    return  SaveRespone;
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
