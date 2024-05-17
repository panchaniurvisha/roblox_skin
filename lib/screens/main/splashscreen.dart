import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roblox_skin/constants/colors.dart';
import 'package:roblox_skin/generated/assets.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1.sh,
        width: 1.sw,
        decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [bgColor3, bgColor1], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              Assets.imagesSplash1,
              height: 250.h,
            ),
            Image.asset(Assets.imagesSplash)
          ],
        ),
      ),
    );
  }
}
