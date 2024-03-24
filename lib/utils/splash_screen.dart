import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:space_pod/pages/home_page.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Center(
            child: Lottie.asset("assets/animination/Start_animation.json"),
          )
        ],
      ),
      nextScreen: HomePage(),
      splashIconSize: 400,
      backgroundColor: Colors.black,
    );
  }
}
