import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../../RobloxSkinAdsLoader/RobloxSkinAdLoaderProvider.dart';
import '../../../RobloxSkinAdsMainJson/RobloxSkinAdsMainJson.dart';

class RobloxSkinGoogleRewardedInterstitial {
  RewardedInterstitialAd? _rewardeInterstitialdAd;

  void loadAd({required BuildContext context, required Function() onLoaded, required Function() onComplete, required Function() onFailed}) {
    RobloxskinMainJson robloxskinMainJson = context.read<RobloxskinMainJson>();
    RewardedInterstitialAd.load(
        adUnitId: '${robloxskinMainJson.data!['adIds']['google']['rewardInter']}',
        request: const AdRequest(),
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            _rewardeInterstitialdAd = ad;
            _rewardeInterstitialdAd!.fullScreenContentCallback = FullScreenContentCallback(
                onAdShowedFullScreenContent: (ad) {},
                onAdImpression: (ad) {},
                onAdFailedToShowFullScreenContent: (ad, err) {
                  onFailed();
                  ad.dispose();
                },
                onAdDismissedFullScreenContent: (ad) {
                  if (robloxskinMainJson.data![robloxskinMainJson.version]['robloxskinGlobalConfig']['robloxskinRewardOverRide']) {
                    onComplete();
                  }
                  context.read<RobloxSkinAdLoaderProvider>().isAdLoading = false;
                  ad.dispose();
                },
                onAdClicked: (ad) {});
            onLoaded();
            _rewardeInterstitialdAd!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
              onComplete();
              ad.dispose();
            });
          },
          onAdFailedToLoad: (LoadAdError error) {
            onFailed();
          },
        ));
  }
}
