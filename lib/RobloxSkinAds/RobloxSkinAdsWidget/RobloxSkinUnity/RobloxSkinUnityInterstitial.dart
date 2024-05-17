import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

import '../../RobloxSkinAdsMainJson/RobloxSkinAdsMainJson.dart';

class RobloxSkinUnityInterstitial {
  void loadAd({required BuildContext context, required Function() onLoaded, required Function() onComplete, required Function() onFailed}) {
    RobloxskinMainJson robloxskinMainJson = context.read<RobloxskinMainJson>();
    UnityAds.load(
      placementId: '${robloxskinMainJson.data!['adIds']['unity']['placementId']}',
      onComplete: (placementId) {
        onLoaded();
        UnityAds.showVideoAd(
          placementId: '${robloxskinMainJson.data!['adIds']['unity']['placementId']}',
          onStart: (placementId) {},
          onClick: (placementId) {},
          onSkipped: (placementId) {
            onComplete();
          },
          onComplete: (placementId) {
            onComplete();
          },
          onFailed: (placementId, error, message) {
            onFailed();
          },
        );
      },
      onFailed: (placementId, error, message) {},
    );
  }
}
