import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_point/core/theme/app_theme.dart';
import 'package:pin_point/features/map/map_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Center(
            child: LottieBuilder.asset(
              "assets/lottie/loading.json",
              width: 300,
              height: 300,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            'Pin Point',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ],
      ),
      nextScreen: const MapScreen(),
      splashIconSize: 400,
      duration: 3000,
      backgroundColor: AppTheme.backgroundColor,
    );
  }
}
