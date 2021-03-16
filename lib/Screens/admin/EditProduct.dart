
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/services/store.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(100.0),
        child: FutureBuilder<List<Product>>(
          future: _store.LoadProducts(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder:
                      (context,index)=>Text(snapshot.data[index].pName));
            }
            return CircularProgressIndicator();
        },
        ),
      ),
      
    );
  }
}
