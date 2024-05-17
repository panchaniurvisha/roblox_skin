import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roblox_skin/RobloxSkinAds/RobloxSkinAds/RobloxSkinNative/RobloxSkinNative.dart';
import 'package:roblox_skin/RobloxSkinAds/RobloxSkinAdsUtils/RobloxSkinAdsExtensions.dart';
import 'package:roblox_skin/constants/colors.dart';
import 'package:roblox_skin/generated/assets.dart';
import 'package:roblox_skin/screens/skins/skinsdetail.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../../constants/utils.dart';

class Skins extends HookWidget {
  const Skins({super.key});

  @override
  Widget build(BuildContext context) {
    var boy = useState([
      {"title": "Boy", "image": Assets.imagesSkin1},
      {"title": "Boy Sweater", "image": Assets.imagesSkin2},
      {"title": "Boy T-Shirt", "image": Assets.imagesSkin3},
      {"title": "Boy Classic Shirt", "image": Assets.imagesSkin4},
      {"title": "Boy Classic Pant", "image": Assets.imagesSkin5}
    ]);
    var girl = useState([
      {"title": "Girl", "image": Assets.imagesSkin6},
      {"title": "Girl Sweater", "image": Assets.imagesSkin7},
      {"title": "Girl T-Shirt", "image": Assets.imagesSkin8},
      {"title": "Girl Classic Shirt", "image": Assets.imagesSkin9},
      {"title": "Girl Classic Pant", "image": Assets.imagesSkin10}
    ]);

    useEffect(() {
      return () {};
    }, []);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const AutoSizeText("Skins"),
      ),
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                decoration: BoxDecoration(
                  border: Border.all(color: white, width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.w),
                        child: SizedBox(
                          height: 40.h,
                          child: const AutoSizeText(
                            "Boys",
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                      ),
                    ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: boy.value.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isIpad ? 3 : 2, childAspectRatio: 1 / 1.25),
                      itemBuilder: (context, boyIndex) {
                        return GestureDetector(
                          onTap: () {
                            "skins".RobloxSkinPerformScreenAction(
                                context: context,
                                onComplete: () {
                                  switch (boyIndex) {
                                    case 0:
                                      Navigator.pushNamed(context, SkinsDetail.routeName, arguments: "boy");
                                      break;
                                    case 1:
                                      Navigator.pushNamed(context, SkinsDetail.routeName, arguments: "bs");
                                      break;
                                    case 2:
                                      Navigator.pushNamed(context, SkinsDetail.routeName, arguments: "bts");
                                      break;
                                    case 3:
                                      Navigator.pushNamed(context, SkinsDetail.routeName, arguments: "bcs");
                                      break;
                                    case 4:
                                      Navigator.pushNamed(context, SkinsDetail.routeName, arguments: "bcp");
                                      break;
                                  }
                                });
                          },
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10.w, top: 55.h, right: 10.w, bottom: 10.h),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: bgColor3,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: const [
                                      BoxShadow(color: black, offset: Offset(3, 3), blurRadius: 5, spreadRadius: 0)
                                    ],
                                  ),
                                ),
                              ),
                              SimpleShadow(
                                color: black,
                                offset: const Offset(5, 5),
                                sigma: 3,
                                child: SizedBox(
                                  height: 140.h,
                                  child: Image.asset(boy.value[boyIndex]['image']!),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20.w, bottom: 12.h, right: 20.w),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 60.h,
                                        width: isIpad ? 60.w : 100.w,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: AutoSizeText(
                                            boy.value[boyIndex]['title']!,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: white,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              RobloxSkinNative(parentContext: context),
              SizedBox(
                height: 10.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                decoration: BoxDecoration(
                  border: Border.all(color: white, width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.w),
                        child: SizedBox(
                          height: 40.h,
                          child: const AutoSizeText(
                            "Girls",
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                      ),
                    ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: girl.value.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isIpad ? 3 : 2, childAspectRatio: 1 / 1.25),
                      itemBuilder: (context, girlIndex) {
                        return GestureDetector(
                          onTap: () {
                            "skins".RobloxSkinPerformScreenAction(
                                context: context,
                                onComplete: () {
                                  switch (girlIndex) {
                                    case 0:
                                      Navigator.pushNamed(context, SkinsDetail.routeName, arguments: "girl");
                                      break;
                                    case 1:
                                      Navigator.pushNamed(context, SkinsDetail.routeName, arguments: "gs");
                                      break;
                                    case 2:
                                      Navigator.pushNamed(context, SkinsDetail.routeName, arguments: "gts");
                                      break;
                                    case 3:
                                      Navigator.pushNamed(context, SkinsDetail.routeName, arguments: "gcs");
                                      break;
                                    case 4:
                                      Navigator.pushNamed(context, SkinsDetail.routeName, arguments: "gcp");
                                      break;
                                  }
                                });
                          },
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10.w, top: 55.h, right: 10.w, bottom: 10.h),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: bgColor3,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: const [
                                      BoxShadow(color: black, offset: Offset(3, 3), blurRadius: 5, spreadRadius: 0)
                                    ],
                                  ),
                                ),
                              ),
                              SimpleShadow(
                                color: black,
                                offset: const Offset(5, 5),
                                sigma: 3,
                                child: SizedBox(
                                  height: 140.h,
                                  child: Image.asset(girl.value[girlIndex]['image']!),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20.w, bottom: 12.h, right: 20.w),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 60.h,
                                        width: isIpad ? 60.w : 100.w,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: AutoSizeText(
                                            girl.value[girlIndex]['title']!,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: white,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 120.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
