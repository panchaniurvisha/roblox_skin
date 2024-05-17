import 'package:flutter/material.dart';
import 'package:roblox_skin/screens/skins/skinsdetail.dart';

import '../screens/main/home.dart';

class Router {
  static MaterialPageRoute onRouteGenerator(settings) {
    switch (settings.name) {
      case Home.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const Home(),
        );
      case SkinsDetail.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SkinsDetail(category: settings.arguments as String),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const Material(
            child: Center(
              child: Text("404 page not founded"),
            ),
          ),
        );
    }
  }
}
