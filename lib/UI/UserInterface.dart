import 'package:flutter/material.dart';
import 'package:test2/pages/interfacepage/foodcard.dart';
import 'package:test2/pages/interfacepage/foodcategory.dart';
import 'package:test2/pages/interfacepage/top.dart';

import 'favoritescreen.dart';
class Interface extends StatefulWidget {
  const Interface() ;

  @override
  _interfaceState createState() => _interfaceState();
}

class _interfaceState extends State<Interface> {
  List imag=["images/food1.jpeg","images/food2.jpeg","images/food3.jpeg","images/food4.jpeg","images/food5.jpeg"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Row(
              children: [
                IconButton(
                  onPressed: ()=> Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>Favorite())),
                  icon: Icon(Icons.favorite),
                ),
                Icon(Icons.home)
              ],
            ),
          )
        ],

        title: Text("Inter Face"),
        centerTitle: true,
      ),
      body:  Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: ListView(
            children: <Widget>[
              toptext(),
              SizedBox(height: 5.0),
              FoodCategory(),
              SizedBox(height: 10.0),
              Shoops(),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      )
    );
  }
}
