
import 'package:ironsource_adpluginx/ironsource_adpluginx.dart';

class RobloxSkinIronSourceInterstitial with LevelPlayInterstitialListener {
  Function() onComplete;
  Function() onFailed;
  Function() onLoaded;

  RobloxSkinIronSourceInterstitial.onInit(
      {required this.onComplete,
      required this.onFailed,
      required this.onLoaded});

  @override
  void onAdClicked(IronSourceAdInfo adInfo) {}

  @override
  void onAdClosed(IronSourceAdInfo adInfo) {
    onComplete();
  }

  @override
  void onAdLoadFailed(IronSourceError error) {
    onFailed();
  }

  @override
  void onAdOpened(IronSourceAdInfo adInfo) {
    // TODO: implement onAdOpened
  }

  @override
  void onAdReady(IronSourceAdInfo adInfo) {
    onLoaded();
  }

  @override
  void onAdShowFailed(IronSourceError error, IronSourceAdInfo adInfo) {
    onFailed();
  }

  @override
  void onAdShowSucceeded(IronSourceAdInfo adInfo) {
  }
}
