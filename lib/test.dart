import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Test extends StatefulWidget {
  const Test();

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount:5,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(top: 60),
            child: Column(
              children: [
                Container(
                  child: Container(
                    height: 350,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueGrey
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20),),
                              image:DecorationImage(
                                  image: AssetImage("Images/resturant/r$index.webp",),
                                  fit: BoxFit.fill
                              )
                          ),
                        ),
                        ListTile(
                          title: Text("Cartoon",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),),
                          subtitle:Text("Cartoon"),
                          trailing: Text("1200\$",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),),
                        ),
                        ListTile(
                          title: Text("Cartoon",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),),
                          subtitle:Text("Shop"),
                          leading:CircleAvatar(
                            child: Image.asset("Images/resturant/r$index.webp",fit: BoxFit.cover,),
                          ),
                          trailing: IconButton(icon: Icon(Icons.favorite_border),onPressed: (){},),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      )
    );
  }
}
