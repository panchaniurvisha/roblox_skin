import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../../RobloxSkinAdsMainJson/RobloxSkinAdsMainJson.dart';

class RobloxSkinGoogleNative extends HookWidget {
  const RobloxSkinGoogleNative({super.key});

  @override
  Widget build(BuildContext context) {
    final RobloxSkinNativeAd = useState<NativeAd?>(null);
    final RobloxSkinNativeAdIsLoaded = useState<bool>(false);
    final RobloxSkinNativeWidget = useState<AdWidget?>(null);

    RobloxskinMainJson robloxskinMainJson = context.read<RobloxskinMainJson>();

    loadAd() {
      RobloxSkinNativeAd.value = NativeAd(
        adUnitId: '${robloxskinMainJson.data!['adIds']['google']['native']}',
        factoryId: 'adFactoryExample',
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            RobloxSkinNativeAdIsLoaded.value = true;
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
          },
          onAdClicked: (ad) {},
          onAdImpression: (ad) {},
          onAdClosed: (ad) {},
          onAdOpened: (ad) {},
          onAdWillDismissScreen: (ad) {},
          onPaidEvent: (ad, valueMicros, precision, currencyCode) {},
        ),
        request: const AdRequest(),
      );
      RobloxSkinNativeAd.value!.load();
      RobloxSkinNativeWidget.value = AdWidget(ad: RobloxSkinNativeAd.value!);
    }

    useEffect(() {
      loadAd();
      return () {};
    }, []);
    return RobloxSkinNativeAdIsLoaded.value
        ? Container(
            margin: const EdgeInsets.all(10.0),
            constraints: const BoxConstraints(minHeight: 270, maxHeight: 320),
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            alignment: Alignment.center,
            width: double.infinity,
            child: RobloxSkinNativeWidget.value,
          )
        : const SizedBox.shrink();
  }
}
