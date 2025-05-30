import 'package:flutter/cupertino.dart';

import '../screens/detailspage.dart';
import '../screens/homepage.dart';

class App_Routes {
  static const String ROUTE_HOMEPAGE = "/homepage";
  static const String ROUTE_DETAILSPAGE = "/detailsPage";

  static Map<String, WidgetBuilder> getRoutes() => {
    ROUTE_HOMEPAGE: (context) => HomePage(),
    ROUTE_DETAILSPAGE: (context) => Detailspage(),
  };
}
