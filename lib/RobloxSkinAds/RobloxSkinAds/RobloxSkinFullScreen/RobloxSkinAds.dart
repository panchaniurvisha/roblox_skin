import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ironsource_adpluginx/ironsource_adpluginx.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../RobloxSkinAdsLoader/RobloxSkinAdLoaderProvider.dart';
import '../../RobloxSkinAdsMainJson/RobloxSkinAdsMainJson.dart';
import '../../RobloxSkinAdsWidget/RobloxSkinAppLovin/Interstitial/RobloxSkinAppLovinInterstitial.dart';
import '../../RobloxSkinAdsWidget/RobloxSkinGoogle/Interstitial/RobloxSkinGoogleInterstitial.dart';
import '../../RobloxSkinAdsWidget/RobloxSkinGoogle/Rewarded Interstitial/RobloxSkinGoogleRewardedInterstitial.dart';
import '../../RobloxSkinAdsWidget/RobloxSkinGoogle/Rewarded/RobloxSkinGoogleRewarded.dart';
import '../../RobloxSkinAdsWidget/RobloxSkinIronSource/Interstitial/RobloxSkinIronSourceInterstitial.dart';
import '../../RobloxSkinAdsWidget/RobloxSkinUnity/RobloxSkinUnityInterstitial.dart';

class RobloxSkinAds {
  static final RobloxSkinAds _singleton = RobloxSkinAds._internal();

  factory RobloxSkinAds() {
    return _singleton;
  }

  RobloxSkinAds._internal();

  Map routeIndex = {};
  int currentAdIndex = 0;
  int failCounter = 0;

  Timer? timer;

  indexIncrement(String? route, int arrayLength) {
    failCounter = 0;
    if (route != null) {
      if (routeIndex[route] == null) {
        if ((arrayLength + 1) == 1) {
          routeIndex[route] = 0;
        } else {
          routeIndex[route] = 1;
        }
      } else {
        if (routeIndex[route] != arrayLength && routeIndex[route] < arrayLength) {
          routeIndex[route]++;
        } else {
          routeIndex[route] = 0;
        }
      }
    } else {
      if (currentAdIndex < arrayLength && currentAdIndex != arrayLength) {
        currentAdIndex++;
      } else {
        currentAdIndex = 0;
      }
    }
  }

  bool loopBreaker(int retry) {
    if (failCounter < retry) {
      failCounter++;
      return false;
    }
    failCounter = 0;
    return true;
  }

