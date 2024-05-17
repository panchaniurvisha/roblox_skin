import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/material.dart';

import '../RobloxSkinAds/RobloxSkinFullScreen/RobloxSkinAds.dart';

extension NavigationExtension on String {
  Future<void> RobloxSkinPerformAction({
    required BuildContext context,
    required Function() onComplete,
  }) async {
    await RobloxSkinAds().RobloxSkinShowActionBasedAds(
      context: context,
      actionName: this,
      onComplete: () {
        onComplete();
      },
    );
  }

  Future<void> RobloxSkinPerformScreenAction({
    required BuildContext context,
    required Function() onComplete,
  }) async {
    await RobloxSkinAds().RobloxSkinShowScreenActionBasedAds(
      context: context,
      actionName: this,
      onComplete: () {
        onComplete();
      },
    );
  }
}

extension Decryption on String {
  encrypt() {
    final key = enc.Key.fromUtf8('roblox skin master and code 2024');

    final iv = enc.IV.fromUtf8('roblox skin master and code 2024'.substring(0, 16));

    final encrypter = enc.Encrypter(enc.AES(key, padding: null));

    final encrypted = encrypter.encrypt(this, iv: iv);
    return encrypted.base64;
  }

  decrypt() {
    final key = enc.Key.fromUtf8('roblox skin master and code 2024');

    final iv = enc.IV.fromUtf8('roblox skin master and code 2024'.substring(0, 16));
    final encrypter = enc.Encrypter(enc.AES(key, padding: null));
    final decrypted = encrypter.decrypt64(this, iv: iv);
    return decrypted;
  }
}
