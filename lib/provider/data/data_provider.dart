import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roblox_skin/RobloxSkinAds/RobloxSkinAdsMainJson/RobloxSkinAdsMainJson.dart';
import 'package:roblox_skin/RobloxSkinAds/RobloxSkinAdsUtils/RobloxSkinAdsExtensions.dart';

import '../../RobloxSkinAds/RobloxSkinAdsUtils/NavigationService.dart';

class DataProvider extends ChangeNotifier {
  List boy = [];
  List girl = [];
  List bs = [];
  List gs = [];
  List bts = [];
  List gts = [];
  List bcs = [];
  List gcs = [];
  List bcp = [];
  List gcp = [];
  List pet = [];
  List code = [];
  List game = [];

  bool isBoyFetched = false;
  bool isGirlFetched = false;
  bool isBsFetched = false;
  bool isGsFetched = false;
  bool isBtsFetched = false;
  bool isGtsFetched = false;
  bool isBcsFetched = false;
  bool isGcsFetched = false;
  bool isBcpFetched = false;
  bool isGcpFetched = false;
  bool isPetFetched = false;
  bool isCodeFetched = false;
  bool isGameFetched = false;

  int _petCategoryIndex = 0;

  int get petCategoryIndex => _petCategoryIndex;

  set petCategoryIndex(int value) {
    _petCategoryIndex = value;
    notifyListeners();
  }

  Future getBoyData() async {
    if (!isBoyFetched) {
      Response response = await Dio().get("${NavigationService.navigatorKey.currentContext!.read<RobloxskinMainJson>().data!['assets']['boyJson']}".decrypt(),
          options: Options(
            receiveDataWhenStatusError: true,
            receiveTimeout: const Duration(minutes: 1),
          ));
      if (response.data != null) {
        boy = response.data!['Boys'];
        isBoyFetched = true;
        notifyListeners();
      }
    }
    return boy;
  }

  Future getGirlData() async {
    if (!isGirlFetched) {
      Response response = await Dio().get("${NavigationService.navigatorKey.currentContext!.read<RobloxskinMainJson>().data!['assets']['girlsJson']}".decrypt(),
          options: Options(
            receiveDataWhenStatusError: true,
            receiveTimeout: const Duration(minutes: 1),
          ));
      if (response.data != null) {
        girl = response.data!['Girls'];
        isGirlFetched = true;
        notifyListeners();
      }
    }
    return girl;
  }

  Future getBsData() async {
    if (!isBsFetched) {
      Response response = await Dio().get("${NavigationService.navigatorKey.currentContext!.read<RobloxskinMainJson>().data!['assets']['BoysSweatersJson']}".decrypt(),
          options: Options(
            receiveDataWhenStatusError: true,
            receiveTimeout: const Duration(minutes: 1),
          ));
      if (response.data != null) {
        bs = response.data!['Boys Sweaters'];
        isBsFetched = true;
        notifyListeners();
      }
    }
    return bs;
  }

  Future getGsData() async {
    if (!isGsFetched) {
      Response response = await Dio().get("${NavigationService.navigatorKey.currentContext!.read<RobloxskinMainJson>().data!['assets']['GirlsSweatersJson']}".decrypt(),
          options: Options(
            receiveDataWhenStatusError: true,
            receiveTimeout: const Duration(minutes: 1),
          ));
      if (response.data != null) {
        gs = response.data!['Girls Sweaters'];
        isGsFetched = true;
        notifyListeners();
      }
    }
    return gs;
  }

  Future getBtsData() async {
    if (!isBtsFetched) {
      Response response = await Dio().get("${NavigationService.navigatorKey.currentContext!.read<RobloxskinMainJson>().data!['assets']['BoysT-Shirtjson']}".decrypt(),
          options: Options(
            receiveDataWhenStatusError: true,
            receiveTimeout: const Duration(minutes: 1),
          ));
      if (response.data != null) {
        bts = response.data!['Boys T-Shirt'];
        isBtsFetched = true;
        notifyListeners();
      }
    }
    return bts;
  }