  RobloxSkinShowFullScreen({required BuildContext context, required Function() onComplete}) async {
    RobloxskinMainJson robloxskinMainJson = context.read<RobloxskinMainJson>();
    RobloxSkinAdLoaderProvider loaderProvider = context.read<RobloxSkinAdLoaderProvider>();
    loaderProvider.isAdLoading = true;
    String? route = ModalRoute.of(context)?.settings.name;
    int index = route != null ? (routeIndex[route] ?? 0) : currentAdIndex;

    timer = Timer.periodic(Duration(seconds: robloxskinMainJson.data![robloxskinMainJson.version]['robloxskinGlobalConfig']['robloxskinOverrideTimer']), (timer) {
      Logger().d("override Timer");
      loaderProvider.isAdLoading = false;
      onComplete();
      timer.cancel();
      return;
    });

    if ((robloxskinMainJson.data![robloxskinMainJson.version]['robloxskinGlobalConfig']['robloxskinGlobalAdFlag'] ?? false) == false) {
      loaderProvider.isAdLoading = false;
      timer!.cancel();

      onComplete();
      return;
    }
    if ((robloxskinMainJson.data![robloxskinMainJson.version]['screens'][ModalRoute.of(context)?.settings.name]['robloxskinLocalAdFlag'] ?? false) == false) {
      loaderProvider.isAdLoading = false;
      timer!.cancel();

      onComplete();
      return;
    }
    switch (robloxskinMainJson.data![robloxskinMainJson.version]['screens'][ModalRoute.of(context)?.settings.name]['robloxskinLocalClick'][index]) {
      case "gi":
        Logger().d("Google Inter Called");
        RobloxSkinGoogleInterstitial().loadAd(
          context: context,
          onLoaded: () {
            Logger().d("Google Inter Loaded");
            timer!.cancel();
          },
          onComplete: () {
            Logger().d("Google Inter Complete");
            indexIncrement(route, robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['robloxskinLocalClick'].length - 1);
            loaderProvider.isAdLoading = false;
            onComplete();
            timer!.cancel();
          },
          onFailed: () {
            Logger().d("Google Inter Failed");
            RobloxSkinFailedFullScreen(
              from: "gi",
              context: context,
              onComplete: () {
                loaderProvider.isAdLoading = false;
                onComplete();
                timer!.cancel();
              },
            );
          },
        );
        break;
      case "ali":
        Logger().d("Applovin Inter Called");
        RobloxSkinAppLovinInterstitial().loadAd(
          context: context,
          onLoaded: () {
            Logger().d("Applovin Inter Loaded");
            timer!.cancel();
          },
          onComplete: () {
            Logger().d("Applovin Inter Complete");
            indexIncrement(route, robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['robloxskinLocalClick'].length - 1);
            loaderProvider.isAdLoading = false;
            timer!.cancel();

            onComplete();
          },
          onFailed: () {
            Logger().d("Applovin Inter Failed");
            RobloxSkinFailedFullScreen(
              from: "ali",
              context: context,
              onComplete: () {
                loaderProvider.isAdLoading = false;
                timer!.cancel();

                onComplete();
              },
            );
          },
        );
        break;
      case "isi":
        Logger().d("IronSource Inter Called");
        RobloxSkinIronSourceInterstitial robloxSkinIronSourceInterstitial = RobloxSkinIronSourceInterstitial.onInit(
          onLoaded: () {
            Logger().d("IronSource Inter Loaded");
            timer!.cancel();
            IronSource.showInterstitial();
          },
          onComplete: () {
            Logger().d("IronSource Inter Complete");
            indexIncrement(route, robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['robloxskinLocalClick'].length - 1);
            loaderProvider.isAdLoading = false;
            timer!.cancel();

            onComplete();
          },
          onFailed: () {
            Logger().d("IronSource Inter Failed");
            RobloxSkinFailedFullScreen(
              from: "isi",
              context: context,
              onComplete: () {
                loaderProvider.isAdLoading = false;
                timer!.cancel();
                onComplete();
              },
            );
          },
        );
        IronSource.setLevelPlayInterstitialListener(robloxSkinIronSourceInterstitial);
        IronSource.loadInterstitial();
        // IronSource.loadInterstitial();
        break;
      case "ui":
        Logger().d("Unity Inter Called");
        RobloxSkinUnityInterstitial().loadAd(
            context: context,
            onLoaded: () {
              Logger().d("Unity Inter Loaded");
              timer!.cancel();
            },
            onComplete: () {
              Logger().d("Unity Inter Complete");
              indexIncrement(route, robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['robloxskinLocalClick'].length - 1);
              loaderProvider.isAdLoading = false;
              timer!.cancel();

              onComplete();
            },
            onFailed: () {
              Logger().d("Unity Inter Failed");
              RobloxSkinFailedFullScreen(
                from: "ui",
                context: context,
                onComplete: () {
                  loaderProvider.isAdLoading = false;
                  timer!.cancel();

                  onComplete();
                },
              );
            });
        break;
      case "gr":
        Logger().d("Google Reward Called");
        RobloxSkinGoogleRewarded().loadAd(
            context: context,
            onLoaded: () {
              Logger().d("Google Reward Loaded");
              timer!.cancel();
            },
            onComplete: () {
              Logger().d("Google Reward Complete");
              indexIncrement(route, robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['robloxskinLocalClick'].length - 1);
              loaderProvider.isAdLoading = false;
              timer!.cancel();

              onComplete();
            },
            onFailed: () {
              Logger().d("Google Reward Failed");
              RobloxSkinFailedFullScreen(
                from: "gr",
                context: context,
                onComplete: () {
                  loaderProvider.isAdLoading = false;
                  timer!.cancel();
                  onComplete();
                },
              );
            });
        break;
      case "gri":
        Logger().d("Google Reward Inter Called");
        RobloxSkinGoogleRewardedInterstitial().loadAd(
            context: context,
            onLoaded: () {
              Logger().d("Google Reward Inter Loaded");
              timer!.cancel();
            },
            onComplete: () {
              Logger().d("Google Reward Inter Complete");
              indexIncrement(route, robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['robloxskinLocalClick'].length - 1);
              loaderProvider.isAdLoading = false;
              timer!.cancel();

              onComplete();
            },
            onFailed: () {
              Logger().d("Google Reward Inter Failed");
              RobloxSkinFailedFullScreen(
                from: "gri",
                context: context,
                onComplete: () {
                  loaderProvider.isAdLoading = false;
                  timer!.cancel();

                  onComplete();
                },
              );
            });
        break;
      default:
        indexIncrement(route, robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['robloxskinLocalClick'].length - 1);
        loaderProvider.isAdLoading = false;
        timer!.cancel();

        onComplete();
        break;
    }
  }

