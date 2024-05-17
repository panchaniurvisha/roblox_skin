import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roblox_skin/constants/colors.dart';

class Bg extends HookWidget {
  final Widget child;

  const Bg({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 1.sh,
          width: 1.sw,
          decoration: const BoxDecoration(color: bgColor1),
        ),
        Positioned(
          top: -50.h,
          right: -120.w,
          child: Container(
            height: 300.h,
            width: 300.h,
            decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [BoxShadow(color: bgColor2.withOpacity(.8), blurRadius: 160)]),
          ),
        ),
        child
      ],
    );
  }
}
