import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test2/Model/SQLSERVERAPI.dart';
import 'package:test2/Model/regesterModel.dart';

import 'Register.dart';
import 'UserInterface.dart';

class login extends StatefulWidget {
  const login() ;


  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  var load=false;
  var rong="";
  TextEditingController UserName=new TextEditingController();
  TextEditingController Password=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    nav();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 40),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(

                  child: Image.asset("Images/Icon.png",height: 150,width: 200,)),
              Container(

                child: textfiled(Icons.person, "Write the user name", "User", UserName),
              ),
              Container(
                child: textfiled(Icons.admin_panel_settings, "Write the Password", "Password", Password),
              ),
              Container(
                margin: EdgeInsets.all(20),
                width: 250,
                height: 60,
                child: MaterialButton(
                  onPressed: checklogin,
                  child: Text("Sing in",style: TextStyle(color: Colors.white)),
                  color: Colors.red,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child:load==false? Text("$rong",):CircularProgressIndicator()),
              Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child:load==false? Text("Or sing in with:",):CircularProgressIndicator()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Image.asset("Images/facebook.jpg",height: 35,width: 40,),
                  SizedBox(width: 20,),
                  Image.asset("Images/tweter.jpg",height: 40,width: 40,)
                ],
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Dont have account",),
                      TextButton(onPressed:  ()=> Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>register(Regesteruser("","","")),
                        ),)
                          , child: Text("Sing up",style: TextStyle(color: Colors.red),))
                    ],
                  )),
            ],
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

        ),
        controller: _controlle,

      ),
    );
  }
  checklogin(){
    APISERVER.chekuser(UserName.text,Password.text).then((result){
      var list=json.decode(result.body);
      setState(() {
        list=="succesess"?load=true:rong="Faiulre";
      });
    });
  }

  Future nav()async{
    await load==true?Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=>Interface(),
      ),):null;

}
}