  RobloxSkinShowActionBasedAds({required BuildContext context, required String actionName, required Function() onComplete}) {
    RobloxskinMainJson robloxskinMainJson = context.read<RobloxskinMainJson>();
    RobloxSkinAdLoaderProvider loaderProvider = context.read<RobloxSkinAdLoaderProvider>();
    loaderProvider.isAdLoading = true;
    int index = actionName != null ? (routeIndex[actionName] ?? 0) : currentAdIndex;
    if ((robloxskinMainJson.data![robloxskinMainJson.version]['robloxskinGlobalConfig']['robloxskinGlobalAdFlag'] ?? false) == false) {
      loaderProvider.isAdLoading = false;

      onComplete();
      return;
    }

    if ((robloxskinMainJson.data![robloxskinMainJson.version]['actions'][actionName]['robloxskinLocalAdFlag'] ?? false) == false) {
      loaderProvider.isAdLoading = false;

      onComplete();
      return;
    }

    timer = Timer.periodic(Duration(seconds: robloxskinMainJson.data![robloxskinMainJson.version]['robloxskinGlobalConfig']['robloxskinOverrideTimer']), (timer) {
      Logger().d("override Timer");
      loaderProvider.isAdLoading = false;
      onComplete();
      timer.cancel();
      return;
    });

    switch (robloxskinMainJson.data![robloxskinMainJson.version]['actions'][actionName]['robloxskinLocalClick'][index]) {
      case "gi":
        Logger().d("Google Inter Called");
        RobloxSkinGoogleInterstitial().loadAd(
          context: context,
          onLoaded: () {
            Logger().d("Google Inter Loaded");
            timer!.cancel();
          },
          onComplete: () {
            Logger().d("Google Inter Complete");
            indexIncrement(actionName, robloxskinMainJson.data![robloxskinMainJson.version]['actions'][actionName]['robloxskinLocalClick'].length - 1);
            loaderProvider.isAdLoading = false;
            timer!.cancel();
            onComplete();
          },
          onFailed: () {
            Logger().d("Google Inter Failed");
            RobloxSkinFailedActionBasedAds(
              actionName: actionName,
              from: "gi",
              context: context,
              onComplete: () {
                loaderProvider.isAdLoading = false;
                timer!.cancel();
                onComplete();
              },
            );
          },
        );
        break;
      case "ali":
        Logger().d("Applovin Inter Called");
        RobloxSkinAppLovinInterstitial().loadAd(
          context: context,
          onLoaded: () {
            Logger().d("Applovin Inter Loaded");
            timer!.cancel();
          },
          onComplete: () {
            Logger().d("Applovin Inter Complete");
            indexIncrement(actionName, robloxskinMainJson.data![robloxskinMainJson.version]['actions'][actionName]['robloxskinLocalClick'].length - 1);
            loaderProvider.isAdLoading = false;
            timer!.cancel();
            onComplete();
          },
          onFailed: () {
            Logger().d("Applovin Inter Failed");
            RobloxSkinFailedActionBasedAds(
              actionName: actionName,
              from: "ali",
              context: context,
              onComplete: () {
                loaderProvider.isAdLoading = false;
                timer!.cancel();
                onComplete();
              },
            );
          },
        );
        break;
      case "isi":
        Logger().d("IronSource Inter Called");
        RobloxSkinIronSourceInterstitial robloxSkinIronSourceInterstitial = RobloxSkinIronSourceInterstitial.onInit(
          onLoaded: () {
            Logger().d("IronSource Inter Loaded");
            timer!.cancel();
            IronSource.showInterstitial();
          },
          onComplete: () {
            Logger().d("IronSource Inter Complete");
            indexIncrement(actionName, robloxskinMainJson.data![robloxskinMainJson.version]['actions'][actionName]['robloxskinLocalClick'].length - 1);
            loaderProvider.isAdLoading = false;
            timer!.cancel();
            onComplete();
          },
          onFailed: () {
            Logger().d("IronSource Inter Failed");
            RobloxSkinFailedActionBasedAds(
              actionName: actionName,
              from: "isi",
              context: context,
              onComplete: () {
                loaderProvider.isAdLoading = false;
                timer!.cancel();
                onComplete();
              },
            );
          },
        );

        IronSource.setLevelPlayInterstitialListener(robloxSkinIronSourceInterstitial);
        IronSource.loadInterstitial();
        break;
      case "ui":
        Logger().d("Unity Inter Called");
        RobloxSkinUnityInterstitial().loadAd(
            context: context,
            onLoaded: () {
              Logger().d("Unity Inter Loaded");
              timer!.cancel();
            },
            onComplete: () {
              Logger().d("Unity Inter Complete");
              indexIncrement(actionName, robloxskinMainJson.data![robloxskinMainJson.version]['actions'][actionName]['robloxskinLocalClick'].length - 1);
              loaderProvider.isAdLoading = false;
              timer!.cancel();
              onComplete();
            },
            onFailed: () {
              Logger().d("Unity Inter Failed");
              RobloxSkinFailedActionBasedAds(
                actionName: actionName,
                from: "ui",
                context: context,
                onComplete: () {
                  loaderProvider.isAdLoading = false;
                  timer!.cancel();
                  onComplete();
                },
              );
            });
        break;
      case "gr":
        Logger().d("Google Reward Called");
        RobloxSkinGoogleRewarded().loadAd(
            context: context,
            onLoaded: () {
              Logger().d("Google Reward Loaded");
              timer!.cancel();
            },
            onComplete: () {
              Logger().d("Google Reward Complete");
              indexIncrement(actionName, robloxskinMainJson.data![robloxskinMainJson.version]['actions'][actionName]['robloxskinLocalClick'].length - 1);
              loaderProvider.isAdLoading = false;
              timer!.cancel();
              onComplete();
            },
            onFailed: () {
              Logger().d("Google Reward Failed");
              RobloxSkinFailedActionBasedAds(
                actionName: actionName,
                from: "gr",
                context: context,
                onComplete: () {
                  loaderProvider.isAdLoading = false;
                  timer!.cancel();
                  onComplete();
                },
              );
            });
        break;
      case "gri":
        Logger().d("Google Reward Inter Called");
        RobloxSkinGoogleRewardedInterstitial().loadAd(
            context: context,
            onLoaded: () {
              Logger().d("Google Reward Inter Loaded");
              timer!.cancel();
            },
            onComplete: () {
              Logger().d("Google Reward Inter Complete");
              indexIncrement(actionName, robloxskinMainJson.data![robloxskinMainJson.version]['actions'][actionName]['robloxskinLocalClick'].length - 1);
              loaderProvider.isAdLoading = false;
              timer!.cancel();
              onComplete();
            },
            onFailed: () {
              Logger().d("Google Reward Inter Failed");
              RobloxSkinFailedActionBasedAds(
                actionName: actionName,
                from: "gri",
                context: context,
                onComplete: () {
                  loaderProvider.isAdLoading = false;
                  timer!.cancel();
                  onComplete();
                },
              );
            });
        break;

      default:
        indexIncrement(actionName, robloxskinMainJson.data![robloxskinMainJson.version]['actions'][actionName]['robloxskinLocalClick'].length - 1);
        loaderProvider.isAdLoading = false;
        timer!.cancel();
        onComplete();
        break;
    }
  }

