import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/SignUp_screen.dart';
import 'package:flutter_app/Widgets/CustomeTextField.dart';
import 'package:flutter_app/provider/adminmode.dart';
import 'package:flutter_app/provider/modelHud.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import 'admin/adminhome.dart';
import 'love.dart';
import 'package:flutter_app/services/auth.dart';

class LoginScreen extends StatelessWidget {
  final adminPassword="admin1234";
  static String id = "LoginScreen";
  String _email ;
  String _password ;
  final GlobalKey<FormState> _globalkey = GlobalKey<FormState>();
  final _auth=Auth();
  bool isAdmin=false;
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
                type: "Password",
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
                child: TextButton(
                  //shape: RoundedRectangleBorder(
                  // borderRadius: BorderRadius.circular(20),
                  //),
                  onPressed: (){
                   _validate(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  // color: Colors.black,
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don\'t have an account",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignUpScreen.id);
                    },
                    child: Text(
                      "SignUp",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(child: GestureDetector(
                      onTap: () {
                    Provider.of<Adminemode>(context,listen: false).changeIsAdmin(true);
                      },
                      child: Text("i\'m an admin",
                      style: TextStyle(
                          color:Provider.of<Adminemode>(context).isAdmin?KMainColor:Colors.white
                      ),
                      textAlign: TextAlign.center,
                      ),
                    )),
                    Expanded(child: GestureDetector(
                      onTap: () {
                  Provider.of<Adminemode>(context,listen: false).changeIsAdmin(false);
                      },
                      child: Text("i\'m a  user",
                          style: TextStyle(
                            color:Provider.of<Adminemode>(context).isAdmin?Colors.white:KMainColor,
                          ),
                        textAlign: TextAlign.center,
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context)async {
    final modelhud=Provider.of<ModelHud>(context,listen: false);
    modelhud.changeisLoading(true);
    if(_globalkey.currentState.validate()){
      _globalkey.currentState.save();
      if(Provider.of<Adminemode>(context,listen: false).isAdmin)
      {
        if(_password ==adminPassword)
          {
            try{
            await  _auth.signIn(_email, _password);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>adminhome()));
            }catch(e){
              modelhud.changeisLoading(false);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          e.message
                      ))
              );
            }

      }else{
        modelhud.changeisLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Something went wrong")));
      }
    }else{
      try{
      await  _auth.signIn(_email, _password);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>love()));
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(e.message)));
      }
    }}

    modelhud.changeisLoading(false);
  }

}
