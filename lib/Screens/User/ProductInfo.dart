
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/User/CartScreen.dart';
import 'package:flutter_app/constant.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/provider/CartItem.dart';
import 'package:provider/provider.dart';

class ProductInfo extends StatefulWidget {
  static String id= "ProductInfo";
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity=1;
  @override
  Widget build(BuildContext context) {
    Product _products=ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image(
              fit: BoxFit.fill,
              image: NetworkImage(_products.imageurl),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20,30,20,0),
            child: Container(
              height: MediaQuery.of(context).size.height*0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    child: Icon(Icons.arrow_back_ios),
                    onTap: () {
                      Navigator.pop(context);
                    },

                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.shopping_cart,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, CartScreen.id);
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,

            child: Column(
              children: [
                Opacity(
                  child: Container(
                     color: Colors.white,
                    height: MediaQuery.of(context).size.height*0.3,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Text(
                              _products.pName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                           "Type : "+_products.pDes,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            "\$ : "+_products.pPrice,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            "Type : "+_products.pCategory,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                GestureDetector(
                                  onTap: Subtract,
                                  child: ClipOval(
                                    child: Material(
                                      color: KMainColor,
                                      child: SizedBox(
                                        height: 28,
                                        width: 28,
                                        child: Icon(Icons.remove),
                                      ),
                                    ),
                                  ),
                                ),
                              Text(
                                _quantity.toString(),
                                style: TextStyle(

                                ),
                              ),
                              GestureDetector(
                                onTap: Add,
                                child: ClipOval(
                                  child: Material(
                                    color: KMainColor,
                                    child: SizedBox(
                                      height: 28,
                                      width: 28,
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  opacity: 0.5,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.1,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape:MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius:BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                        ),
                      ),
                          backgroundColor: MaterialStateProperty.all(KMainColor),
                    ),
                      onPressed: () {
                      AddToCart(_products);
                      },
                      child: Text(
                        'ADD To Cart',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  void Subtract() {
    if(_quantity>0){
      setState(() {
        _quantity--;
      });

    }
  }

  void Add() {
    setState(() {
      _quantity++;
    });

  }

  void AddToCart(Product _products) {

    //جوا الاون بريس لازم  الليسينر يكون فولس
    CartItem cartitem=Provider.of<CartItem>(context,listen: false);
    _products.PQuantity=_quantity;
    bool exist=false;
    var productsInCart = cartitem.products;
    for(var productInCart in productsInCart){
      if(productInCart.pName==_products.pName){
        exist=true;
      }
    }
    if(exist){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Exactly here'),
        ),
      );
    }
    else{
      cartitem.addProduct(_products);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Added Successfully'),
        ),
      );
    }
  }
}