  RobloxSkinShowScreenActionBasedAds({required BuildContext context, required String actionName, required Function() onComplete}) {
    RobloxskinMainJson robloxskinMainJson = context.read<RobloxskinMainJson>();
    String? route = ModalRoute.of(context)?.settings.name;
    RobloxSkinAdLoaderProvider loaderProvider = context.read<RobloxSkinAdLoaderProvider>();
    loaderProvider.isAdLoading = true;
    int index = actionName != null ? (routeIndex['$route/$actionName'] ?? 0) : currentAdIndex;
    if ((robloxskinMainJson.data![robloxskinMainJson.version]['robloxskinGlobalConfig']['robloxskinGlobalAdFlag'] ?? false) == false) {
      loaderProvider.isAdLoading = false;

      onComplete();
      return;
    }

    if ((robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['robloxskinLocalAdFlag'] ?? false) == false) {
      loaderProvider.isAdLoading = false;

      onComplete();
      return;
    }
    if ((robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['actions'][actionName]['robloxskinLocalAdFlag'] ?? false) == false) {
      loaderProvider.isAdLoading = false;

      onComplete();
      return;
    }

    timer = Timer.periodic(Duration(seconds: robloxskinMainJson.data![robloxskinMainJson.version]['robloxskinGlobalConfig']['robloxskinOverrideTimer']), (timer) {
      Logger().d("override Timer");
      loaderProvider.isAdLoading = false;
      onComplete();
      timer.cancel();
      return;
    });

    switch (robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['actions'][actionName]['robloxskinLocalClick'][index]) {
      case "gi":
        Logger().d("Google Inter Called");
        RobloxSkinGoogleInterstitial().loadAd(
          context: context,
          onLoaded: () {
            Logger().d("Google Inter Loaded");
            timer!.cancel();
          },
          onComplete: () {
            Logger().d("Google Inter Complete");
            indexIncrement('$route/$actionName', robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['actions'][actionName]['robloxskinLocalClick'].length - 1);
            loaderProvider.isAdLoading = false;
            timer!.cancel();
            onComplete();
          },
          onFailed: () {
            Logger().d("Google Inter Failed");
            RobloxSkinFailedScreenActionBasedAds(
              actionName: actionName,
              from: "gi",
              context: context,
              onComplete: () {
                loaderProvider.isAdLoading = false;
                timer!.cancel();
                onComplete();
              },
            );
          },
        );
        break;
      case "ali":
        Logger().d("Applovin Inter Called");
        RobloxSkinAppLovinInterstitial().loadAd(
          context: context,
          onLoaded: () {
            Logger().d("Applovin Inter Loaded");
            timer!.cancel();
          },
          onComplete: () {
            Logger().d("Applovin Inter Complete");
            indexIncrement('$route/$actionName', robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['actions'][actionName]['robloxskinLocalClick'].length - 1);
            loaderProvider.isAdLoading = false;
            timer!.cancel();
            onComplete();
          },
          onFailed: () {
            Logger().d("Applovin Inter Failed");
            RobloxSkinFailedScreenActionBasedAds(
              actionName: actionName,
              from: "ali",
              context: context,
              onComplete: () {
                loaderProvider.isAdLoading = false;
                timer!.cancel();
                onComplete();
              },
            );
          },
        );
        break;
      case "isi":
        Logger().d("IronSource Inter Called");
        RobloxSkinIronSourceInterstitial robloxSkinIronSourceInterstitial = RobloxSkinIronSourceInterstitial.onInit(
          onLoaded: () {
            Logger().d("IronSource Inter Loaded");
            timer!.cancel();
            IronSource.showInterstitial();
          },
          onComplete: () {
            Logger().d("IronSource Inter Complete");
            indexIncrement('$route/$actionName', robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['actions'][actionName]['robloxskinLocalClick'].length - 1);
            loaderProvider.isAdLoading = false;
            timer!.cancel();
            onComplete();
          },
          onFailed: () {
            Logger().d("IronSource Inter Failed");
            RobloxSkinFailedScreenActionBasedAds(
              actionName: actionName,
              from: "isi",
              context: context,
              onComplete: () {
                loaderProvider.isAdLoading = false;
                timer!.cancel();
                onComplete();
              },
            );
          },
        );

        IronSource.setLevelPlayInterstitialListener(robloxSkinIronSourceInterstitial);
        IronSource.loadInterstitial();
        break;
      case "ui":
        Logger().d("Unity Inter Called");
        RobloxSkinUnityInterstitial().loadAd(
            context: context,
            onLoaded: () {
              Logger().d("Unity Inter Loaded");
              timer!.cancel();
            },
            onComplete: () {
              Logger().d("Unity Inter Complete");
              indexIncrement('$route/$actionName', robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['actions'][actionName]['robloxskinLocalClick'].length - 1);
              loaderProvider.isAdLoading = false;
              timer!.cancel();
              onComplete();
            },
            onFailed: () {
              Logger().d("Unity Inter Failed");
              RobloxSkinFailedScreenActionBasedAds(
                actionName: actionName,
                from: "ui",
                context: context,
                onComplete: () {
                  loaderProvider.isAdLoading = false;
                  timer!.cancel();
                  onComplete();
                },
              );
            });
        break;
      case "gr":
        Logger().d("Google Reward Called");
        RobloxSkinGoogleRewarded().loadAd(
            context: context,
            onLoaded: () {
              Logger().d("Google Reward Loaded");
              timer!.cancel();
            },
            onComplete: () {
              Logger().d("Google Reward Complete");
              indexIncrement('$route/$actionName', robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['actions'][actionName]['robloxskinLocalClick'].length - 1);
              loaderProvider.isAdLoading = false;
              timer!.cancel();
              onComplete();
            },
            onFailed: () {
              Logger().d("Google Reward Failed");
              RobloxSkinFailedScreenActionBasedAds(
                actionName: actionName,
                from: "gr",
                context: context,
                onComplete: () {
                  loaderProvider.isAdLoading = false;
                  timer!.cancel();
                  onComplete();
                },
              );
            });
        break;
      case "gri":
        Logger().d("Google Reward Inter Called");
        RobloxSkinGoogleRewardedInterstitial().loadAd(
            context: context,
            onLoaded: () {
              Logger().d("Google Reward Inter Loaded");
              timer!.cancel();
            },
            onComplete: () {
              Logger().d("Google Reward Inter Complete");
              indexIncrement('$route/$actionName', robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['actions'][actionName]['robloxskinLocalClick'].length - 1);
              loaderProvider.isAdLoading = false;
              timer!.cancel();
              onComplete();
            },
            onFailed: () {
              Logger().d("Google Reward Inter Failed");
              RobloxSkinFailedScreenActionBasedAds(
                actionName: actionName,
                from: "gri",
                context: context,
                onComplete: () {
                  loaderProvider.isAdLoading = false;
                  timer!.cancel();
                  onComplete();
                },
              );
            });
        break;

      default:
        indexIncrement('$route/$actionName', robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['actions'][actionName]['robloxskinLocalClick'].length - 1);
        loaderProvider.isAdLoading = false;
        timer!.cancel();
        onComplete();
        break;
    }
  }

