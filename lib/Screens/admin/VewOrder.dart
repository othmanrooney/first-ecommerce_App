
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/constant.dart';
import 'package:flutter_app/models/Order.dart';
import 'package:flutter_app/services/store.dart';

import 'order_details.dart';

class ViewOrder extends StatefulWidget {
  static String id ="View Order";
  @override
  _ViewOrderState createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {

  Store _store=Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: StreamBuilder<QuerySnapshot>(
      stream:_store.LoadOrders(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Center(
            child: Text("No Data"),
          );
        }
        else {
          List <Order>orders=[];
          for(var doc in snapshot.data.docs){
             orders.add(Order(
               DocumentID: doc.id,
               Address:doc.data()[KAddress] ,
               TotalPRice:doc.data()[KorderPrice] ,
             ));
          };
          return ListView.builder(
            itemBuilder: (context,index)=>
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, OrderDetails.id,arguments: orders[index].DocumentID);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height*0.2,
                  color: KSecondary,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Total Price = JD'+orders[index].TotalPRice.toString(),
                          style: TextStyle(
                              fontSize: 15,fontWeight: FontWeight.bold
                          ),),
                        SizedBox(height: 10,),
                        Text('Address is '+orders[index].Address,style: TextStyle(
                          fontSize: 15,fontWeight: FontWeight.bold
                        ),),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            itemCount: orders.length,
          );
        }
      },
    ),
    );
  }
}
