import 'package:ad_gridview/ad_gridview.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hash_cached_image/hash_cached_image.dart';
import 'package:provider/provider.dart';
import 'package:roblox_skin/RobloxSkinAds/RobloxSkinAds/RobloxSkinNative/RobloxSkinNative.dart';
import 'package:roblox_skin/RobloxSkinAds/RobloxSkinAdsUtils/RobloxSkinAdsExtensions.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../../constants/colors.dart';
import '../../constants/utils.dart';
import '../../provider/data/data_provider.dart';
import '../skins/skinsdetail.dart';

class Pets extends HookWidget {
  const Pets({super.key});

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = context.watch<DataProvider>();

    useEffect(() {
      return () {};
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText("Pets"),
      ),
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AdGridView(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: isIpad ? 3 : 2,
                itemCount: dataProvider.pet.length,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                adIndex: 1,
                itemMainAspectRatio: 1.25 / 1,
                adWidget: RobloxSkinNative(parentContext: context),
                itemWidget: (context, petIndex) {
                  return GestureDetector(
                    onTap: () {
                      "pets".RobloxSkinPerformScreenAction(
                          context: context,
                          onComplete: () {
                            dataProvider.petCategoryIndex = petIndex;
                            Navigator.pushNamed(context, SkinsDetail.routeName, arguments: "petcategory");
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
                            child: HashCachedImage(imageUrl: dataProvider.pet[petIndex]['image']),
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
                                      dataProvider.pet[petIndex]['Name'],
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
