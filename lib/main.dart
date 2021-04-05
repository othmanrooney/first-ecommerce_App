import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/SignUp_screen.dart';
import 'package:flutter_app/Screens/User/CartScreen.dart';
import 'package:flutter_app/Screens/User/ProductInfo.dart';
import 'package:flutter_app/Screens/admin/EditProduct.dart';
import 'package:flutter_app/Screens/admin/VewOrder.dart';
import 'package:flutter_app/Screens/admin/addProduct.dart';
import 'package:flutter_app/Screens/admin/eiditspec.dart';
import 'package:flutter_app/Screens/admin/order_details.dart';
import 'package:flutter_app/constant.dart';
import 'package:flutter_app/provider/CartItem.dart';
import 'package:flutter_app/provider/adminmode.dart';
import 'package:flutter_app/provider/modelHud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/User/HomePage.dart';
import 'Screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  bool isUserLoogedIn=false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
    future: SharedPreferences.getInstance(),
    builder: (context,snapshot){
      if(!snapshot.hasData){
        return MaterialApp(
          home: Scaffold(
            body: Center(
              child: Text("Loading ..."),
            ),
          ),
        );
      }
      else {
        isUserLoogedIn=snapshot.data.getBool(KKeepmeLogin)??false;
        return MultiProvider(providers: [
          ChangeNotifierProvider(create: (context)=>ModelHud(),),
          ChangeNotifierProvider(create: (context)=>Adminemode(),),
          ChangeNotifierProvider(create: (context)=>CartItem(),)
        ],
          child: MaterialApp(
            initialRoute: isUserLoogedIn? love.id:LoginScreen.id,
            routes: {
              LoginScreen.id: (context) => LoginScreen(),
              SignUpScreen.id: (context) => SignUpScreen(),
              AddProduct.id:(context)=>AddProduct(),
              EditProduct.id:(context)=>EditProduct(),
              EditSpec.id:(context)=>EditSpec(),
              ProductInfo.id:(context)=>ProductInfo(),
              CartScreen.id:(context)=>CartScreen(),
              ViewOrder.id:(context)=>ViewOrder(),
              OrderDetails.id:(context)=>OrderDetails(),
              love.id:(context)=>love(),
            },
          ),
        );
      }
    },
    );


  }
}
