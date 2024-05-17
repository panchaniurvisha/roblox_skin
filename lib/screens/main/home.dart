import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roblox_skin/RobloxSkinAds/RobloxSkinAds/RobloxSkinBanner/RobloxSkinBannerWrapper.dart';
import 'package:roblox_skin/constants/colors.dart';
import 'package:roblox_skin/generated/assets.dart';
import 'package:roblox_skin/screens/codes/codes.dart';
import 'package:roblox_skin/screens/games/games.dart';
import 'package:roblox_skin/screens/main/settings.dart';
import 'package:roblox_skin/screens/pets/pets.dart';
import 'package:roblox_skin/screens/skins/skins.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class Home extends HookWidget {
  static const routeName = '/Home';

  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var screenIndex = useState(0);
    var screenList = useState([const Skins(), const Pets(), const Games(), const Codes(), const Settings()]);
    useEffect(() {
      return () {};
    }, []);

    return Scaffold(
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: Stack(
          children: [
            screenList.value[screenIndex.value],
            Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    height: 95.h,
                    child: WaveWidget(
                      config: CustomConfig(
                        colors: [bgColor5, bgColor4, bgColor3],
                        durations: [8000, 4500, 10000],
                        heightPercentages: [.0, .03, .05],
                      ),
                      backgroundColor: Colors.transparent,
                      size: Size(double.infinity, 120.h),
                      waveAmplitude: 0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          screenIndex.value = 0;
                        },
                        child: SizedBox(
                          height: 80.h,
                          width: 70.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              0 == screenIndex.value
                                  ? Image.asset(
                                      Assets.imagesSkins,
                                      height: 25.h,
                                      color: white,
                                    ).animate().slideX()
                                  : Image.asset(
                                      Assets.imagesSkins,
                                      height: 25.h,
                                      color: white.withOpacity(.6),
                                    ),
                              SizedBox(
                                height: 25.h,
                                width: 60.w,
                                child: Center(
                                  child: 0 == screenIndex.value
                                      ? const AutoSizeText(
                                          "Skins",
                                          style: TextStyle(
                                            color: white,
                                          ),
                                        ).animate().slideY()
                                      : AutoSizeText(
                                          "Skins",
                                          style: TextStyle(
                                            color: white.withOpacity(.6),
                                          ),
                                        ),
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          screenIndex.value = 1;
                        },
                        child: SizedBox(
                          height: 80.h,
                          width: 70.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              1 == screenIndex.value
                                  ? Image.asset(
                                      Assets.imagesPet,
                                      height: 25.h,
                                      color: white,
                                    ).animate().slideX()
                                  : Image.asset(
                                      Assets.imagesPet,
                                      height: 25.h,
                                      color: white.withOpacity(.6),
                                    ),
                              SizedBox(
                                height: 25.h,
                                width: 60.w,
                                child: Center(
                                  child: 1 == screenIndex.value
                                      ? const AutoSizeText(
                                          "Pets",
                                          style: TextStyle(
                                            color: white,
                                          ),
                                        ).animate().slideY()
                                      : AutoSizeText(
                                          "Pets",
                                          style: TextStyle(
                                            color: white.withOpacity(.6),
                                          ),
                                        ),
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          screenIndex.value = 2;
                        },
                        child: SizedBox(
                          height: 80.h,
                          width: 70.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              2 == screenIndex.value
                                  ? Image.asset(
                                      Assets.imagesGame,
                                      height: 25.h,
                                      color: white,
                                    ).animate().slideX()
                                  : Image.asset(
                                      Assets.imagesGame,
                                      height: 25.h,
                                      color: white.withOpacity(.6),
                                    ),
                              SizedBox(
                                height: 25.h,
                                width: 60.w,
                                child: Center(
                                  child: 2 == screenIndex.value
                                      ? const AutoSizeText(
                                          "Games",
                                          style: TextStyle(
                                            color: white,
                                          ),
                                        ).animate().slideY()
                                      : AutoSizeText(
                                          "Games",
                                          style: TextStyle(
                                            color: white.withOpacity(.6),
                                          ),
                                        ),
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          screenIndex.value = 3;
                        },
                        child: SizedBox(
                          height: 80.h,
                          width: 70.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              3 == screenIndex.value
                                  ? Image.asset(
                                      Assets.imagesCode,
                                      height: 25.h,
                                      color: white,
                                    ).animate().slideX()
                                  : Image.asset(
                                      Assets.imagesCode,
                                      height: 25.h,
                                      color: white.withOpacity(.6),
                                    ),
                              SizedBox(
                                height: 25.h,
                                width: 60.w,
                                child: Center(
                                  child: 3 == screenIndex.value
                                      ? const AutoSizeText(
                                          "Codes",
                                          style: TextStyle(
                                            color: white,
                                          ),
                                        ).animate().slideY()
                                      : AutoSizeText(
                                          "Codes",
                                          style: TextStyle(
                                            color: white.withOpacity(.6),
                                          ),
                                        ),
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          screenIndex.value = 4;
                        },
                        child: SizedBox(
                          height: 80.h,
                          width: 70.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              4 == screenIndex.value
                                  ? Image.asset(
                                      Assets.imagesSettings,
                                      height: 25.h,
                                      color: white,
                                    ).animate().slideX()
                                  : Image.asset(
                                      Assets.imagesSettings,
                                      height: 25.h,
                                      color: white.withOpacity(.6),
                                    ),
                              SizedBox(
                                height: 25.h,
                                width: 60.w,
                                child: Center(
                                  child: 4 == screenIndex.value
                                      ? const AutoSizeText(
                                          "Settings",
                                          style: TextStyle(
                                            color: white,
                                          ),
                                        ).animate().slideY()
                                      : AutoSizeText(
                                          "Settings",
                                          style: TextStyle(
                                            color: white.withOpacity(.6),
                                          ),
                                        ),
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
