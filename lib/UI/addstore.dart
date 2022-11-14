import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test2/Model/SQLSERVERAPI.dart';
import 'package:test2/Model/storemodel.dart';
import 'allstores.dart';
import 'favoritescreen.dart';

class AddStore extends StatefulWidget {
  final StoreModel _storeModel;
  const AddStore(this._storeModel);

  @override
  _AddStoreState createState() => _AddStoreState(_storeModel);
}


class _AddStoreState extends State<AddStore> {
  StoreModel _storeMod;
  _AddStoreState(this._storeMod);
  TextEditingController NameStore = new TextEditingController();
  TextEditingController descripeStore = new TextEditingController();
  List<StoreModel> Stores=new List<StoreModel>();
  File image;
  String imageincode;
  @override
  void initState() {
    print(_storeMod.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    NameStore.text=_storeMod.name;
    descripeStore.text=_storeMod.descripe;
    _storeMod.picure.length>3?imageincode=_storeMod.picure:imageincode=null;
    return Scaffold(
        appBar: AppBar(
            title: Text("Add new Store"),
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
        SingleChildScrollView(
          child: Container(
            child:addItems(NameStore)
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
                  "Name", NameItem)),
          Container(child: textfiled(
                  Icons.drive_file_rename_outline, "Descripe the store",
                  "Descripe", descripeStore)),
          Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.all(20),
                  width: 190,
                  height: 30,
                  child: MaterialButton(
                    onPressed: _pickerIamge,
                    child: Row(
                      children: [
                        Icon(Icons.image,color: Colors.white,),
                        SizedBox(width: 10,),
                        Text("Chose image",
                          style: TextStyle(color: Colors.white, fontSize: 20,),
                        ),
                      ],
                    ),

                  ),
                ),
         showimage(),
          showbutton()
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
        onChanged:(val)=> changetext(_lable)
      ),
    );
  }
  changetext(String lab){
    if(lab=="Name"){
      setState(() {
        _storeMod.name=NameStore.text;
      });
    }
    if(lab=="Descripe"){
      setState(() {
        _storeMod.descripe=descripeStore.text;
      });
    }
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

  Future<bool> addstore()async{
    var SaveRespone=await APISERVER.poststore(_storeMod,"Stores");
    return  SaveRespone;
  }
  Future<bool> delete(int id)async{
    var SaveRespone=await APISERVER.Deleteitem("Stores",id);
    return SaveRespone;
  }
  Future<bool> updateeuser(int id)async{
    var SaveRespone=await APISERVER.Updatestore(_storeMod,"Stores",id);
    return SaveRespone;
  }
  Future _pickerIamge()async{
    final imagefile=await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      image=File(imagefile.path);
      Convertimage(image);
    });
  }
  Future Convertimage(File image)async{
    Uint8List imagebyte=await image.readAsBytes();
    String base64string=base64.encode(imagebyte);
    setState(() {
      imageincode=base64string;
      _storeMod.picure=imageincode;
    });
  }
   Widget showbutton(){
  return  _storeMod.id==null?
    Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.all(20),
      width: 250,
      height: 60,
      child: MaterialButton(
        onPressed:(){
          addstore;
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AllStores()));
        } ,
        child: Text("Add",
          style: TextStyle(color: Colors.white, fontSize: 20,),
        ),

      ),
    ):Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.all(20),
          width: 250,
          height: 60,
          child: MaterialButton(
            onPressed:(){
              updateeuser(_storeMod.id);
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllStores()));
            } ,
            child: Text("Edite",
              style: TextStyle(color: Colors.white, fontSize: 20,),
            ),

          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.all(20),
          width: 250,
          height: 60,
          child: MaterialButton(
            onPressed: (){
               delete(_storeMod.id);
               Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => AllStores()));
               },
            child: Text("Delete",
              style: TextStyle(color: Colors.white, fontSize: 20,),
            ),

          ),
        ),
      ],
    );
  }
  Widget showimage(){
    if(image==null){
      if(imageincode!=null){
       return Container(
            height: 200,
            margin: EdgeInsets.all(10),
            child: Image.memory(base64Decode(imageincode)));
      }
      else{
        return Text("");
      }
    }
    else{
      return Container(
        height: 200,
        margin: EdgeInsets.all(10),
        child:Image.file(image)
      );
    }
  }
}
