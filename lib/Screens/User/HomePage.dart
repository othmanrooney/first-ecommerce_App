import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Functions/getproductbyCategory.dart';
import 'package:flutter_app/Screens/login_screen.dart';
import 'package:flutter_app/Widgets/CustomePopupMenueItem.dart';
import 'package:flutter_app/Widgets/prodcutView.dart';
import 'package:flutter_app/constant.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/services/store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../admin/eiditspec.dart';
import 'CartScreen.dart';
import 'ProductInfo.dart';

class love extends StatefulWidget {
  static String id="Homepage";
  @override
  _loveState createState() => _loveState();
}
class _loveState extends State<love> {
  final _auth=Auth();
  User _loggerUSer;
  int _tapBarindex=0;
  int _bottomBarIndex=0;
  List <Product> _products;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              onTap: (value)async {
                if(value==2){
                  SharedPreferences pref= await SharedPreferences.getInstance();
                  pref.clear();
                 await _auth.SingOut();
                 Navigator.popAndPushNamed(context,LoginScreen.id);
                }
               setState(() {
                 _bottomBarIndex=value;
               });
              },
              currentIndex: _bottomBarIndex,
              type: BottomNavigationBarType.fixed,
              fixedColor: KMainColor,
              items: [
                BottomNavigationBarItem(
                  label: "Test",
                  icon:Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  label: "Test",
                  icon:Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  label: "SignOut",
                  icon:Icon(Icons.close),
                ),

              ],
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                indicatorColor: KMainColor,
                onTap: (value) {
                  setState(() {
                    _tapBarindex=value;
                  });

                },
                tabs: <Widget>[
                  Text("Jackets",style: TextStyle(
                  color: _tapBarindex==0?Colors.black:KUnActiveColor,
                  fontSize:  _tapBarindex==0?16:null,
                  ),
                  ),
                  Text("Trouser",style: TextStyle(
                    color: _tapBarindex==1?Colors.black:KUnActiveColor,
                    fontSize:  _tapBarindex==1?16:null,
                  ),),
                  Text("T-shirts",style: TextStyle(
                    color: _tapBarindex==2?Colors.black:KUnActiveColor,
                    fontSize:  _tapBarindex==2?16:null,
                  ),),
                  Text("Shoes",style: TextStyle(
                    color: _tapBarindex==3?Colors.black:KUnActiveColor,
                    fontSize:  _tapBarindex==3?16:null,
                  ),),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                JacketView(),
                ProductView(KJackets,_products),
                ProductView(KJackets,_products),
                ProductView(KJackets,_products),
              ],
            ),
          ),
        ),
        Material(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20,30,20,0),
            child: Container(
              height: MediaQuery.of(context).size.height*0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Discover".toUpperCase(),style: TextStyle(
                      fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  GestureDetector(

                    child: Icon(
                      Icons.shopping_cart
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, CartScreen.id);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
      
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  getCurrentUSer()async{
    _loggerUSer=await _auth.getUser();
  }
  final _store=Store();
 Widget JacketView() {
    return StreamBuilder<QuerySnapshot>(
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
          //الداتا يلي راح تيجيلي بخزنها بليست عشان ما اضل استدعي ال streambulder
          _products=[...products];//هاي عشان ما ياشرو على نفس المكان لاني راح اشطب القيم وهيك بتضل فاضيه للجميع لا بفصلهم وبخلي المسح لواحد منهم
          products.clear();
          products=getProductByCategory(KJackets,_products);
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
        return CircularProgressIndicator();
      },
    );
  }




}
