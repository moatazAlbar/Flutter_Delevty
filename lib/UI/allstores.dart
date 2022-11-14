import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test2/Model/SQLSERVERAPI.dart';
import 'package:test2/Model/storemodel.dart';

import 'addstore.dart';

class AllStores extends StatefulWidget {

  const AllStores();

  @override
  _AllStoresState createState() => _AllStoresState();
}

class _AllStoresState extends State<AllStores> {
  List<StoreModel> Stores=new List<StoreModel>();
  @override
  void initState() {
    Stores.clear();
    getallstores();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stores"),
        actions: [
          IconButton(
              icon: Icon(Icons.update),
              onPressed: getallstores)
        ],
      ),
      body: SingleChildScrollView(child: showStores()),
      floatingActionButton: FloatingActionButton.extended(onPressed:()=> Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=>AddStore(StoreModel("","","")),
        ),),
          label: Text("Add New Store"),
        backgroundColor: Colors.red,
      ),

    );
  }
  Widget showStores(){
    return RefreshIndicator(
      onRefresh: getallstores,
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child:Stores.length>0? ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount:Stores == null ? 0 : Stores.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              margin: EdgeInsets.all(10),

              child: InkWell(
                onTap: ()=> Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>AddStore(StoreModel.withid(
                      Stores[index].id,
                      Stores[index].name,
                      Stores[index].descripe,
                      Stores[index].picure)),
                  ),),
                child: Card(
                  color: Colors.red,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 20),
                        child:Stores[index].picure.length>3?Container(
                          height: 80,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                              image:DecorationImage(
                                  image: MemoryImage(base64Decode(Stores[index].picure)),
                                  fit: BoxFit.fill
                              )
                          ),
                        ):Container(
                          height: 80,
                          width: 100,
                          decoration: BoxDecoration(
                              image:DecorationImage(
                                  image: AssetImage("Images/store.png"),
                                  fit: BoxFit.fill
                              )
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          // ListTile(
                          //   title: Text(Stores[index].name),
                          //   subtitle: Text(Stores[index].descripe),
                          //   leading: Icon(Icons.arrow_forward_ios),
                          // ),
                          Container(
                            child:Text(Stores[index].name,style: TextStyle(color:Colors.white,fontSize: 25,fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child:Text(Stores[index].descripe,style: TextStyle(color: Colors.white70),
                            ),
                          ),

                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 50),
                          child: Icon(Icons.arrow_forward_ios,color: Colors.white,)),
                    ],
                  ),
                ),
              ),
            );
          },
        ):Center(child: CircularProgressIndicator()),
      ),
    );
  }
 Future getallstores(){
   return APISERVER.getusers("Stores").then((res){
      Iterable list=json.decode(res.body);
      List<StoreModel>joblist=List<StoreModel>();
      joblist=list.map((model) => StoreModel.fromObject(model)).toList();
      setState(() {
        Stores=joblist;
      });
    });
  }
}