  RobloxSkinFailedFullScreen({required String from, required BuildContext context, required Function() onComplete}) {
    RobloxskinMainJson robloxskinMainJson = context.read<RobloxskinMainJson>();
    String? route = ModalRoute.of(context)?.settings.name;
    Map? failedMapArray = robloxskinMainJson.data![robloxskinMainJson.version]['screens'][ModalRoute.of(context)?.settings.name]['robloxskinLocalFail'];
    String caseType = failedMapArray![from.toString()] ?? "gi";

    if (failedMapArray[from.toString()] == null) {
      onComplete();
      return;
    }

    if (loopBreaker(robloxskinMainJson.data![robloxskinMainJson.version]['robloxskinGlobalConfig']['robloxskinMaxFailed'])) {
      Logger().d("max failed");
      onComplete();
    } else {
      switch (caseType) {
        case "gi":
          Logger().d("Google Inter Called");
          RobloxSkinGoogleInterstitial().loadAd(
            context: context,
            onLoaded: () {
              Logger().d("Google Inter Loaded");
              timer!.cancel();
            },
            onComplete: () {
              Logger().d("Google Inter Complete");
              indexIncrement(route, robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['robloxskinLocalClick'].length - 1);
              timer!.cancel();
              onComplete();
            },
            onFailed: () {
              Logger().d("Google Inter Failed");
              RobloxSkinFailedFullScreen(
                from: "gi",
                context: context,
                onComplete: () {
                  timer!.cancel();
                  onComplete();
                },
              );
            },
          );
          break;
        case "ali":
          Logger().d("Applovin Inter Called");
          RobloxSkinAppLovinInterstitial().loadAd(
            context: context,
            onLoaded: () {
              Logger().d("Applovin Inter Loaded");
              timer!.cancel();
            },
            onComplete: () {
              Logger().d("Applovin Inter Complete");
              indexIncrement(route, robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['robloxskinLocalClick'].length - 1);
              timer!.cancel();
              onComplete();
            },
            onFailed: () {
              Logger().d("Applovin Inter Failed");
              RobloxSkinFailedFullScreen(
                from: "ali",
                context: context,
                onComplete: () {
                  timer!.cancel();
                  onComplete();
                },
              );
            },
          );
          break;
        case "isi":
          Logger().d("IronSource Inter Called");
          RobloxSkinIronSourceInterstitial robloxSkinIronSourceInterstitial = RobloxSkinIronSourceInterstitial.onInit(
            onLoaded: () {
              Logger().d("IronSource Inter Loaded");
              timer!.cancel();
              IronSource.showInterstitial();
            },
            onComplete: () {
              Logger().d("IronSource Inter Complete");
              indexIncrement(route, robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['robloxskinLocalClick'].length - 1);
              timer!.cancel();

              onComplete();
            },
            onFailed: () {
              Logger().d("IronSource Inter Failed");
              RobloxSkinFailedFullScreen(
                from: "isi",
                context: context,
                onComplete: () {
                  timer!.cancel();
                  onComplete();
                },
              );
            },
          );
          IronSource.setLevelPlayInterstitialListener(robloxSkinIronSourceInterstitial);
          IronSource.loadInterstitial();
          break;
        case "ui":
          Logger().d("Unity Inter Called");
          RobloxSkinUnityInterstitial().loadAd(
              onLoaded: () {
                Logger().d("Unity Inter Loaded");
                timer!.cancel();
              },
              context: context,
              onComplete: () {
                Logger().d("Unity Inter Complete");
                indexIncrement(route, robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['robloxskinLocalClick'].length - 1);
                timer!.cancel();
                onComplete();
              },
              onFailed: () {
                Logger().d("Unity Inter Failed");
                RobloxSkinFailedFullScreen(
                  from: "ui",
                  context: context,
                  onComplete: () {
                    timer!.cancel();
                    onComplete();
                  },
                );
              });
          break;
        case "gr":
          Logger().d("Google Reward Called");
          RobloxSkinGoogleRewarded().loadAd(
              context: context,
              onLoaded: () {
                Logger().d("Google Reward Loaded");
                timer!.cancel();
              },
              onComplete: () {
                Logger().d("Google Reward Complete");
                indexIncrement(route, robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['robloxskinLocalClick'].length - 1);
                timer!.cancel();
                onComplete();
              },
              onFailed: () {
                Logger().d("Google Reward Failed");
                RobloxSkinFailedFullScreen(
                  from: "gr",
                  context: context,
                  onComplete: () {
                    timer!.cancel();
                    onComplete();
                  },
                );
              });
          break;
        case "gri":
          Logger().d("Google Reward Inter Called");
          RobloxSkinGoogleRewardedInterstitial().loadAd(
              context: context,
              onLoaded: () {
                Logger().d("Google Reward Inter Loaded");
                timer!.cancel();
              },
              onComplete: () {
                Logger().d("Google Reward Inter Complete");
                indexIncrement(route, robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['robloxskinLocalClick'].length - 1);
                timer!.cancel();
                onComplete();
              },
              onFailed: () {
                Logger().d("Google Reward Inter Failed");
                RobloxSkinFailedFullScreen(
                  from: "gri",
                  context: context,
                  onComplete: () {
                    timer!.cancel();
                    onComplete();
                  },
                );
              });
          break;
        default:
          indexIncrement(route, robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['robloxskinLocalClick'].length - 1);
          timer!.cancel();
          onComplete();
          break;
      }
    }
  }

