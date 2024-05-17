import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:roblox_skin/RobloxSkinAds/RobloxSkinAdsMainJson/RobloxSkinAdsMainJson.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/colors.dart';

class Settings extends HookWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    var name = useState(["Privacy Policy", "Contact Us", "Share App", "Rate Us"]);

    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText("Settings"),
      ),
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          itemCount: name.value.length,
          itemBuilder: (context, index) {
            return Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () async {
                    switch (index) {
                      case 0:
                        var url = Uri.parse(context.read<RobloxskinMainJson>().data!['assets']['privacyPolicy']);
                        await launchUrl(url, mode: LaunchMode.externalApplication);
                        break;
                      case 1:
                        var url = Uri.parse(context.read<RobloxskinMainJson>().data!['assets']['contactUs']);
                        await launchUrl(url, mode: LaunchMode.externalApplication);
                        break;
                      case 2:
                        final box = context.findRenderObject() as RenderBox?;

                        await Share.share(
                          '${context.read<RobloxskinMainJson>().data!['assets']['shareApp']}',
                          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
                        );
                        break;
                      case 3:
                        var url = Uri.parse(context.read<RobloxskinMainJson>().data!['assets']['rateUs']);
                        await launchUrl(url, mode: LaunchMode.externalApplication);
                        break;
                    }
                  },
                  child: Container(
                    height: 60.h,
                    width: 320.w,
                    margin: EdgeInsets.symmetric(vertical: 8.h),
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(15),
                      border: Border.all(color: white, width: 2.5),
                    ),
                    child: Center(
                      child: AutoSizeText(
                        name.value[index],
                        maxLines: 1,
                        style: const TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
