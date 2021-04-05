
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Functions/getproductbyCategory.dart';
import 'package:flutter_app/Screens/User/ProductInfo.dart';
import 'package:flutter_app/models/product.dart';

Widget ProductView(String pCategroy,List <Product> allproduct) {

  List <Product> products;
  products= getProductByCategory(pCategroy,allproduct);
  print(products.length);

  return  GridView.builder(
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
          onTap: () {
            Navigator.pushNamed(context, ProductInfo.id,arguments: products[index]);
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