
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant.dart';
import 'package:flutter_app/models/Order.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/services/store.dart';

class OrderDetails extends StatelessWidget {
  static String id ="OrderDetals";
  Store _store=Store();
  @override
  Widget build(BuildContext context) {
    String documentid=ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream:_store.LoadOrderDetails(documentid),
        builder: (context,snapshot){
          if(snapshot.hasData){
            List<Product> products= [];
            for(var doc in snapshot.data.docs){
              products.add(
                Product(
                  pName:doc.data()[KProductName],
                  PQuantity: doc.data()[KQuantity],
                  pCategory: doc.data()[KProductCategory],
                )
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context,index)=>
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                      height: MediaQuery.of(context).size.height*0.2,
                      color: KSecondary,
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Total Price = JD'+products[index].pName,
                                style: TextStyle(
                                    fontSize: 15,fontWeight: FontWeight.bold
                                ),),
                              SizedBox(height: 10,),
                              Text('Address is '+products[index].PQuantity.toString(),style: TextStyle(
                                  fontSize: 15,fontWeight: FontWeight.bold
                              ),),
                              SizedBox(height: 10,),
                              Text('Category is '+products[index].pCategory,style: TextStyle(
                                  fontSize: 15,fontWeight: FontWeight.bold
                              ),),
                            ],
                          ),
                      ),
                    ),
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {

                            },

                            child: Text("Confirm Order")
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {

                            },
                            child: Text("Delete Order")
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            );
          }
          else
            return Center(
              child: Text('Loading the Order Details'),
            );
        },

      ),
    );
  }
}
