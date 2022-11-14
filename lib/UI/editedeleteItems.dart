import 'package:flutter/material.dart';
import 'package:test2/Model/SQLSERVERAPI.dart';
import 'package:test2/Model/ittemmodel.dart';

import 'favoritescreen.dart';

class EditeDeleteItem extends StatefulWidget {
  final ItemsModel _itemsModel;
  const EditeDeleteItem(this._itemsModel);

  @override
  _EditeDeleteItemState createState() => _EditeDeleteItemState(_itemsModel);
}

class _EditeDeleteItemState extends State<EditeDeleteItem> {
  final ItemsModel _itemsMod;
  _EditeDeleteItemState(this._itemsMod);
  TextEditingController NameItems = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    NameItems.text=_itemsMod.name;
    return Scaffold(
        appBar: AppBar(
            title: Text("delete or edite: "+_itemsMod.name),
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
        Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.all(20),
                    child: textfiled(
                        Icons.drive_file_rename_outline, "Write the name of Item",
                        "Name Item", NameItems)),
                 Column(
                    children: [
                      Container(
                        width: 170,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        margin: EdgeInsets.all(10),
                        child: MaterialButton(
                          onPressed:(){
                            updateeuser(_itemsMod.id);
                            Navigator.pop(context);
                          },
                          child: Text("Edite",
                            style: TextStyle(color: Colors.white, fontSize: 20,),
                          ),

                        ),
                      ),
                      Container(
                        width: 170,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: MaterialButton(
                          onPressed: (){
                            delete(_itemsMod.id);
                            Navigator.pop(context);
                          },
                          child: Text("Delete",
                            style: TextStyle(color: Colors.white, fontSize: 20,),
                          ),

                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        )
    );
  }
  Future<bool> delete(int id)async{
    var SaveRespone=await APISERVER.Deleteitem("Items",id);
    return SaveRespone;
  }
  Future<bool> updateeuser(int id)async{
    var SaveRespone=await APISERVER.Updateitem(_itemsMod,"Items",id);
    return SaveRespone;
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
}
