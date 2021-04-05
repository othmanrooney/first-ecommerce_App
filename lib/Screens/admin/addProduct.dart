import 'dart:io';
import 'package:path/path.dart' as paths;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Widgets/CustomeTextField.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/services/store.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  static String id = 'AddProduct';

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _store=Store();

  String _name,_price,_Des,_Category,_imageLocation;

  final GlobalKey<FormState> _globalKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
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
                  /*
                  Padding(
                            padding: EdgeInsets.all(30.0),
                            child:  Center(
                              child: _imgurl== null
                                  ? Text('No image selected.')
                                  :Image.network(_imgurl),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(30),
                            child: ElevatedButton(
                            onPressed: getimage,
                            child: Icon(Icons.add_a_photo),
                          ),
                ),

                  */
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child:  Center(
                      child: _imgurl== null
                          ? Text('No image selected.')
                          :Image.network(_imgurl),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: ElevatedButton(
                      onPressed: getimage,
                      child: Icon(Icons.add_a_photo),
                    ),
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () {
                      if(_globalKey.currentState.validate()){
                        _globalKey.currentState.save();
                        _store.addProduct(Product(
                          pName: _name,
                          pPrice: _price,
                          pDes:_Des,
                          pCategory: _Category,
                          imageurl: _imgurl,
                        )
                        );
                      }
                      _globalKey.currentState.reset();

                    },
                    child: Text("Add Product"),
                  ),
                ],
              ),
            ),
          ],

        ));
  }
  var _imgurl;
  Future getimage()async{
    PickedFile pickfile = await ImagePicker().getImage(source: ImageSource.gallery);
    File imagefile=File(pickfile.path);
    String filename=paths.basename(imagefile.path);
    uploadImage(imagefile,filename);
  }

  void uploadImage(File file,String filename)async{
    Reference storagerefernce=FirebaseStorage.instance.ref().child(filename);
    storagerefernce.putFile(file).whenComplete(() => CircularProgressIndicator()).then((firebaseFile)async{
      var downloadurl=await firebaseFile.ref.getDownloadURL();
      String urlfile=firebaseFile.ref.fullPath.toString();
      setState(() {
        _imgurl=downloadurl;
        print(_imgurl);
        print("this is url : "+urlfile);
      });
    });
  }
}
