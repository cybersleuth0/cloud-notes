import 'package:flutter/cupertino.dart';
import 'package:notes_firebase_app/screens/Auth/login.dart';
import 'package:notes_firebase_app/screens/Auth/signup.dart';

import '../screens/detailspage.dart';
import '../screens/homepage.dart';

class App_Routes {
  static const String ROUTE_HOMEPAGE = "/homepage";
  static const String ROUTE_DETAILSPAGE = "/detailsPage";
  static const String ROUTE_LOGINPAGE = "/loginpage";
  static const String ROUTE_SIGNUP = "/signup";

  static Map<String, WidgetBuilder> getRoutes() => {
    ROUTE_HOMEPAGE: (context) => HomePage(),
    ROUTE_DETAILSPAGE: (context) => Detailspage(),
    ROUTE_LOGINPAGE: (context) => LoginPage(),
    ROUTE_SIGNUP: (context) => SignUpPage(),
  };
}
