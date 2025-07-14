import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp_203/constants/colors_constant.dart';
import 'package:fyp_203/constants/text_constant.dart';
import 'package:fyp_203/screens/signin_screen.dart';
import '../Component/text_feild_component.dart';

import 'package:fyp_203/services/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<bool> registerUser(BuildContext context) async {
    print(emailController.text);
    print(usernameController.text);
    print(passwordController.text);
    print(confirmPasswordController.text);

    if ((passwordController.text == confirmPasswordController.text) &&
        (passwordController.text.length >= 6)) {
      try {
        // Register user with email & password
        User? user = await AuthService().signUp(
            emailController.text.trim(), passwordController.text.trim());

        if (user != null) {
          print('User is registered successfully');

          // Store username
          DatabaseReference userRef = FirebaseDatabase.instanceFor(
            app: Firebase.app(),
            databaseURL:
                'https://fpy-203-default-rtdb.asia-southeast1.firebasedatabase.app',
          ).ref("parents/${user.uid}");
          await userRef.set({
            "username": usernameController.text.trim(),
            "email": emailController.text.trim(),
          });

          // ✅ Show verify dialog
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Verify Your Email'),
              content: const Text(
                  'A verification link has been sent to your email. Please verify it before logging in. Check your email inbox/spam for the verification link.'),
              actions: [
                TextButton(
                  // onPressed: () {
                  //   Navigator.pop(context); // just close dialog
                  // },
                  onPressed: () {
                    Navigator.pop(context); // close dialog
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const SignInScreen()),
                    );
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );

          return true;

        } else {
          print('User registration failed');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Registration failed! Please try again."),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
          return false;
        }
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: $e"),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
        return false;
      }
    } else {
      print('Password not match or too short');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Passwords do not match or are too short!"),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
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
                      const SizedBox(
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
                      CustomerTextField(
                        textlabel: 'Username',
                        texteditingcontroller: usernameController,
                        isPassword: false,
                      ),
                      const SizedBox(height: 16),
                      CustomerTextField(
                        textlabel: 'Email',
                        texteditingcontroller: emailController,
                        isPassword: false,
                      ),
                      const SizedBox(height: 16),
                      CustomerTextField(
                          textlabel: 'Password',
                          texteditingcontroller: passwordController,
                          isPassword: true),
                      const SizedBox(height: 16), //Password
                      CustomerTextField(
                          textlabel: 'Confirm Password',
                          texteditingcontroller: confirmPasswordController,
                          isPassword: true),
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
                          onPressed: () async {
                            bool isRegistered = await registerUser(context);
                            if (isRegistered) {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const SignInScreen(),
                              //   ),
                              // );
                            } else {
                              print("Error occurred!!!");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                AppColorCode.secondaryColor_500, // Button color
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
