import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter_app/constant.dart';
import 'package:flutter_app/models/product.dart';
class Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addProduct(Product prodcut) {
    _firestore.collection(KProductCollection).add({
      KProductName: prodcut.pName,
      KProductPrice: prodcut.pPrice,
      KProductDes: prodcut.pDes,
      KProductCategory: prodcut.pCategory,
      KProductLocation: prodcut.imageurl,
    });
  }

  Stream<QuerySnapshot> LoadProducts() {
    return _firestore.collection(KProductCollection).snapshots();
  }
  deleteProduct(documentID){
    _firestore.collection(KProductCollection).doc(documentID).delete();
  }
  editProduct(data,documentID){
    _firestore.collection(KProductCollection).doc(documentID).update(data);
  }
  StoreOrders(data,List<Product> product){
   var documentReference= _firestore.collection(KOrders).doc();
   documentReference.set(data);
   for(var products in product){
     documentReference.collection(KOrdersdetailes).doc().set({
       KProductName: products.pName,
       KProductPrice: products.pPrice,
       KProductDes: products.pDes,
       KProductCategory: products.pCategory,
       KProductLocation: products.imageurl,
       KQuantity:products.PQuantity,
     });
   }

  }
  Stream<QuerySnapshot> LoadOrders(){
    return _firestore.collection(KOrders).snapshots();
  }
  Stream<QuerySnapshot> LoadOrderDetails(documentID){
    return _firestore.collection(KOrders).doc(documentID).collection(KOrdersdetailes).snapshots();
  }
}