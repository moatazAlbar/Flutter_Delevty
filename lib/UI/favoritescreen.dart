import 'package:flutter/material.dart';
import 'package:test2/Model/Categorymodel.dart';
import 'package:test2/Model/category.dart';

class Favorite extends StatefulWidget {
  const Favorite() ;

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    //final List <Categories> _categories=category.where((val) => val.Chose==true).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Category"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
        onPressed:()=> Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.home),
          ),
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.shopping_bag_outlined),
          )
        ],
      ),
      body: Container(
        child:  ListView.builder(
          primary: false,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount:3,
          itemBuilder: (BuildContext context, int index) {

            return Card(
              child: ListTile(
                title: Text("_categories[index].Name"),
                subtitle: Text("_categories[index].Descripe"),
                trailing: Image.asset("_categories[index].Image"),
              )
            );
          },
        ),
      ),
    );
  }
}
