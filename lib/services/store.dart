import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter_app/constant.dart';
import 'package:flutter_app/models/product.dart';
class Store{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  addProduct(Product prodcut){
    _firestore.collection(KProductCollection).add({
      KProductName:prodcut.pName,
      KProductPrice:prodcut.pPrice,
      KProductDes:prodcut.pDes,
      KProductCategory:prodcut.pCategory,
      KProductLocation:prodcut.pLocation,
    });
  }
  Future<List<Product>>LoadProducts()async{
    var snapshot=await _firestore.collection(KProductCollection).get();

    List<Product> products=[];
    for(var doc in snapshot.docs){
      var data=doc.data();
      products.add(Product(
      pPrice: data[KProductPrice],
      pName: data[KProductName],
      pLocation: data[KProductLocation],
      pDes: data[KProductDes],
      pCategory: data[KProductCategory],
      ));

    }
    return products;
  }
}