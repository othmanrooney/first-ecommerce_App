
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/admin/EditProduct.dart';
import 'package:flutter_app/Screens/admin/VewOrder.dart';
import 'package:flutter_app/Screens/admin/addProduct.dart';
import 'package:flutter_app/constant.dart';

class adminhome extends StatefulWidget {
  @override
  _adminhomeState createState() => _adminhomeState();
}

class _adminhomeState extends State<adminhome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: KMainColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
                SizedBox(
                  width: double.infinity,
                ),
            ElevatedButton(
              onPressed: () {
          return  Navigator.pushNamed(context, AddProduct.id);
              },
              child: Text('Add Product'),
            ),
            ElevatedButton(
                onPressed: () {
                Navigator.pushNamed(context, EditProduct.id);
                },
              child: Text('Edit Product'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, ViewOrder.id);

              },
              child: Text('View Product'),
            ),
          ],
        )
    );
  }
}
