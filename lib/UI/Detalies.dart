import 'package:flutter/material.dart';
import 'package:test2/Model/Categorymodel.dart';
import 'package:test2/Model/category.dart';

class detailesscreen extends StatefulWidget {
  final int Id;
  final String Name;
  const detailesscreen(this.Id,this.Name);

  @override
  _detailesscreenState createState() => _detailesscreenState(Name,Id);
}

class _detailesscreenState extends State<detailesscreen> {
  final String titleName;
  int id;
  _detailesscreenState(this.titleName,this.id);
  IconData icona=Icons.favorite_border;
  IconData iconb=Icons.favorite_border;

 List <int> _categorieslike;

  @override
  Widget build(BuildContext context) {
    //final List <Categories> _categories=category.where((val) => val.Id==id).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(titleName),
        centerTitle: true,
        leading: IconButton(onPressed:()=> Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body:Container(
        margin: EdgeInsets.all(10),
        child: ListView.builder(
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
                    // leading: _categories[index]==true?
                    // IconButton(
                    //   onPressed:() {
                    //     setState(() {
                    //       icona == Icons.favorite_border
                    //           ? icona = Icons.favorite
                    //           : icona = Icons.favorite_border;
                    //     });
                    //   },
                    //     icon:  Icon(icona)
                    // )
                    //     :IconButton(
                    //     onPressed:() {
                    //       setState(() {
                    //         iconb == Icons.favorite_border
                    //             ? iconb = Icons.favorite
                    //             : iconb = Icons.favorite_border;
                    //       });
                    //     },
                    //     icon:  Icon(iconb)
                    // ),
                  ),
                );
              },
            ),
      ),

    );
  }

}
