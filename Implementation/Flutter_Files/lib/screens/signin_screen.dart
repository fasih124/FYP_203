import 'package:flutter/material.dart';
import 'package:fyp_203/constants/colors_constant.dart';
import 'package:fyp_203/constants/text_constant.dart';

import '../Component/text_feild_component.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    // dispose

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColorCode.neutralColor_500,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: AppColorCode.neutralColor_50,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  size: 18, color: Colors.black),
              onPressed: () {
                // Back button action
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Sign in now',
              style: AppTextStyle.heading_2
                  .copyWith(color: AppColorCode.primaryColor_600),
            ),
            SizedBox(height: 4),
            Text(
              'Please sign in to continue our app',
              style: AppTextStyle.sub_heading_1,
            ),
            SizedBox(height: 32),
            //Email
            CustomerTextFeild(
              textlabel: 'Email',
              texteditingcontroller: emailController,
              isobsure: false,
            ),
            SizedBox(height: 16),
            //Password
            CustomerTextFeild(
              textlabel: 'Password',
              texteditingcontroller: passwordController,
              isobsure: true,
              iconData: Icons.visibility_off_outlined,
            ),
            SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Forget Password?',
                  style: AppTextStyle.Small_text_1.copyWith(
                      color: AppColorCode.primaryColor_600),
                ),
              ),
            ),
            SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Sign Up button action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      AppColorCode.secondaryColor_500, // Button color
                  padding: EdgeInsets.symmetric(vertical: 22),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Don’t have an account?',
                    style: TextStyle(fontSize: 14),
                  ),
                  TextButton(
                    onPressed: () {
                      // Sign in action
                    },
                    child: Text(
                      'Sign in',
                      style: AppTextStyle.Small_text_1.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColorCode.primaryColor_600,
                        decorationThickness: 2.0,
                        color: AppColorCode.primaryColor_600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
