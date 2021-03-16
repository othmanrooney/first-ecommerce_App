import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class CustomeTextField extends StatelessWidget {
  final String hint;
  final IconData Iconr;
  final String type;
  final bool obscure;
  final Function onClick;
  const CustomeTextField(
      {@required this.hint,
      @required this.Iconr,
      @required this.type,
      @required this.obscure,
      @required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return "please Enter your $type";
          }
        },
        onChanged: onClick,
        obscureText: obscure,
        cursorColor: KMainColor,
        decoration: InputDecoration(
          hintText: hint,
          fillColor: KSecondary,
          filled: true,
          prefixIcon: Icon(
            Iconr,
            color: KMainColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
