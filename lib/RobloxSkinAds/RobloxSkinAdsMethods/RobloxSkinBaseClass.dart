import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/material.dart';
import 'package:ironsource_adpluginx/ironsource_adpluginx.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'package:user_messaging_platform/user_messaging_platform.dart';

import '../RobloxSkinAdsMainJson/RobloxSkinAdsMainJson.dart';
import '../RobloxSkinAdsWidget/RobloxSkinIronSource/InitListner.dart';
import 'RobloxSkinGoogleInit.dart';

class RobloxSkinBaseClass {
  Future<void> initAdNetworks(
      {required BuildContext context,
      required Function() onInitComplete}) async {
    RobloxskinMainJson robloxskinMainJson = context.read<RobloxskinMainJson>();

    await RobloxSkinGoogleInit().onInit();
    await AppLovinMAX.initialize(
      robloxskinMainJson.data!['adIds']['applovin']['id'] != ""
          ? robloxskinMainJson.data!['adIds']['applovin']['id']
          : "xiAs_Fs3BiExPelVuawzyDTU2Sy4GL2d6KB1c7C1loiv64T5oquTwRRIJbHC3qO0qRI_65NChIkGy3U2i6rWXn",
    );
    Logger().d("ApplovinMAX initialized");
    try {
      await IronSource.init(
        appKey: robloxskinMainJson.data!['adIds']['ironSource']['appId'],
        adUnits: [
          IronSourceAdUnit.Interstitial,
          IronSourceAdUnit.Banner,
          IronSourceAdUnit.RewardedVideo,
        ],
        initListener: InitListener(),
      );
      Logger().d("IronSource initialized");
    } catch (e) {
      Logger().d("IronSource Error: $e");
    }
    await UnityAds.init(
      testMode: true,
      gameId: robloxskinMainJson.data!['adIds']['unity']['gameId'],
      onComplete: () {
        Logger().d("UnityAds initialized");
      },
      onFailed: (error, message) {
        Logger().d("UnityAds Error: $error");
      },
    );

    Future.delayed(const Duration(milliseconds: 400), () {
      onInitComplete();
    });
  }

  Future<void> showUserMessage() async {
    var info = await UserMessagingPlatform.instance.requestConsentInfoUpdate();
    if (info.consentStatus == ConsentStatus.required) {
      await UserMessagingPlatform.instance.showConsentForm();
      await AppTrackingTransparency.requestTrackingAuthorization();
    } else {
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }
}
