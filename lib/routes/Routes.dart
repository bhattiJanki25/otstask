import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otstask/Screens/ProductListScreen.dart';

import '../Screens/ProductDetailScreen.dart';

class Routes {
  static const list = "/";
  static const detail = "detail";
  static String currentRoute = list;
  static Route<dynamic> onGenerateRouted(RouteSettings routeSettings) {
    //to track current route
    //this will only track pushed route on top of previous route
    currentRoute = routeSettings.name ?? "";
    print("Current Route is $currentRoute");
    switch (routeSettings.name) {
      case list:
        return CupertinoPageRoute(builder: (context) => ProductListingPage());
      case detail:
        return ProductDetailsPage.route(routeSettings);
      default:
        return CupertinoPageRoute(builder: (context) => Scaffold());
    }
  }
}
