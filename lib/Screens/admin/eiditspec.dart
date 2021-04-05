
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Widgets/CustomeTextField.dart';
import 'package:flutter_app/constant.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/services/store.dart';

class EditSpec extends StatelessWidget {
  static String id="EditSpec";
  final _store=Store();
  String _name,_price,_Des,_Category,_imageLocation;
  final GlobalKey<FormState> _globalKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Product products=ModalRoute.of(context).settings.arguments;
    return Scaffold(
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 150),
          children: [
            Form(
              key: _globalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomeTextField(
                    hint: "Product Name",
                    obscure: false,
                    onClick: (value){
                      _name=value;
                    },
                  ),
                  SizedBox(height: 10,),
                  CustomeTextField(
                    hint: "Prdouct Price",
                    obscure: false,
                    onClick: (value){
                      _price=value;
                    },
                  ),
                  SizedBox(height: 10,),
                  CustomeTextField(
                    hint: "Product Description",
                    obscure: false,
                    onClick: (value){
                      _Des=value;
                    },
                  ),
                  SizedBox(height: 10,),
                  CustomeTextField(
                    hint: "Product Category",
                    obscure: false,
                    onClick: (value){
                      _Category=value;
                    },
                  ),
                  SizedBox(height: 10,),
                  CustomeTextField(
                    hint: "Product Location",
                    obscure: false,
                    onClick: (value){
                      _imageLocation=value;
                    },
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () {
                      if(_globalKey.currentState.validate()){
                        _globalKey.currentState.save();
                      _store.editProduct((
                         {
                           KProductName:_name,
                           KProductDes:_Des,
                           KProductCategory:_Category,
                           KProductLocation:_imageLocation,
                           KProductPrice:_price,
                         }
                          )
                          , products.pID);
                      }
                    },
                    child: Text("Eidte Product"),
                  ),
                ],
              ),
            ),
          ],

        )
    );
  }
}
