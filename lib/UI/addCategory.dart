import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test2/Model/Categorymodel.dart';
import 'package:test2/Model/SQLSERVERAPI.dart';
import 'package:test2/Model/ittemmodel.dart';
import 'package:test2/Model/storemodel.dart';

import 'allstores.dart';

class AddCategory extends StatefulWidget {
  Categories _categories;
  AddCategory(this._categories);

  @override
  _AddCategoryState createState() => _AddCategoryState(_categories);
}

class _AddCategoryState extends State<AddCategory> {

  Categories _categore;
  _AddCategoryState(this._categore);
  TextEditingController Name=new TextEditingController();
  TextEditingController Price=new TextEditingController();
  TextEditingController Descripe=new TextEditingController();
  static  List<String> menuItem=<String>[];
  String _btn2SelectedVal;
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  File image;
  String imageincode;
  @override
  void initState() {

    intmenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          
          child: Container(
            margin: EdgeInsets.only(top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    icon: Icon(Icons.close_outlined),
                    onPressed:()=>Navigator.pop(context)),
                Container(
                    margin: EdgeInsets.all(10),
                    child: Text("Add New Category",style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 30,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 8.0,
                          color: Colors.black,
                          offset: Offset(1.0, 2.0),
                        ),
                      ],
                    ),)),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: EdgeInsets.only(top: 40),
                  padding: EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      textfiled(Icons.drive_file_rename_outline, "Write the name Category", "Name", Name),
                      ListTile(
                        title: const Text('Type Category:'),
                        trailing: DropdownButton(
                          value: _btn2SelectedVal,
                          hint: const Text('Choose'),
                          onChanged: (String newValue) {
                            setState(() {
                              _btn2SelectedVal = newValue;
                              menuitem(_btn2SelectedVal);
                            });
                          },
                          items: _dropDownMenuItems,
                        ),
                      ),
                      textfiled(Icons.monetization_on_outlined, "Write the price Category", "Price", Price),
                      textfiled(Icons.description, "Write the description of Category", "Descripe", Descripe),
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

                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget textfiled(IconData _icon,String _hinttext,String _lable,TextEditingController _controlle){
    return Container(
      padding: EdgeInsets.all(12),
      child: TextField(
        textCapitalization: TextCapitalization.words,

        decoration: InputDecoration(

          border: UnderlineInputBorder(),
          icon: Icon(_icon,),
          hintText: _hinttext,


          labelText: _lable,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold
          )

        ),
        controller: _controlle,
        onChanged: (val)=>changetext(_lable),
      ),
    );
  }
  changetext(String lab){
    if(lab=="Name"){
      setState(() {
        _categore.Nameprodect=Name.text;
      });
    }
    if(lab=="Descripe"){
      setState(() {
        _categore.Descripe=Descripe.text;
      });
    }
    if(lab=="Price"){
      setState(() {
        _categore.Price=int.parse(Price.text);
      });
    }
  }
  intmenu(){
    APISERVER.getusers("Items").then((res){
      Iterable list=json.decode(res.body);
      List<ItemsModel>joblist=List<ItemsModel>();
      joblist=list.map((model) => ItemsModel.fromObject(model)).toList();
      setState(() {
        for(int i=0;i<joblist.length;i++){
          menuItem.add(joblist[i].name);
        }
        _dropDownMenuItems= menuItem
            .map(
              (String value) => DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          ),
        )
            .toList();

      });
    });
  }
  menuitem(String Name){
    APISERVER.getusers("Items").then((res){
      Iterable list=json.decode(res.body);
      List<ItemsModel>joblist=List<ItemsModel>();
      joblist=list.map((model) => ItemsModel.fromObject(model)).where((mod)=>
        mod.name==Name
      ).toList();
      setState(() {
        _categore.typeprodect=joblist[0].id;
      });
    });
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
      _categore.image=imageincode;
    });
  }
  Widget showimage(){
    if(image==null){
      if(imageincode!=null){
        return Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
           shape: BoxShape.circle,
            image: DecorationImage(
              image:MemoryImage(base64Decode(imageincode)),
              fit: BoxFit.cover
            )
          ));
      }
      else{
        return Text("");
      }
    }
    else{
      return Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  image:MemoryImage(base64Decode(imageincode)),
                  fit: BoxFit.cover
              )
          ));
    }
  }

  Widget showbutton(){
    return  _categore.id==null?
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
          addCategory();
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
  Future<bool> addCategory()async{
    var SaveRespone=await APISERVER.postcategory(_categore,"Prodects");
    return  SaveRespone;
  }
  Future<bool> delete(int id)async{
    var SaveRespone=await APISERVER.Deleteitem("Prodects",id);
    return SaveRespone;
  }
  Future<bool> updateeuser(int id)async{
    var SaveRespone=await APISERVER.Updatcategory(_categore,"Prodects",id);
    return SaveRespone;
  }
}
