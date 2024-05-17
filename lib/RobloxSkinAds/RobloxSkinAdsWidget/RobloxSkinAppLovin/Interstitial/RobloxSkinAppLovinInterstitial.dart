import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../RobloxSkinAdsMainJson/RobloxSkinAdsMainJson.dart';

class RobloxSkinAppLovinInterstitial {
  void loadAd(
      {required BuildContext context,
      required Function() onLoaded,
      required Function() onComplete,
      required Function() onFailed}) {
    RobloxskinMainJson robloxskinMainJson = context.read<RobloxskinMainJson>();

    AppLovinMAX.setInterstitialListener(InterstitialListener(
      onAdLoadedCallback: (ad) async {
        bool isReady = (await AppLovinMAX.isInterstitialReady(
          robloxskinMainJson.data!['adIds']['applovin']['fullScreen'],
        ))!;
        if (isReady) {
          onLoaded();
          AppLovinMAX.showInterstitial(
            robloxskinMainJson.data!['adIds']['applovin']['fullScreen'],
          );
        }
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        onFailed();
      },
      onAdDisplayedCallback: (ad) {},
      onAdDisplayFailedCallback: (ad, error) {},
      onAdClickedCallback: (ad) {},
      onAdHiddenCallback: (ad) {
        onComplete();
      },
    ));

    AppLovinMAX.loadInterstitial(
        robloxskinMainJson.data!['adIds']['applovin']['fullScreen']);
  }
}
