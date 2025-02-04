// import 'package:flutter/material.dart';
// import 'package:fyp_203/constants/colors_constant.dart';
// import 'package:fyp_203/constants/text_constant.dart';
// import 'package:fyp_203/screens/bottom_navigation_screen.dart';
// import 'package:fyp_203/screens/signup_screen.dart';
//
// import '../Component/text_feild_component.dart';
//
// class SignInScreen extends StatefulWidget {
//   const SignInScreen({super.key});
//
//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }
//
// class _SignInScreenState extends State<SignInScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Sign in now',
//                 style: AppTextStyle.heading_2
//                     .copyWith(color: AppColorCode.primaryColor_600),
//               ),
//               const SizedBox(height: 4),
//               const Text(
//                 'Please sign in to continue our app',
//                 style: AppTextStyle.sub_heading_1,
//               ),
//               const SizedBox(height: 32),
//               //Email
//               CustomerTextFeild(
//                 textlabel: 'Email',
//                 texteditingcontroller: emailController,
//                 isobsure: false,
//               ),
//               const SizedBox(height: 16),
//               //Password
//               CustomerTextFeild(
//                 textlabel: 'Password',
//                 texteditingcontroller: passwordController,
//                 isobsure: true,
//                 iconData: Icons.visibility_off_outlined,
//               ),
//               const SizedBox(height: 12),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton(
//                   onPressed: () {},
//                   child: Text(
//                     'Forget Password?',
//                     style: AppTextStyle.Small_text_1.copyWith(
//                         color: AppColorCode.primaryColor_600),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 32),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).push(_createRoute());
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor:
//                         AppColorCode.secondaryColor_500, // Button color
//                     padding: const EdgeInsets.symmetric(vertical: 22),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: const Text(
//                     'Sign In',
//                     style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 18,
//               ),
//               Center(
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Text(
//                       'Don’t have an account?',
//                       style: TextStyle(fontSize: 14),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (builder) => const SignUpScreen(),
//                           ),
//                         );
//                       },
//                       child: Text(
//                         'Sign up',
//                         style: AppTextStyle.Small_text_1.copyWith(
//                           decoration: TextDecoration.underline,
//                           decorationColor: AppColorCode.primaryColor_600,
//                           decorationThickness: 2.0,
//                           color: AppColorCode.primaryColor_600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
// Route _createRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => BottomNavigationScreen(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(1.0, 0.0); // Start from right side
//       const end = Offset.zero; // End at original position
//       const curve = Curves.easeInOut; // Smooth transition
//
//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//       var offsetAnimation = animation.drive(tween);
//
//       return SlideTransition(
//         position: offsetAnimation,
//         child: child,
//       );
//     },
//   );
// }

import 'package:flutter/material.dart';
import 'package:fyp_203/constants/colors_constant.dart';
import 'package:fyp_203/constants/text_constant.dart';
import 'package:fyp_203/screens/bottom_navigation_screen.dart';
import 'package:fyp_203/screens/signup_screen.dart';

import '../Component/text_feild_component.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0).copyWith(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 48, // Adjust bottom padding
                  top: 48,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign in now',
                      style: AppTextStyle.heading_2.copyWith(
                        color: AppColorCode.primaryColor_600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Please sign in to continue our app',
                      style: AppTextStyle.sub_heading_1,
                    ),
                    const SizedBox(height: 32),
                    // Email
                    CustomerTextFeild(
                      textlabel: 'Email',
                      texteditingcontroller: emailController,
                      isobsure: false,
                    ),
                    const SizedBox(height: 16),
                    // Password
                    CustomerTextFeild(
                      textlabel: 'Password',
                      texteditingcontroller: passwordController,
                      isobsure: true,
                      iconData: Icons.visibility_off_outlined,
                    ),
                    const SizedBox(height: 12),
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
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(_createRoute());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColorCode.secondaryColor_500,
                          padding: const EdgeInsets.symmetric(vertical: 22),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Don’t have an account?',
                            style: TextStyle(fontSize: 14),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) => const SignUpScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Sign up',
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
      ),
    );
  }
}

// Custom Page Route Transition
Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        BottomNavigationScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
