import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import '../../../RobloxSkinAdsLoader/RobloxSkinAdLoaderProvider.dart';
import '../../../RobloxSkinAdsMainJson/RobloxSkinAdsMainJson.dart';

class RobloxSkinGoogleRewarded {
  RewardedAd? _rewardedAd;

  void loadAd({required BuildContext context, required Function() onLoaded, required Function() onComplete, required Function() onFailed}) {
    RobloxskinMainJson robloxskinMainJson = context.read<RobloxskinMainJson>();

    RewardedAd.load(
      adUnitId: '${robloxskinMainJson.data!['adIds']['google']['reward']}',
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;

          _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
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
          _rewardedAd!.show(
            onUserEarnedReward: (ad, reward) {
              onComplete();
              ad.dispose();
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          onFailed();
        },
      ),
    );
  }
}
