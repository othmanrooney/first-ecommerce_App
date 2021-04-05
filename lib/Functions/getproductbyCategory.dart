
import 'package:flutter_app/models/product.dart';

import '../constant.dart';

List<Product> getProductByCategory(String kJackets,List <Product> allProduct) {
  List <Product> products=[];
  try{
    for(var product in allProduct){
      if(product.pDes==KJackets){
        products.add(product);
      }
    }

  } on Error catch(ex){
    print(ex);
  }

  return products;
}