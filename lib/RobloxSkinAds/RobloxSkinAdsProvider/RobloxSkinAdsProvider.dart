import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../RobloxSkinAdsLoader/RobloxSkinAdLoaderProvider.dart';
import '../RobloxSkinAdsMainJson/RobloxSkinAdsMainJson.dart';

class RobloxSkinAdsProvider extends StatelessWidget {
  final Widget child;

  const RobloxSkinAdsProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RobloxskinMainJson(),
        ),
        ChangeNotifierProvider(
          create: (context) => RobloxSkinAdLoaderProvider(),
        )
      ],
      child: child,
    );
  }
}
