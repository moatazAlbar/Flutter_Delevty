import 'package:flutter/material.dart';

import 'foodcard.dart';

class FoodCategory extends StatelessWidget{
  List FoodCard=["Images/food/f1.jpg","Images/food/f2.jpg","Images/food/f3.jpg","Images/food/f4.jpg"];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: ListView.builder(
          primary: false,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount:FoodCard == null ? 0 : FoodCard.length,
          itemBuilder: (BuildContext context, int index) {


            return Container(

              margin: EdgeInsets.only(top:12,right: 12),
              
              child: Container(
                      child: Image.asset("${FoodCard[index]}",fit: BoxFit.fill,width: 200,height: 230,)),
            );
          },
        ),
    );
  }

}