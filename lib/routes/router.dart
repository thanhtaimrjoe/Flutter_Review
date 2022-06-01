import 'package:flutter/material.dart';
import 'package:yamabi_admin/routes/route_names.dart';
import 'package:yamabi_admin/screen/home/home.dart';
import 'package:yamabi_admin/screen/login/login.dart';
import 'package:yamabi_admin/screen/product/product.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.LOGIN_PAGE:
        return GeneratePageRoute(MyLoginPage(), RoutesName.LOGIN_PAGE);
      case RoutesName.HOME_PAGE:
        return GeneratePageRoute(MyHomePage(), RoutesName.HOME_PAGE);
      case RoutesName.PRODUCT_DETAIL:
        return GeneratePageRoute(MyProduct(), RoutesName.PRODUCT_DETAIL);
      default:
        return GeneratePageRoute(MyLoginPage(), RoutesName.LOGIN_PAGE);
    }
  }
}

class GeneratePageRoute extends PageRouteBuilder {
  final Widget widget;
  final String routeName;

  GeneratePageRoute(this.widget, this.routeName)
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
        );
}
