import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/features/dashboard/screens/dashboard_screen.dart';
import 'package:food_app/services/f_auth.dart';

import '../../features/onboarding/login/screens/login_screen.dart';
import '../../utils/app_images.dart';
import '../../utils/custom_route.dart';
import '../../utils/appstyles.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    Future.delayed(const Duration(seconds: 5), (() {
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: ((context) => const DashBoardScreen())));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: ((context) => const LoginScreen())));
      }
    }));

    //CustomNavigation().pushReplacement(
    // context: context,
    // route: CustomRoute().downToUp(const LoginScreen()))

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(),
          ClipOval(
            child: Image.asset(
              AppImages.appLogo,
              // scale: 3,
            ),
          ),
          // AnimatedTextKit(repeatForever: true, animatedTexts: [
          //   ColorizeAnimatedText('Elliott Food'.toUpperCase(),
          //       textStyle: const TextStyle(fontSize: 50),
          //       colors: colorizeColors)
          // ]),
          Text(
            'Student ID Number: 19058892',
            style: TextStyles.semiBold(20, AppColors.black),
          ),
        ],
      ),
    );
  }
}
