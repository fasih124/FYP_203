import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp_203/constants/colors_constant.dart';
import 'package:fyp_203/constants/text_constant.dart';
import 'package:fyp_203/screens/signin_screen.dart';

import '../Component/text_feild_component.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColorCode.neutralColor_500,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: AppColorCode.neutralColor_50,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    size: 18, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 48),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Sign up now',
                        style: AppTextStyle.heading_2
                            .copyWith(color: AppColorCode.primaryColor_600),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(

                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            textAlign: TextAlign.center,
                              'Please fill the details and create account',
                            style: AppTextStyle.sub_heading_1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      CustomerTextFeild(
                        textlabel: 'Email',
                        texteditingcontroller: emailController,
                        isobsure: false,
                      ),
                      const SizedBox(height: 16),
                      CustomerTextFeild(
                        textlabel: 'Password',
                        texteditingcontroller: passwordController,
                        isobsure: true,
                        iconData: Icons.visibility_off_outlined,
                      ),
                      const SizedBox(height: 16), //Password
                      CustomerTextFeild(
                        textlabel: 'Confirm Password',
                        texteditingcontroller: confirmPasswordController,
                        isobsure: true,
                        iconData: Icons.visibility_off_outlined,
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Password must be 8 character',
                            style: AppTextStyle.Small_text_1.copyWith(
                                color: AppColorCode.primaryColor_600),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => const SignInScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColorCode.secondaryColor_500, // Button color
                            padding: const EdgeInsets.symmetric(vertical: 22),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Already have an account',
                              style: TextStyle(fontSize: 14),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (builder) => const SignInScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign in',
                                style: AppTextStyle.Small_text_1.copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      AppColorCode.primaryColor_600,
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
              ),
            );
          },
        )
        ///////////////////////////////,
        );
  }
}
