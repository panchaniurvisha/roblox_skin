import 'package:flutter/material.dart';
import 'RobloxSkinBanner.dart';

class RobloxSkinBannerWrapper extends StatelessWidget {
  final Widget child;
  final BuildContext parentContext;

  const RobloxSkinBannerWrapper({
    super.key,
    required this.child,
    required this.parentContext,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
            child: child,
          ),
          RobloxSkinBanner(
            parentContext: parentContext,
          ),
        ],
      ),
    );
  }
}
