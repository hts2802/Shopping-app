import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/home/main_food_page.dart';
import '../utils/dimensions.dart';

class AppTextFeild extends StatelessWidget {

  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  bool isObscure;
  AppTextFeild({Key? key,
    required this.icon,
    required this.hintText,
    required this.textController,
    this.isObscure=false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: Dimensions.height20, right: Dimensions.height20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.radius30),
            boxShadow:[
              BoxShadow(
                  blurRadius: 3,
                  spreadRadius: 1,
                  offset: Offset(1,1),
                  color: Colors.grey.withOpacity(0.2)
              ),]
        ),
        child: TextField(
          obscureText: isObscure?true:false,
            controller: textController,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: Icon(icon, color: Colors.brown,),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  borderSide: BorderSide(
                    width: 1.0,
                    color: Colors.white,
                  )
              ),
              //enabled Border
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  borderSide: BorderSide(
                    width: 1.0,
                    color: Colors.white,
                  )
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius30),

              ),
            )
        )
    );
  }
}
