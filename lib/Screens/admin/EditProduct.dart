
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/admin/eiditspec.dart';
import 'package:flutter_app/Widgets/CustomePopupMenueItem.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/services/store.dart';

import '../../constant.dart';
class EditProduct extends StatefulWidget {
  static String id="EditProduct";

  @override
  _EditProductState createState() => _EditProductState();
}
class _EditProductState extends State<EditProduct> {
  final _store=Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.LoadProducts(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            List<Product> products=[];
            for(var doc in snapshot.data.docs){
              var data=doc.data();
              products.add(Product(
                pPrice: data[KProductPrice],
                pName: data[KProductName],
                imageurl: data[KProductLocation],
                pDes: data[KProductDes],
                pCategory: data[KProductCategory],
                pID: doc.id,
              ));

            }
            return GridView.builder(
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,

              ),
                itemCount:products.length,
                itemBuilder:
                    (context,index)=>Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      child: GestureDetector(
                        onTapUp: (details) {
                          //position for left exactly
                         double dx=details.globalPosition.dx;
                         double dy=details.globalPosition.dy;
                         double dx2=MediaQuery.of(context).size.width-dx;
                         double dy2=MediaQuery.of(context).size.width-dy;
                          showMenu(
                              context: context,
                              position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                              items: [
                                MyPopupMenuItem(
                                  onClick: ()async{
                                    Navigator.pushNamed(context,EditSpec.id,arguments: products[index]);
                                  },
                                  child: Text('Edit'),
                                ),
                                MyPopupMenuItem(
                                  onClick: ()async{
                                    _store.deleteProduct(products[index].pID);
                                  },
                                    child: Text('Delete'),


                                ),
                              ]
                          );
                        },
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image(
                                fit: BoxFit.fill,
                                image: NetworkImage(products[index].imageurl),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Opacity(
                                opacity: 0.6,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 60,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                    child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(products[index].pName,
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        Text('\$ ${products[index].pPrice}'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
            );
          }
          return CircularProgressIndicator();
      },
      ),
      
    );
  }
}
