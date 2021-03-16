import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Widgets/CustomeTextField.dart';
import 'package:flutter_app/constant.dart';
import 'package:flutter_app/provider/modelHud.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';
import 'package:flutter_app/services/auth.dart';

import 'love.dart';
class SignUpScreen extends StatelessWidget {
  static String id = "SignUpScreen";

  String _email ;

  String _password ;

  String _name ;

  Auth _auth=Auth();

  final GlobalKey<FormState> _globalkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: KMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isloading,
        child: Form(
          key: _globalkey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage('images/icon/shop.png'),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Text(
                          '( لبسني )',
                          style: TextStyle(
                            fontFamily: 'Pacifico',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.1,
              ),
              CustomeTextField(
                hint: "Enter Your Name",
                Iconr: Icons.perm_identity,
                type: "Name",
                obscure: false,
                onClick: (value) {
                  _name = value;
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CustomeTextField(
                hint: "Enter Your Email",
                Iconr: Icons.email,
                type: "Email",
                obscure: false,
                onClick: (value) {
                  _email = value;
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CustomeTextField(
                hint: "Enter your Password",
                Iconr: Icons.lock,
                type: "please Enter your Password",
                obscure: true,
                onClick: (value) {
                  _password = value;
                },
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: Builder(
                  builder:(context)=> TextButton(
                    //shape: RoundedRectangleBorder(
                    // borderRadius: BorderRadius.circular(20),
                    //),
                    onPressed: () async{
                      final modelhud=Provider.of<ModelHud>(context,listen: false);
                      modelhud.changeisLoading(true);
                      if (_globalkey.currentState.validate()){
                        _globalkey.currentState.save();
                      try{
                        final resultauth=await  _auth.signUp(_email,_password);
                        print(resultauth.user.uid);
                        modelhud.changeisLoading(false);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => love()));
                      } catch(e){
                        modelhud.changeisLoading(false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(

                              content: Text(
                            e.message
                          ))
                        );
                      }
                      }
                      modelhud.changeisLoading(false);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    // color: Colors.black,
                    child: Text(
                      "SignUP",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              //login statement
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "You have an account ? ",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
