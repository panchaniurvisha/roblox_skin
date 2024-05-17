import 'dart:async';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:logger/logger.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../RobloxSkinAdsMainJson/RobloxSkinAdsMainJson.dart';
import '../RobloxSkinAdsMethods/RobloxSkinBaseClass.dart';
import '../RobloxSkinAdsUtils/RobloxSkinAlerts/AlertEngine.dart';
import '../RobloxSkinAdsUtils/RobloxSkinAlerts/RateUs.dart';
import '../RobloxSkinAdsUtils/NavigationService.dart';

class RobloxSkinAdsSplashScreen extends HookWidget {
  final Widget child;
  final List<String> jsonUrl;
  final List<String> servers;
  final String version;
  final Function(BuildContext context, Map robloxskinMainJson) onComplete;

  const RobloxSkinAdsSplashScreen({required this.child, required this.onComplete, required this.version, required this.servers, required this.jsonUrl, super.key});

  @override
  Widget build(BuildContext context) {
    // RobloxskinMainJson robloxskinMainJson = context.read<RobloxskinMainJson>();

    List<int> pingTimes = [];
    List<Ping> pingsList = [];
    Timer rateUsTimer;

    final currentFetchIndex = useState<int>(0);
    final jsonWithTime = useState<List>([]);

    showUpdateDialog(String url) {
      return showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CupertinoAlertDialog(
          title: const Text("New Update Available"),
          content: const Text("New Update for your app is now available please update app to continue"),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text("Update Now"),
              onPressed: () {
                launchUrl(Uri.parse(url));
              },
            ),
          ],
        ),
      );
    }

    rateUsDialog() async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      showCupertinoDialog(
          context: NavigationService.navigatorKey.currentContext!,
          barrierDismissible: true,
          builder: (context) => CupertinoAlertDialog(
                title: Text(packageInfo.appName),
                content: const Text("If you like our app. Would you mind to take moment to Rate Us."),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: const Text("Not now"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  CupertinoDialogAction(
                    child: const Text("Rate"),
                    onPressed: () {
                      Navigator.pop(context);
                      RateUs().showRateUsDialog();
                    },
                  ),
                ],
              ));
    }

    mainFetchingLogic() {
      Future.microtask(() async {
        try {
          Logger().d("Fetched Json ${jsonWithTime.value[currentFetchIndex.value]['robloxskinMainJson']}");
          Response response = await Dio().get(jsonWithTime.value[currentFetchIndex.value]['robloxskinMainJson'],
              options: Options(
                receiveDataWhenStatusError: true,
                receiveTimeout: const Duration(minutes: 1),
              ));
          Logger().d("Json Fetched successful");
          if (response.data != null) {
            Future.microtask(() async {
              context.read<RobloxskinMainJson>().data = response.data;
              context.read<RobloxskinMainJson>().version = version;
              RobloxSkinBaseClass().initAdNetworks(
                context: context,
                onInitComplete: () async {
                  if (response.data[version]['isUpdate'] ?? false) {
                    showUpdateDialog(response.data[version]['updateUrl']);
                    return;
                  }

                  rateUsTimer = Timer.periodic(Duration(seconds: response.data[version]['robloxskinGlobalConfig']['robloxskinRateUsTimer']), (timer) async {
                    Logger().d("Rate Us Dialog");
                    final InAppReview inAppReview = InAppReview.instance;
                    if (await inAppReview.isAvailable()) {
                      rateUsDialog();
                    }
                  });

                  String oneSignalKey = response.data["one-signal"] ?? "";
                  if (oneSignalKey.isNotEmpty) {
                    var isPermission = OneSignal.Notifications.permission;

                    OneSignal.Notifications.requestPermission(false);

                    OneSignal.initialize("${response.data!["one-signal"]}");

                    OneSignal.Notifications.addPermissionObserver((state) {});
                  }

                  if (response.data[version]['isUserConsent']) {
                    await RobloxSkinBaseClass().showUserMessage();
                  } else {
                    await AppTrackingTransparency.requestTrackingAuthorization();
                  }

                  onComplete(context, response.data);
                },
              );
            });
          }
        } on DioException catch (e) {
          if (currentFetchIndex.value < (jsonWithTime.value.length - 1)) {
            currentFetchIndex.value = currentFetchIndex.value + 1;
            Future.microtask(() {
              AlertEngine.showNetworkError(context, () {
                Navigator.pop(context);
                mainFetchingLogic();
              });
            });
          } else {
            Future.microtask(() {
              AlertEngine.showCloseApp(context);
            });
          }
        } catch (e) {
          print("Catche --------> ${e.toString()}");
        }
      });
    }

    getFastServer(List<String> servers, Function(List<int> timeList) onPingTestCompleted) {
      pingTimes = List.generate(servers.length, (index) => index);
      for (int i = 0; i < servers.length; i++) {
        pingsList.insert(i, Ping(servers[i]));
        pingsList[i].stream.listen((event) {
          pingTimes[i] = event.response?.time?.inMilliseconds ?? 0;
        });
      }
      Future.delayed(const Duration(seconds: 2), () {
        onPingTestCompleted(pingTimes);
        // Stop Pings
        for (final o in pingsList) {
          o.stop();
        }
      });
    }

    String? getJsonUrl(String prefix, List jsonUrl) {
      List temp = jsonUrl
          .where(
            (element) => element.toString().toLowerCase().contains(
                  prefix.toLowerCase(),
                ),
          )
          .toList();
      return temp.isEmpty ? null : temp[0];
    }

    List<Map> sortListByFastest(List<String> servers, List<int> pingsTimeStamp, List jsonUrl) {
      List<Map> temp = [];
      for (int i = 0; i < servers.length; i++) {
        temp.add(
          {
            "server": servers[i],
            "time": pingsTimeStamp[i],
            "robloxskinMainJson": getJsonUrl(servers[i], jsonUrl),
          },
        );
      }
      temp.sort(
        (a, b) => (int.tryParse(a['time'].toString()) ?? 0).compareTo((int.tryParse(b['time'].toString()) ?? 0)),
      );
      temp.removeWhere(
        (element) => element['robloxskinMainJson'] == null,
      );
      temp.removeWhere(
        (element) => element['time'] == 0,
      );
      Logger().d("Server List $temp");
      return temp;
    }

    Future<void> fetchrobloxskinMainJson() async {
      getFastServer(
        servers,
        (timeList) async {
          jsonWithTime.value = sortListByFastest(
            servers,
            timeList,
            jsonUrl,
          );
          mainFetchingLogic();
        },
      );
    }

    useEffect(() {
      Future.microtask(
        () {
          fetchrobloxskinMainJson();
        },
      );
      return () {};
    }, []);
    return Scaffold(
      body: child,
    );
  }
}
