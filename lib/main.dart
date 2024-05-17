import 'package:dart_ping_ios/dart_ping_ios.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:roblox_skin/RobloxSkinAds/RobloxSkinAdsUtils/RobloxSkinAdsExtensions.dart';
import 'package:roblox_skin/provider/data/data_provider.dart';
import 'package:roblox_skin/provider/providerclass.dart';
import 'package:roblox_skin/screens/main/home.dart';

import 'RobloxSkinAds/RobloxSkinAdsLoader/RobloxSkinAdLoader.dart';
import 'RobloxSkinAds/RobloxSkinAdsProvider/RobloxSkinAdsProvider.dart';
import 'RobloxSkinAds/RobloxSkinAdsScreen/RobloxSkinAdsSplashScreen.dart';
import 'RobloxSkinAds/RobloxSkinAdsUtils/NavigationService.dart';
import 'constants/colors.dart';
import 'constants/utils.dart';
import 'routes/routes.dart' as r;
import 'screens/main/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    isIpad = MediaQuery.of(context).size.width > 700 ? true : false;
    isSmallDevice = MediaQuery.of(context).size.width < 420 ? true : false;

    DartPingIOS.register();
    return RobloxSkinAdsProvider(
      child: ProviderClass(
        child: RobloxSkinAdLoader(
          child: ScreenUtilInit(
            builder: (context, child) {
              return MaterialApp(
                home: RobloxSkinAdsSplashScreen(
                    onComplete: (context, pokemonMainJson) async {
                      DataProvider dataProvider = context.read<DataProvider>();
                      dataProvider.getBoyData().then((value) {
                        dataProvider.getGirlData().then((value) {
                          dataProvider.getBsData().then((value) {
                            dataProvider.getGsData().then((value) {
                              dataProvider.getBtsData().then((value) {
                                dataProvider.getGtsData().then((value) {
                                  dataProvider.getBcsData().then((value) {
                                    dataProvider.getGcsData().then((value) {
                                      dataProvider.getBcpData().then((value) {
                                        dataProvider.getGcpData().then((value) {
                                          dataProvider.getPetData().then((value) {
                                            dataProvider.getCodeData().then((value) {
                                              dataProvider.getGameData().then((value) {
                                                "SplashScreen".RobloxSkinPerformAction(
                                                    context: context,
                                                    onComplete: () {
                                                      Navigator.pushReplacementNamed(context, Home.routeName);
                                                    });
                                              });
                                            });
                                          });
                                        });
                                      });
                                    });
                                  });
                                });
                              });
                            });
                          });
                        });
                      });
                    },
                    servers: const [
                      "miracocopepsi.com",
                      "coinspinmaster.com",
                      "trailerspot4k.com",
                    ],
                    jsonUrl: [
                      "Hfq9TSL5waUm2YSbZ4DGSDmxuGtj2h4xpICV1OTjxkC5saQ2Wqq96KIdubGx02HlOXe6PaY9eQeltnlXlsKvSFeDTFsM9X/DITJA"
                          .decrypt(),
                      "Hfq9TSL5waUo35+Ud5/MSSS1u2xvhlM9psLbwujghwa7o/IxR+ey6LlBoLm102L5JTbnP6U4eFG8rn9X".decrypt(),
                      "Hfq9TSL5waU/wpeTaIrXVDm7vCxh2h4xpICG0eOlwQCn/68sSumx/7JZor70lnvlJHelM60/OBWlsn4=".decrypt()
                    ],
                    version: '1.0.0',
                    child: const SplashScreen()),
                navigatorKey: NavigationService.navigatorKey,
                theme: ThemeData(
                  scaffoldBackgroundColor: bgColor1,
                  appBarTheme: AppBarTheme(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                    iconTheme: const IconThemeData(color: fontColor),
                    titleTextStyle: GoogleFonts.acme(
                      color: fontColor,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  textTheme: TextTheme(
                    bodyMedium:
                        GoogleFonts.acme(fontSize: 25, letterSpacing: 2, color: fontColor, fontWeight: FontWeight.bold),
                    bodySmall: GoogleFonts.acme(
                        fontSize: 25, letterSpacing: 2, color: fontColor, fontWeight: FontWeight.normal),
                    titleMedium:
                        GoogleFonts.acme(fontSize: 25, letterSpacing: 2, color: fontColor, fontWeight: FontWeight.bold),
                  ),
                ),
                onGenerateRoute: r.Router.onRouteGenerator,
                debugShowCheckedModeBanner: false,
              );
            },
          ),
        ),
      ),
    );
  }
}
