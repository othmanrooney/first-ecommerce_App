
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/User/ProductInfo.dart';
import 'package:flutter_app/Widgets/CustomePopupMenueItem.dart';
import 'package:flutter_app/constant.dart';
import 'package:flutter_app/models/product.dart';
import 'package:flutter_app/provider/CartItem.dart';
import 'package:flutter_app/services/store.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static String id="CartScreen";
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
  List<Product> _producrs= Provider.of<CartItem>(context).products;
  final double screenHeight=MediaQuery.of(context).size.height;
  final double screenWidth=MediaQuery.of(context).size.width;
  final double appBarHieght=AppBar().preferredSize.height;
  final double statusBarHeight=MediaQuery.of(context).padding.top;

  return Scaffold(
    resizeToAvoidBottomInset: false,
    appBar: AppBar(
      title: Text(" { سلتي } ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: GestureDetector(
          child: Icon(Icons.arrow_back,color: Colors.black,),
          onTap: () {
            Navigator.pop(context);
          },
      ),
      elevation: 0,
    ),
      body: Column(
        children: [
          LayoutBuilder(
            builder:(context,constrains){
              if(_producrs.isNotEmpty){
                return Container(
                  height: screenHeight-appBarHieght-statusBarHeight-(screenHeight*0.08),
                  child: ListView.builder(
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: GestureDetector(
                          onTapUp: (details) {
                            showcustomemenue(details,context,_producrs[index]);
                          },
                          child: Container(
                            height: screenHeight*0.15,
                            color: KSecondary,
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: screenHeight*0.15/2,//ول الكونتينر عشان امليه
                                  backgroundImage: NetworkImage(_producrs[index].imageurl),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(_producrs[index].pName,
                                              style: TextStyle(
                                                  fontSize: 18,fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            SizedBox(height: 10,),
                                            Text(_producrs[index].pPrice+" JD",
                                              style: TextStyle(
                                                  fontSize: 20,fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 30),
                                        child: Icon(Icons.clear),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: Text(
                                          _producrs[index].PQuantity.toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: _producrs.length,

                  ),
                );
              }
              else
                  return Container(
                      height: screenHeight-(screenHeight*0.08)-appBarHieght-statusBarHeight,
                      child: Center(
                          child: Text("فاضيه ياحب ")
                      )
                  );



      }

          ),
          GestureDetector(
            onTap: () {


            },
            child: SizedBox(
              width: screenWidth,
              height: screenHeight*0.08,
              child: ElevatedButton.icon(
                icon:Icon(Icons.shopping_bag,color: Colors.black,),
                  label: Text("أطلب ",style: TextStyle(
                      color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                    style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(KMainColor),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight:Radius.circular(30) ))),
                    ),
                onPressed: () {
                  showcustomedialoge(_producrs,context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showcustomemenue(details,context,product)async {
    double dx=details.globalPosition.dx;
    double dy=details.globalPosition.dy;
    double dx2=MediaQuery.of(context).size.width-dx;
    double dy2=MediaQuery.of(context).size.width-dy;
    showMenu(
        context: context,
        position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
        items: [
          MyPopupMenuItem(
            onClick: ()async{
              Navigator.pop(context);
              Provider.of<CartItem>(context,listen: false).deleteProduct(product);
              Navigator.pushNamed(context, ProductInfo.id,arguments: product);

            },
            child: Text('تعديل الطلب'),
          ),
          MyPopupMenuItem(
            onClick: ()async{
              Navigator.pop(context);
              Provider.of<CartItem>(context,listen: false).deleteProduct(product);
            },
            child: Text('حذف '),


          ),
        ]
    );
  }

  void showcustomedialoge(List <Product> products,context ) async{
    var Address;
    var price=gettotlaprice(products);
    AlertDialog alerdialoge =AlertDialog(
      actions: [
        MaterialButton(
          onPressed: ()async {
            if(price==0 || Address==null){
              Navigator.pop(context);
             await showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return AlertDialog(
                      title: Text("ادخال خاطئ",textAlign: TextAlign.end,),
                      content: Text("يجب عليك ادخال بعض المنتجات بالاضافة الى الموقع"),
                      actions: [
                        ElevatedButton(onPressed: () {
                          Navigator.pop(context);
                        }, child: Text("اعادة"),
                    ),
                      ],
                    );
                  }
              );
            }
            else
              {
              try{
                Store _store=Store();
                _store.StoreOrders({
                  KorderPrice:price,
                  KAddress:Address,
                }, products);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'تم تاكيد الطلب شكرا لزيارتك :]'
                        ))
                );
                Navigator.pop(context);
              }catch (e){
                print(e);
              }
            }


          },
          child: Text("تأكيد"),
        ),
      ],
      content: TextField(
        onChanged: (value) {
          Address=value;
        },
        decoration: InputDecoration(
          hintText: "ادخل موقعك",
        ),

      ),
      title: Text("السعر الكلي = "+ price.toString() +"دينار  "),
    );
   await showDialog(context: context, builder: (context){
      return alerdialoge;
    }
    );
  }

  gettotlaprice(List <Product> products) {
  var price=0;
  for(var product in products){

    price+=product.PQuantity*int.parse(product.pPrice);
  }
  return price;
  }
}
