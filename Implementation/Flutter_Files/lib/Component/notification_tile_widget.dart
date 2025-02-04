import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {

  const NotificationTile({
    required this.iconPath,
    required this.mainColor,
    required this.secondaryColor,
    required this.titleText,
    required this.descriptionText,
    required this.textValue,
    super.key,
  });

  final String iconPath;
  final Color mainColor;
  final Color secondaryColor;
  final String titleText;
  final String descriptionText;
  final String textValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: mainColor,//Colors.red,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        //  tileColor: Colors.red,
        leading: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: secondaryColor,//Colors.red.shade300,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              iconPath,//'assets/icons_img/temp_Icon.png',
              width: 25,
              height: 23,
            ),
          ),
        ),
        title: Text(
            titleText.toUpperCase(),// 'Temperature'.toUpperCase(),
          style: TextStyle(
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.underline,
              decorationColor: Colors.white,
              color: Colors.white,
              decorationThickness: 2
          ),

        ),
        subtitle: Text.rich(
          textAlign: TextAlign.left,
          TextSpan(
            children: [
              TextSpan(
                  text: descriptionText,//"Temperature exceed",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.white)),
              TextSpan(
                  text: textValue,//"20F",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white))
            ],
          ),
        ),
        trailing: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: Colors.white,
                width: 2), // Circular outline
          ),
          child: InkWell(
            onTap: (){},
            child: Center(
              child: Icon(
                Icons.close_rounded,
                color: Colors.white,
                size: 18, // Adjust the cross size
              ),
            ),
          ),
        ),
      ),
    );
  }
}