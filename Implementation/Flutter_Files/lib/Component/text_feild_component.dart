import 'package:flutter/material.dart';
import 'package:fyp_203/constants/colors_constant.dart';


class CustomerTextFeild extends StatelessWidget {
  const CustomerTextFeild({
    super.key,
    required this.textlabel,
    required this.texteditingcontroller,
    required this.isobsure,
    this.iconData
  });

  final String textlabel;
  final TextEditingController texteditingcontroller;
  final bool isobsure;
  final IconData? iconData;
  @override
  Widget build(BuildContext context) {
    return  TextField(
      cursorColor: AppColorCode.primaryColor_500,
      obscureText: isobsure,
      controller: texteditingcontroller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: textlabel,
        filled: true,
        fillColor: Colors.white,
        focusColor: AppColorCode.primaryColor_500,
        suffixIcon: iconData==null? Icon(iconData) : InkWell(onTap: (){},child: Icon(iconData)),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
         ),
      ),
    );
  }
}
