import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import '../../RobloxSkinAdsMainJson/RobloxSkinAdsMainJson.dart';
import '../../RobloxSkinAdsWidget/RobloxSkinGoogle/Native/RobloxSkinGoogleNative.dart';

class RobloxSkinNative extends HookWidget {
  final BuildContext parentContext;

  const RobloxSkinNative({required this.parentContext, super.key});

  @override
  Widget build(BuildContext context) {
    final RobloxSkinNativeWidget = useState<Widget>(const SizedBox(
      height: 0,
      width: 0,
    ));

    showAd() {
      RobloxskinMainJson robloxskinMainJson = context.read<RobloxskinMainJson>();
      if ((robloxskinMainJson.data![robloxskinMainJson.version]['robloxskinGlobalConfig']['robloxskinGlobalAdFlag'] ?? false) == false) {
        RobloxSkinNativeWidget.value = const SizedBox(
          height: 0,
          width: 0,
        );
        return;
      }
      if ((robloxskinMainJson.data![robloxskinMainJson.version]['robloxskinGlobalConfig']['robloxskinGlobalNative'] ?? false) == false) {
        RobloxSkinNativeWidget.value = const SizedBox(
          height: 0,
          width: 0,
        );
        return;
      }
      if ((robloxskinMainJson.data![robloxskinMainJson.version]['screens'][ModalRoute.of(parentContext)?.settings.name]['robloxskinLocalAdFlag'] ?? false) == false) {
        RobloxSkinNativeWidget.value = const SizedBox(
          height: 0,
          width: 0,
        );
        return;
      }
      switch (robloxskinMainJson.data![robloxskinMainJson.version]['screens'][ModalRoute.of(parentContext)?.settings.name]['robloxskinNative']) {
        case 0:
          RobloxSkinNativeWidget.value = const RobloxSkinGoogleNative();
          break;
        default:
          RobloxSkinNativeWidget.value = const SizedBox(
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
    return RobloxSkinNativeWidget.value;
  }
}
