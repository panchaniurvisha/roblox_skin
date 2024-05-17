import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../../RobloxSkinAdsMainJson/RobloxSkinAdsMainJson.dart';

class RobloxSkinGoogleBanner extends HookWidget {
  const RobloxSkinGoogleBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final RobloxSkinBannerAd = useState<BannerAd?>(null);
    final RobloxSkinBannerIsLoading = useState<bool>(true);
    final RobloxSkinBannerIsFailed = useState<bool>(true);
    final RobloxSkinBannerWidget = useState<AdWidget?>(null);

    RobloxskinMainJson robloxskinMainJson = context.read<RobloxskinMainJson>();

    loadAd() {
      RobloxSkinBannerAd.value = BannerAd(
        adUnitId: '${robloxskinMainJson.data!['adIds']['google']['banner']}',
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');

            RobloxSkinBannerIsLoading.value = false;
            RobloxSkinBannerIsFailed.value = false;
          },
          onAdFailedToLoad: (ad, error) {
            RobloxSkinBannerIsLoading.value = false;
            RobloxSkinBannerIsFailed.value = true;
            debugPrint('BannerAd failed to load: $error');

            ad.dispose();
          },

          onAdOpened: (Ad ad) {},

          onAdClosed: (Ad ad) {},

          onAdImpression: (Ad ad) {},
        ),
      );

      RobloxSkinBannerAd.value!.load();
      RobloxSkinBannerWidget.value = AdWidget(ad: RobloxSkinBannerAd.value!);
    }

    useEffect(() {
      loadAd();
      return () {};
    }, []);
    return RobloxSkinBannerIsFailed.value
        ? const SizedBox(
            height: 0,
            width: 0,
          )
        : RobloxSkinBannerIsLoading.value
            ? const SizedBox(
                height: 0,
                width: 0,
              )
            : Container(
                alignment: Alignment.center,
                width: RobloxSkinBannerAd.value!.size.width.toDouble(),
                height: RobloxSkinBannerAd.value!.size.height.toDouble(),
                child: RobloxSkinBannerWidget.value,
              );
  }
}
