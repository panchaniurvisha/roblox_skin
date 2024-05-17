import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class FavoriteProvider extends ChangeNotifier {
  List favorite = [];
  GetStorage box = GetStorage();

  initCollection() {
    favorite = box.read("favorite") ?? [];
    // notifyListeners();
  }

  addToCollection({required Map item}) {
    favorite = box.read("favorite") ?? [];
    favorite.add(item);
    box.write("favorite", favorite);
    notifyListeners();
  }

  removeFromCollection({required String itemName}) {
    favorite = box.read("favorite") ?? [];
    favorite.removeAt(favorite.indexWhere((map) => map['Name'] == itemName));
    box.write("favorite", favorite);
    notifyListeners();
  }
}