  RobloxSkinFailedActionBasedAds({required String from, required String actionName, required BuildContext context, required Function() onComplete}) {
    RobloxskinMainJson robloxskinMainJson = context.read<RobloxskinMainJson>();
    Map? failedMapArray = robloxskinMainJson.data![robloxskinMainJson.version]['actions'][actionName]['robloxskinLocalFail'];
    String caseType = failedMapArray![from.toString()];

    if (loopBreaker(robloxskinMainJson.data![robloxskinMainJson.version]['robloxskinGlobalConfig']['robloxskinMaxFailed'])) {
      Logger().d("max failed");
      onComplete();
    } else {
      switch (caseType) {
        case "gi":
          Logger().d("Google Inter Called");
          RobloxSkinGoogleInterstitial().loadAd(
            context: context,
            onLoaded: () {
              Logger().d("Google Inter Loaded");
              timer!.cancel();
            },
            onComplete: () {
              Logger().d("Google Inter Complete");
              indexIncrement(actionName, robloxskinMainJson.data![robloxskinMainJson.version]['actions'][actionName]['robloxskinLocalClick'].length - 1);
              timer!.cancel();
              onComplete();
            },
            onFailed: () {
              Logger().d("Google Inter Failed");
              RobloxSkinFailedActionBasedAds(
                actionName: actionName,
                from: "gi",
                context: context,
                onComplete: () {
                  timer!.cancel();
                  onComplete();
                },
              );
            },
          );
          break;
        case "ali":
          Logger().d("Applovin Inter Called");
          RobloxSkinAppLovinInterstitial().loadAd(
            context: context,
            onLoaded: () {
              Logger().d("Applovin Inter Loaded");
              timer!.cancel();
            },
            onComplete: () {
              Logger().d("Applovin Inter Complete");
              indexIncrement(actionName, robloxskinMainJson.data![robloxskinMainJson.version]['actions'][actionName]['robloxskinLocalClick'].length - 1);
              timer!.cancel();
              onComplete();
            },
            onFailed: () {
              Logger().d("Applovin Inter Failed");
              RobloxSkinFailedActionBasedAds(
                actionName: actionName,
                from: "ali",
                context: context,
                onComplete: () {
                  timer!.cancel();
                  onComplete();
                },
              );
            },
          );
          break;
        case "isi":
          Logger().d("IronSource Inter Called");
          RobloxSkinIronSourceInterstitial robloxSkinIronSourceInterstitial = RobloxSkinIronSourceInterstitial.onInit(
            onLoaded: () {
              Logger().d("IronSource Inter Loaded");
              timer!.cancel();
              IronSource.showInterstitial();
            },
            onComplete: () {
              Logger().d("IronSource Inter Complete");
              indexIncrement(actionName, robloxskinMainJson.data![robloxskinMainJson.version]['actions'][actionName]['robloxskinLocalClick'].length - 1);
              timer!.cancel();
              onComplete();
            },
            onFailed: () {
              Logger().d("IronSource Inter Failed");
              RobloxSkinFailedActionBasedAds(
                actionName: actionName,
                from: "isi",
                context: context,
                onComplete: () {
                  timer!.cancel();
                  onComplete();
                },
              );
            },
          );

          IronSource.setLevelPlayInterstitialListener(robloxSkinIronSourceInterstitial);
          IronSource.loadInterstitial();
          break;

        case "ui":
          Logger().d("Unity Inter Called");
          RobloxSkinUnityInterstitial().loadAd(
              context: context,
              onLoaded: () {
                Logger().d("Unity Inter Loaded");
                timer!.cancel();
              },
              onComplete: () {
                Logger().d("Unity Inter Complete");
                indexIncrement(actionName, robloxskinMainJson.data![robloxskinMainJson.version]['actions'][actionName]['robloxskinLocalClick'].length - 1);
                timer!.cancel();
                onComplete();
              },
              onFailed: () {
                Logger().d("Unity Inter Failed");
                RobloxSkinFailedActionBasedAds(
                  actionName: actionName,
                  from: "ui",
                  context: context,
                  onComplete: () {
                    timer!.cancel();
                    onComplete();
                  },
                );
              });
          break;
        case "gr":
          Logger().d("Google Reward Called");
          RobloxSkinGoogleRewarded().loadAd(
              context: context,
              onLoaded: () {
                Logger().d("Google Reward Loaded");
                timer!.cancel();
              },
              onComplete: () {
                Logger().d("Google Reward Complete");
                indexIncrement(actionName, robloxskinMainJson.data![robloxskinMainJson.version]['actions'][actionName]['robloxskinLocalClick'].length - 1);
                timer!.cancel();
                onComplete();
              },
              onFailed: () {
                Logger().d("Google Reward Failed");
                RobloxSkinFailedActionBasedAds(
                  actionName: actionName,
                  from: "gr",
                  context: context,
                  onComplete: () {
                    timer!.cancel();

                    onComplete();
                  },
                );
              });
          break;
        case "gri":
          Logger().d("Google Reward Inter Called");
          RobloxSkinGoogleRewardedInterstitial().loadAd(
              context: context,
              onLoaded: () {
                Logger().d("Google Reward Inter Loaded");
                timer!.cancel();
              },
              onComplete: () {
                Logger().d("Google Reward Inter Complete");
                indexIncrement(actionName, robloxskinMainJson.data![robloxskinMainJson.version]['actions'][actionName]['robloxskinLocalClick'].length - 1);
                timer!.cancel();

                onComplete();
              },
              onFailed: () {
                Logger().d("Google Reward Inter Failed");
                RobloxSkinFailedActionBasedAds(
                  actionName: actionName,
                  from: "gri",
                  context: context,
                  onComplete: () {
                    timer!.cancel();

                    onComplete();
                  },
                );
              });
          break;

        default:
          indexIncrement(actionName, robloxskinMainJson.data![robloxskinMainJson.version]['actions'][actionName]['robloxskinLocalClick'].length - 1);
          timer!.cancel();

          onComplete();
          break;
      }
    }
  }

