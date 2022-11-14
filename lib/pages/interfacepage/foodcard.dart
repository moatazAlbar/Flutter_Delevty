import 'package:flutter/material.dart';
import 'package:test2/UI/Detalies.dart';

class Shoops extends StatefulWidget {
  const Shoops();

  @override
  _ShoopsState createState() => _ShoopsState();
}

class _ShoopsState extends State<Shoops> {
  @override
  Widget build(BuildContext context) {
    List FoodCard=["Images/resturant/r1.webp","Images/resturant/r2.webp","Images/resturant/r3.webp",
    "Images/resturant/r4.webp","Images/resturant/r5.jpg","Images/resturant/r6.webp","Images/resturant/r7.webp"
    ];
    return Container(
      child: ListView.builder(
        primary: false,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount:FoodCard == null ? 0 : FoodCard.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            margin: EdgeInsets.only(bottom: 10),

            child: InkWell(
              child: ListTile(
                onTap: ()=> Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>detailesscreen(index,FoodCard[index]),
                  ),),
                subtitle: Text("${FoodCard[index]}",),
                title: Text("${FoodCard[index]}",),
                leading: Image.asset(FoodCard[index]),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
          );
        },
      ),
    );
  }
}

