import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import 'RobloxSkinAdLoaderProvider.dart';

class RobloxSkinAdLoader extends HookWidget {
  final Widget child;

  const RobloxSkinAdLoader({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    RobloxSkinAdLoaderProvider robloxSkinAdLoaderProvider =
        context.watch<RobloxSkinAdLoaderProvider>();
    return Material(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          fit: StackFit.expand,
          children: [
            child,
            robloxSkinAdLoaderProvider.isAdLoading
                ? Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: LoadingAnimationWidget.hexagonDots(
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 0,
                    width: 0,
                  ),
          ],
        ),
      ),
    );
  }
}
