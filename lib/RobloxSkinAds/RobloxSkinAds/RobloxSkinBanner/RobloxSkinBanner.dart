import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../../RobloxSkinAdsMainJson/RobloxSkinAdsMainJson.dart';
import '../../RobloxSkinAdsWidget/RobloxSkinGoogle/Banner/RobloxSkinGoogleBanner.dart';

class RobloxSkinBanner extends HookWidget {
  final BuildContext parentContext;

  const RobloxSkinBanner({required this.parentContext, super.key});

  @override
  Widget build(BuildContext context) {
    RobloxskinMainJson robloxskinMainJson = context.read<RobloxskinMainJson>();
    final RobloxSkinBannerWidget = useState<Widget>(const SizedBox(
      height: 0,
      width: 0,
    ));

    showAd() {
      if ((robloxskinMainJson.data![robloxskinMainJson.version]['robloxskinGlobalConfig']
                  ['robloxskinGlobalAdFlag'] ??
              false) ==
          false) {
        RobloxSkinBannerWidget.value = const SizedBox(
          height: 0,
          width: 0,
        );
        return;
      }
      if ((robloxskinMainJson.data![robloxskinMainJson.version]['robloxskinGlobalConfig']
                  ['robloxskinGlobalBanner'] ??
              false) ==
          false) {
        RobloxSkinBannerWidget.value = const SizedBox(
          height: 0,
          width: 0,
        );
        return;
      }
      if ((robloxskinMainJson.data![robloxskinMainJson.version]['screens']
                      [ModalRoute.of(parentContext)?.settings.name]
                  ['robloxskinLocalAdFlag'] ??
              false) ==
          false) {
        RobloxSkinBannerWidget.value = const SizedBox(
          height: 0,
          width: 0,
        );
        return;
      }
      switch (robloxskinMainJson.data![robloxskinMainJson.version]['screens']
          [ModalRoute.of(parentContext)?.settings.name]['robloxskinBanner']) {
        case 0:
          RobloxSkinBannerWidget.value = const RobloxSkinGoogleBanner();
          break;
        default:
          RobloxSkinBannerWidget.value = const SizedBox(
            height: 0,
            width: 0,
          );
          break;
      }
    }

    useEffect(() {
      showAd();
      return () {};
    }, []);
    return RobloxSkinBannerWidget.value;
  }
}
