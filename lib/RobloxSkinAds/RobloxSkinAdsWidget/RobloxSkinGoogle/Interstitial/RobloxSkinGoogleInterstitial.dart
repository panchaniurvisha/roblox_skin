import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../../RobloxSkinAdsMainJson/RobloxSkinAdsMainJson.dart';

class RobloxSkinGoogleInterstitial {
  InterstitialAd? interstitialAd;

  loadAd(
      {required BuildContext context,
      required Function() onLoaded,
      required Function() onComplete,
      required Function() onFailed}) {
    RobloxskinMainJson robloxskinMainJson = context.read<RobloxskinMainJson>();
    InterstitialAd.load(
        adUnitId: '${robloxskinMainJson.data!['adIds']['google']['fullScreen']}',
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                onAdShowedFullScreenContent: (ad) {},
                onAdImpression: (ad) {},
                onAdFailedToShowFullScreenContent: (ad, err) {
                  onFailed();
                  ad.dispose();
                },
                onAdDismissedFullScreenContent: (ad) {
                  onComplete();

                  ad.dispose();
                },
                onAdClicked: (ad) {});

            interstitialAd = ad;
            onLoaded();
            interstitialAd!.show();
          },
          onAdFailedToLoad: (LoadAdError error) {
            onFailed();
          },
        ));
  }
}
