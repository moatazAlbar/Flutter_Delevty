import 'package:flutter/material.dart';
import 'package:test2/Model/SQLSERVERAPI.dart';
import 'package:test2/Model/regesterModel.dart';
import 'package:test2/UI/Login.dart';

import 'UserInterface.dart';

class register extends StatefulWidget {
  final Regesteruser reqster;
  register(this.reqster) ;

  @override
  _registerState createState() => _registerState(reqster);
}

class _registerState extends State<register> {
   Regesteruser req;
  _registerState(this.req);
  TextEditingController UserName=new TextEditingController();
  TextEditingController Emailuser=new TextEditingController();
  TextEditingController Passworduser=new TextEditingController();
  TextEditingController ConPassworduser=new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 40),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(

                  child: Image.asset("Images/Icon.png",height: 150,width: 200,)),
              Container(

                child: textfiled(Icons.person, "Write the user name", "Name", UserName),
              ),
              Container(
                child: textfiled(Icons.email, "Write the Email", "Email", Emailuser),
              ),
              Container(
                child: textfiled(Icons.admin_panel_settings, "Write the Password", "Password", Passworduser),
              ),
              Container(

                child: textfiled(Icons.person, "Write the user Confirm Passsword", "ConfPassword", ConPassworduser),
              ),

              Container(
                margin: EdgeInsets.all(20),
                width: 250,
                height: 60,
                child: MaterialButton(
                  onPressed:saveuser,
                  child: Text("Sing up",style: TextStyle(color: Colors.white)),
                  color: Colors.red,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text("Or sing in with:",)),
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
                      Text("have account",),
                      TextButton(onPressed:  ()=> Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>login(),
                        ),), child: Text("Sing in",style: TextStyle(color: Colors.red),))
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> saveuser()async{
     var SaveRespone=await APISERVER.postuser(req,"Users");
     return  SaveRespone;
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
        onChanged: (val)=>updatecontroller(_lable),
      ),
    );
  }
  void updatecontroller(String tx){
    if(tx=="Name"){
      req.name=UserName.text;
      print(req.name);
    }
    if(tx=="Email"){req.email=Emailuser.text;}
    if(tx=="Password"){req.password=Passworduser.text;}
  }

}
