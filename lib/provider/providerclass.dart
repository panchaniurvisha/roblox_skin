import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/data_provider.dart';
import 'favorite/favorite_provider.dart';

class ProviderClass extends StatelessWidget {
  final Widget child;

  const ProviderClass({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<DataProvider>(
        create: (context) => DataProvider(),
      ),
      ChangeNotifierProvider<FavoriteProvider>(
        create: (context) => FavoriteProvider(),
      ),
    ], child: child);
  }
}
