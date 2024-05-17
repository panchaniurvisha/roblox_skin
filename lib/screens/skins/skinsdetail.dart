import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hash_cached_image/hash_cached_image.dart';
import 'package:provider/provider.dart';
import 'package:roblox_skin/RobloxSkinAds/RobloxSkinAds/RobloxSkinBanner/RobloxSkinBannerWrapper.dart';
import 'package:roblox_skin/RobloxSkinAds/RobloxSkinAds/RobloxSkinFullScreen/RobloxSkinAds.dart';
import 'package:roblox_skin/constants/colors.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../../provider/data/data_provider.dart';

class SkinsDetail extends HookWidget {
  static const routeName = '/SkinsDetail';
  final String category;

  const SkinsDetail({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = context.read<DataProvider>();

    var title = useState("");
    var data = useState([]);
    var selectedIndex = useState(0);
    var itemScrollController = useState(ItemScrollController());
    useEffect(() {
      if (category == "boy") {
        title.value = "Boy";
        data.value = dataProvider.boy;
      } else if (category == "girl") {
        title.value = "Girl";
        data.value = dataProvider.girl;
      } else if (category == "bs") {
        title.value = "Boys Sweaters";
        data.value = dataProvider.bs;
      } else if (category == "gs") {
        title.value = "Girls Sweaters";
        data.value = dataProvider.gs;
      } else if (category == "bts") {
        title.value = "Boys T-Shirts";
        data.value = dataProvider.bts;
      } else if (category == "gts") {
        title.value = "Girls T-Shirts";
        data.value = dataProvider.gts;
      } else if (category == "bcs") {
        title.value = "Boys Classic Shirts";
        data.value = dataProvider.bcs;
      } else if (category == "gcs") {
        title.value = "Girls Classic Shirts";
        data.value = dataProvider.gcs;
      } else if (category == "bcp") {
        title.value = "Boys Classic Pants";
        data.value = dataProvider.bcp;
      } else if (category == "gcp") {
        title.value = "Girls Classic Pants";
        data.value = dataProvider.gcp;
      } else if (category == "fav") {
        // title.value = "Favorite";
        // data.value = context.read<FavoriteProvider>().favorite;
      } else if (category == "pet") {
        title.value = "Roblox Pet";
        data.value = dataProvider.pet;
      } else if (category == "petcategory") {
        title.value = dataProvider.pet[dataProvider.petCategoryIndex]['Name'];
        data.value = dataProvider.pet[dataProvider.petCategoryIndex]['Pet'];
      }
      return () {};
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(title.value),
        centerTitle: true,
      ),
      body: RobloxSkinBannerWrapper(
        parentContext: context,
        child: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Container(
                    height: 500.h,
                    width: 120.w,
                    decoration: const BoxDecoration(
                      color: bgColor1,
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            itemScrollController.value.jumpTo(index: selectedIndex.value);
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
                            itemCount: data.value.length,
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
                                              bottomRight: Radius.circular(selectedIndex.value == 0 ? 15 : 0),
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  GestureDetector(
                                    onTap: () {
                                      RobloxSkinAds().RobloxSkinShowFullScreen(
                                        context: context,
                                        onComplete: () {
                                          selectedIndex.value = index;
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: 120.w,
                                      decoration: BoxDecoration(
                                        color: bgColor3,
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(selectedIndex.value - 1 == index ? 15 : 0), topRight: Radius.circular(selectedIndex.value + 1 == index ? 15 : 0)),
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.only(left: selectedIndex.value == index ? 10.w : 0),
                                        decoration: BoxDecoration(
                                          color: selectedIndex.value == index ? bgColor1 : Colors.transparent,
                                          borderRadius: const BorderRadius.horizontal(
                                            left: Radius.circular(15),
                                          ),
                                        ),
                                        child: SimpleShadow(
                                          color: black,
                                          offset: const Offset(5, 5),
                                          sigma: 3,
                                          child: SizedBox(
                                            height: selectedIndex.value == index ? 100.h : 130.h,
                                            width: 100.w,
                                            child: HashCachedImage(imageUrl: data.value[index]['Image']),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  index == data.value.length - 1
                                      ? Container(
                                          height: 25.h,
                                          decoration: BoxDecoration(
                                            color: bgColor3,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(selectedIndex.value == data.value.length - 1 ? 15 : 0),
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
                            itemScrollController.value.jumpTo(index: selectedIndex.value);
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
              ),
              SizedBox(
                width: 20.w,
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: SizedBox(
                  height: 500.h,
                  width: 210.w,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: SimpleShadow(
                        color: black,
                        offset: const Offset(5, 5),
                        sigma: 3,
                        child: SizedBox(
                          height: 180.h,
                          width: 210.w,
                          child: HashCachedImage(
                            imageUrl: data.value[selectedIndex.value]['Image'],
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60.h,
                      width: 240.w,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          data.value[selectedIndex.value]['Name'],
                          style: const TextStyle(fontSize: 30, color: white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: 35.h,
                      width: 170.w,
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(40),
                        border: Border.all(color: white, width: 2.5),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          "Price:  ${data.value[selectedIndex.value]['Price']}",
                          maxLines: 1,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: 35.h,
                      width: 170.w,
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(40),
                        border: Border.all(color: white, width: 2.5),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                            data.value[selectedIndex.value]['Type'] != null ? "Type:  ${data.value[selectedIndex.value]['Type']}" : "Rarity:  ${data.value[selectedIndex.value]['Rarity']}",
                            maxLines: 1),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: 35.h,
                      width: 170.w,
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(40),
                        border: Border.all(color: white, width: 2.5),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          "Genre:  ${data.value[selectedIndex.value]['Genres'] ?? "All"}",
                          maxLines: 1,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      height: 115.h,
                      width: 200.w,
                      child: AutoSizeText(
                        data.value[selectedIndex.value]['Description'] ?? data.value[selectedIndex.value]['Details'] ?? "No Description",
                        style: const TextStyle(fontSize: 30),
                      ),
                    )
                  ]),
                ),
              ),
              SizedBox(width: 10.w)
            ],
          ),
        ),
      ),
    );
  }
}
