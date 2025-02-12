import 'package:flutter/material.dart';
import 'package:fyp_203/constants/colors_constant.dart';


// class CustomerTextFeild extends StatelessWidget {
//   const CustomerTextFeild({
//     super.key,
//     required this.textlabel,
//     required this.texteditingcontroller,
//     required this.isobsure,
//     this.iconData
//   });
//
//   final String textlabel;
//   final TextEditingController texteditingcontroller;
//   final bool isobsure;
//   final IconData? iconData;
//   @override
//   Widget build(BuildContext context) {
//     return  TextField(
//       cursorColor: AppColorCode.primaryColor_500,
//       obscureText: isobsure,
//       controller: texteditingcontroller,
//       keyboardType: TextInputType.emailAddress,
//       decoration: InputDecoration(
//         hintText: textlabel,
//         filled: true,
//         fillColor: Colors.white,
//         focusColor: AppColorCode.primaryColor_500,
//         suffixIcon: iconData==null? Icon(iconData) : InkWell(onTap: (){},child: Icon(iconData)),
//         border: OutlineInputBorder(
//           borderSide: BorderSide.none,
//           borderRadius: BorderRadius.circular(10),
//          ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class CustomerTextField  extends StatefulWidget {
  const CustomerTextField({
    super.key,
    required this.textlabel,
    required this.texteditingcontroller,
    this.isPassword = false, // Updated: Default is false
  });

  final String textlabel;
  final TextEditingController texteditingcontroller;
  final bool isPassword; // Updated: Indicates if it's a password field

  @override
  _CustomerTextFieldState createState() => _CustomerTextFieldState();
}

class _CustomerTextFieldState extends State<CustomerTextField> {
  bool _isObscured = true; // Default to true for password fields

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.blue, // Change color as needed
      obscureText: widget.isPassword ? _isObscured : false, // Toggle visibility
      controller: widget.texteditingcontroller,
      keyboardType: widget.isPassword ? TextInputType.text : TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: widget.textlabel,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _isObscured ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },
        )
            : null, // Hide suffixIcon if not a password field
      ),
    );
  }
}
