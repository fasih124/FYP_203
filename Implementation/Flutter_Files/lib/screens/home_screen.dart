// home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body:  Center(
        child: SvgPicture.asset(
          'assets/images/baby_onboard_screen_1.svg',
          width: 200,
          height: 200,
        )
        ,

      ),
    );
  }
}