  Future getGtsData() async {
    if (!isGtsFetched) {
      Response response = await Dio().get("${NavigationService.navigatorKey.currentContext!.read<RobloxskinMainJson>().data!['assets']['GirlsT-Shirtjson']}".decrypt(),
          options: Options(
            receiveDataWhenStatusError: true,
            receiveTimeout: const Duration(minutes: 1),
          ));
      if (response.data != null) {
        gts = response.data!['Girls T-Shirt'];
        isGtsFetched = true;
        notifyListeners();
      }
    }
    return gts;
  }

  Future getBcsData() async {
    if (!isBcsFetched) {
      Response response = await Dio().get("${NavigationService.navigatorKey.currentContext!.read<RobloxskinMainJson>().data!['assets']['BoysClassicShirtsjson']}".decrypt(),
          options: Options(
            receiveDataWhenStatusError: true,
            receiveTimeout: const Duration(minutes: 1),
          ));
      if (response.data != null) {
        bcs = response.data!['Boys Classic Shirts'];
        isBcsFetched = true;
        notifyListeners();
      }
    }
    return bcs;
  }

  Future getGcsData() async {
    if (!isGcsFetched) {
      Response response = await Dio().get("${NavigationService.navigatorKey.currentContext!.read<RobloxskinMainJson>().data!['assets']['GirlsClassicShirtsjson']}".decrypt(),
          options: Options(
            receiveDataWhenStatusError: true,
            receiveTimeout: const Duration(minutes: 1),
          ));
      if (response.data != null) {
        gcs = response.data!['Girls Classic Shirts'];
        isGcsFetched = true;
        notifyListeners();
      }
    }
    return gcs;
  }

  Future getBcpData() async {
    if (!isBcpFetched) {
      Response response = await Dio().get("${NavigationService.navigatorKey.currentContext!.read<RobloxskinMainJson>().data!['assets']['BoysClassicPantsjson']}".decrypt(),
          options: Options(
            receiveDataWhenStatusError: true,
            receiveTimeout: const Duration(minutes: 1),
          ));
      if (response.data != null) {
        bcp = response.data!['Boys Classic Pants'];
        isBcpFetched = true;
        notifyListeners();
      }
    }
    return bcp;
  }

  Future getGcpData() async {
    if (!isGcpFetched) {
      Response response = await Dio().get("${NavigationService.navigatorKey.currentContext!.read<RobloxskinMainJson>().data!['assets']['GirlsClassicPantsjson']}".decrypt(),
          options: Options(
            receiveDataWhenStatusError: true,
            receiveTimeout: const Duration(minutes: 1),
          ));
      if (response.data != null) {
        gcp = response.data!['Girls Classic Pants'];
        isGcpFetched = true;
        notifyListeners();
      }
    }
    return gcp;
  }

  Future getPetData() async {
    if (!isPetFetched) {
      Response response = await Dio().get("${NavigationService.navigatorKey.currentContext!.read<RobloxskinMainJson>().data!['assets']['Robloxpetjson']}".decrypt(),
          options: Options(
            receiveDataWhenStatusError: true,
            receiveTimeout: const Duration(minutes: 1),
          ));
      if (response.data != null) {
        pet = response.data!['data'];
        isPetFetched = true;
        notifyListeners();
      }
    }
    return pet;
  }

  Future getCodeData() async {
    if (!isCodeFetched) {
      Response response = await Dio().get("${NavigationService.navigatorKey.currentContext!.read<RobloxskinMainJson>().data!['assets']['codeJson']}".decrypt(),
          options: Options(
            receiveDataWhenStatusError: true,
            receiveTimeout: const Duration(minutes: 1),
          ));
      if (response.data != null) {
        code = response.data!['Game Codes'];
        isCodeFetched = true;
        notifyListeners();
      }
    }
    return code;
  }

  Future getGameData() async {
    if (!isGameFetched) {
      Response response = await Dio().get("${NavigationService.navigatorKey.currentContext!.read<RobloxskinMainJson>().data!['assets']['gamesjson']}".decrypt(),
          options: Options(
            receiveDataWhenStatusError: true,
            receiveTimeout: const Duration(minutes: 1),
          ));
      if (response.data != null) {
        game = response.data!['Best Game'];
        isGameFetched = true;
        notifyListeners();
      }
    }
    return game;
  }
}
