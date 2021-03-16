import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/SignUp_screen.dart';
import 'package:flutter_app/Screens/admin/EditProduct.dart';
import 'package:flutter_app/Screens/admin/addProduct.dart';
import 'package:flutter_app/provider/adminmode.dart';
import 'package:flutter_app/provider/modelHud.dart';
import 'package:provider/provider.dart';

import 'Screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=>ModelHud(),),
      ChangeNotifierProvider(create: (context)=>Adminemode(),)
    ],
     child: MaterialApp(
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        AddProduct.id:(context)=>AddProduct(),
        EditProduct.id:(context)=>EditProduct(),
      },
    ),
    );


  }
}
