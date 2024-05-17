import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hash_cached_image/hash_cached_image.dart';
import 'package:provider/provider.dart';
import 'package:roblox_skin/RobloxSkinAds/RobloxSkinAdsMainJson/RobloxSkinAdsMainJson.dart';
import 'package:roblox_skin/RobloxSkinAds/RobloxSkinAdsUtils/RobloxSkinAdsExtensions.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/colors.dart';
import '../../constants/utils.dart';
import '../../provider/data/data_provider.dart';

class Games extends HookWidget {
  const Games({super.key});

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = context.watch<DataProvider>();
    var selectedCategoryIndex = useState(0);
    var selectedGameIndex = useState(0);
    var itemScrollController = useState(ItemScrollController());
    var isOpen = useState(true);
    useEffect(() {
      return () {};
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText("Games"),
        centerTitle: true,
      ),
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: Column(
          children: [
            SizedBox(
              height: 5.h,
            ),
            SizedBox(
              height: 35.h,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: dataProvider.game.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      "gameCategory".RobloxSkinPerformScreenAction(
                          context: context,
                          onComplete: () {
                            selectedCategoryIndex.value = index;
                          });
                    },
                    child: Container(
                      height: 30.h,
                      margin: EdgeInsets.symmetric(horizontal: 7.w),
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: selectedCategoryIndex.value == index ? bgColor5 : Colors.transparent,
                        borderRadius: BorderRadiusDirectional.circular(40),
                        border: Border.all(color: selectedCategoryIndex.value == index ? bgColor5 : white, width: 2.5),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(dataProvider.game[index]['category'], maxLines: 1),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isOpen.value
                    ? Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          child: Container(
                            height: isIpad ? 500.h : 440.h,
                            width: 120.w,
                            decoration: const BoxDecoration(
                              color: bgColor1,
                            ),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    itemScrollController.value.jumpTo(index: selectedGameIndex.value);
                                  },
                                  child: Container(
                                    height: 40.h,
                                    width: 120.w,
                                    decoration: const BoxDecoration(color: bgColor3),
                                    child: const Icon(
                                      Icons.keyboard_arrow_up_rounded,
                                      size: 40,
                                      color: white,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ScrollablePositionedList.builder(
                                    physics: const ClampingScrollPhysics(),
                                    itemScrollController: itemScrollController.value,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount: dataProvider.game[selectedCategoryIndex.value]['data'].length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          index == 0
                                              ? Container(
                                                  width: 120.w,
                                                  height: 25.h,
                                                  decoration: BoxDecoration(
                                                    color: bgColor3,
                                                    borderRadius: BorderRadius.only(
                                                      bottomRight: Radius.circular(selectedGameIndex.value == 0 ? 15 : 0),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          GestureDetector(
                                            onTap: () {
                                              "game".RobloxSkinPerformScreenAction(
                                                  context: context,
                                                  onComplete: () {
                                                    selectedGameIndex.value = index;
                                                    isOpen.value = false;
                                                  });
                                            },
                                            child: Container(
                                              width: 120.w,
                                              decoration: BoxDecoration(
                                                color: bgColor3,
                                                borderRadius: BorderRadius.only(
                                                    bottomRight: Radius.circular(selectedGameIndex.value - 1 == index ? 15 : 0),
                                                    topRight: Radius.circular(selectedGameIndex.value + 1 == index ? 15 : 0)),
                                              ),
                                              child: Container(
                                                margin: EdgeInsets.only(left: selectedGameIndex.value == index ? 10.w : 0),
                                                decoration: BoxDecoration(
                                                  color: selectedGameIndex.value == index ? bgColor1 : Colors.transparent,
                                                  borderRadius: const BorderRadius.horizontal(
                                                    left: Radius.circular(15),
                                                  ),
                                                ),
                                                child: SizedBox(
                                                  height: selectedGameIndex.value == index ? 100.h : 120.h,
                                                  width: 100.w,
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(vertical: selectedGameIndex.value == index ? 7.h : 13.h, horizontal: 8.w),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(15),
                                                      child: HashCachedImage(
                                                        imageUrl: dataProvider.game[selectedCategoryIndex.value]['data'][index]['thumbnail'],
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          index == dataProvider.game[selectedCategoryIndex.value]['data'].length - 1
                                              ? Container(
                                                  height: 25.h,
                                                  decoration: BoxDecoration(
                                                    color: bgColor3,
                                                    borderRadius: BorderRadius.only(
                                                      topRight: Radius.circular(selectedGameIndex.value == dataProvider.game[selectedCategoryIndex.value]['data'].length - 1 ? 15 : 0),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink()
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    itemScrollController.value.jumpTo(index: selectedGameIndex.value);
                                  },
                                  child: Container(
                                    height: 40.h,
                                    width: 120.w,
                                    decoration: const BoxDecoration(color: bgColor3),
                                    child: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 40,
                                      color: white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              isOpen.value = true;
                            },
                            child: Container(
                              height: 440.h,
                              width: 30.w,
                              decoration: const BoxDecoration(
                                color: bgColor3,
                              ),
                              child: const Center(
                                child: AutoSizeText(
                                  ">",
                                  style: TextStyle(fontSize: 40),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  width: 10.w,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: SizedBox(
                    height: 500.h,
                    width: isOpen.value ? 220.w : 310.w,
                    child: SingleChildScrollView(
                      child: Column(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: HashCachedImage(
                            imageUrl: dataProvider.game[selectedCategoryIndex.value]['data'][selectedGameIndex.value]['thumbnail'],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        context.read<RobloxskinMainJson>().data![context.read<RobloxskinMainJson>().version]['isGamePlay']
                            ? GestureDetector(
                                onTap: () async {
                                  var url = Uri.parse(dataProvider.game[selectedCategoryIndex.value]['data'][selectedGameIndex.value]['link']);
                                  await launchUrl(url, mode: LaunchMode.externalApplication);
                                },
                                child: Container(
                                  width: 100.w,
                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                      // color: buttonColor1,
                                      border: Border.all(color: white, width: 2),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: const Center(
                                    child: AutoSizeText(
                                      "Play",
                                      style: TextStyle(color: white),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          width: 320.w,
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            // color: buttonColor1,
                            border: Border.all(color: white, width: 2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: AutoSizeText(
                            "Rating : ${dataProvider.game[selectedCategoryIndex.value]['data'][selectedGameIndex.value]['rating']}",
                            style: const TextStyle(color: white),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          width: 320.w,
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            // color: buttonColor1,
                            border: Border.all(color: white, width: 2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: AutoSizeText(
                            "Player Count : ${dataProvider.game[selectedCategoryIndex.value]['data'][selectedGameIndex.value]['playercount']}",
                            style: const TextStyle(color: white),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          width: 320.w,
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            // color: buttonColor1,
                            border: Border.all(color: white, width: 2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: AutoSizeText(
                            dataProvider.game[selectedCategoryIndex.value]['data'][selectedGameIndex.value]['Description'],
                            style: const TextStyle(color: white),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          width: 320.w,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                          ),
                          decoration: BoxDecoration(border: Border.all(color: white, width: 2), borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              const Center(
                                child: AutoSizeText(
                                  "Images",
                                  style: TextStyle(color: white),
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: dataProvider.game[selectedCategoryIndex.value]['data'][selectedGameIndex.value]['image'].length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 5.h),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: HashCachedImage(
                                        imageUrl: dataProvider.game[selectedCategoryIndex.value]['data'][selectedGameIndex.value]['image'][index] is Map
                                            ? dataProvider.game[selectedCategoryIndex.value]['data'][selectedGameIndex.value]['image'][index]['image']
                                            : dataProvider.game[selectedCategoryIndex.value]['data'][selectedGameIndex.value]['image'][index],
                                        loaderColor: white,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 60.h,
                        )
                      ]),
                    ),
                  ),
                ),
                SizedBox(width: 10.w)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