  RobloxSkinFailedScreenActionBasedAds({required String from, required String actionName, required BuildContext context, required Function() onComplete}) {
    RobloxskinMainJson robloxskinMainJson = context.read<RobloxskinMainJson>();
    String? route = ModalRoute.of(context)?.settings.name;

    Map? failedMapArray = robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['actions'][actionName]['robloxskinLocalFail'];
    String caseType = failedMapArray![from.toString()];

    if (loopBreaker(robloxskinMainJson.data![robloxskinMainJson.version]['robloxskinGlobalConfig']['robloxskinMaxFailed'])) {
      Logger().d("max failed");
      onComplete();
    } else {
      switch (caseType) {
        case "gi":
          Logger().d("Google Inter Called");
          RobloxSkinGoogleInterstitial().loadAd(
            context: context,
            onLoaded: () {
              Logger().d("Google Inter Loaded");
              timer!.cancel();
            },
            onComplete: () {
              Logger().d("Google Inter Complete");
              indexIncrement('$route/$actionName', robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['actions'][actionName]['robloxskinLocalClick'].length - 1);
              timer!.cancel();
              onComplete();
            },
            onFailed: () {
              Logger().d("Google Inter Failed");
              RobloxSkinFailedScreenActionBasedAds(
                actionName: actionName,
                from: "gi",
                context: context,
                onComplete: () {
                  timer!.cancel();
                  onComplete();
                },
              );
            },
          );
          break;
        case "ali":
          Logger().d("Applovin Inter Called");
          RobloxSkinAppLovinInterstitial().loadAd(
            context: context,
            onLoaded: () {
              Logger().d("Applovin Inter Loaded");
              timer!.cancel();
            },
            onComplete: () {
              Logger().d("Applovin Inter Complete");
              indexIncrement('$route/$actionName', robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['actions'][actionName]['robloxskinLocalClick'].length - 1);
              timer!.cancel();
              onComplete();
            },
            onFailed: () {
              Logger().d("Applovin Inter Failed");
              RobloxSkinFailedScreenActionBasedAds(
                actionName: actionName,
                from: "ali",
                context: context,
                onComplete: () {
                  timer!.cancel();
                  onComplete();
                },
              );
            },
          );
          break;
        case "isi":
          Logger().d("IronSource Inter Called");
          RobloxSkinIronSourceInterstitial robloxSkinIronSourceInterstitial = RobloxSkinIronSourceInterstitial.onInit(
            onLoaded: () {
              Logger().d("IronSource Inter Loaded");
              timer!.cancel();
              IronSource.showInterstitial();
            },
            onComplete: () {
              Logger().d("IronSource Inter Complete");
              indexIncrement('$route/$actionName', robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['actions'][actionName]['robloxskinLocalClick'].length - 1);
              timer!.cancel();
              onComplete();
            },
            onFailed: () {
              Logger().d("IronSource Inter Failed");
              RobloxSkinFailedScreenActionBasedAds(
                actionName: actionName,
                from: "isi",
                context: context,
                onComplete: () {
                  timer!.cancel();
                  onComplete();
                },
              );
            },
          );

          IronSource.setLevelPlayInterstitialListener(robloxSkinIronSourceInterstitial);
          IronSource.loadInterstitial();
          break;

        case "ui":
          Logger().d("Unity Inter Called");
          RobloxSkinUnityInterstitial().loadAd(
              context: context,
              onLoaded: () {
                Logger().d("Unity Inter Loaded");
                timer!.cancel();
              },
              onComplete: () {
                Logger().d("Unity Inter Complete");
                indexIncrement('$route/$actionName', robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['actions'][actionName]['robloxskinLocalClick'].length - 1);
                timer!.cancel();
                onComplete();
              },
              onFailed: () {
                Logger().d("Unity Inter Failed");
                RobloxSkinFailedScreenActionBasedAds(
                  actionName: actionName,
                  from: "ui",
                  context: context,
                  onComplete: () {
                    timer!.cancel();
                    onComplete();
                  },
                );
              });
          break;
        case "gr":
          Logger().d("Google Reward Called");
          RobloxSkinGoogleRewarded().loadAd(
              context: context,
              onLoaded: () {
                Logger().d("Google Reward Loaded");
                timer!.cancel();
              },
              onComplete: () {
                Logger().d("Google Reward Complete");
                indexIncrement('$route/$actionName', robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['actions'][actionName]['robloxskinLocalClick'].length - 1);
                timer!.cancel();
                onComplete();
              },
              onFailed: () {
                Logger().d("Google Reward Failed");
                RobloxSkinFailedScreenActionBasedAds(
                  actionName: actionName,
                  from: "gr",
                  context: context,
                  onComplete: () {
                    timer!.cancel();

                    onComplete();
                  },
                );
              });
          break;
        case "gri":
          Logger().d("Google Reward Inter Called");
          RobloxSkinGoogleRewardedInterstitial().loadAd(
              context: context,
              onLoaded: () {
                Logger().d("Google Reward Inter Loaded");
                timer!.cancel();
              },
              onComplete: () {
                Logger().d("Google Reward Inter Complete");
                indexIncrement('$route/$actionName', robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['actions'][actionName]['robloxskinLocalClick'].length - 1);
                timer!.cancel();

                onComplete();
              },
              onFailed: () {
                Logger().d("Google Reward Inter Failed");
                RobloxSkinFailedScreenActionBasedAds(
                  actionName: actionName,
                  from: "gri",
                  context: context,
                  onComplete: () {
                    timer!.cancel();

                    onComplete();
                  },
                );
              });
          break;

        default:
          indexIncrement('$route/$actionName', robloxskinMainJson.data![robloxskinMainJson.version]['screens'][route]['actions'][actionName]['robloxskinLocalClick'].length - 1);
          timer!.cancel();

          onComplete();
          break;
      }
    }
  }
}
