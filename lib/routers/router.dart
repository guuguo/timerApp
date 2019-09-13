import 'package:flutter/material.dart';
import 'package:timer/page/home/home_page.dart';
import 'package:timer/page/timer/timer_page.dart';

class RouteName {
  static const String rootPage = '/';
  static const String exercisePage = '/exercise';
}

class Router {
  /// 返回页面 可以自定义动画
  ///
  /// [settings] 路由配置
  /// 返回是Map类型value为[Route] 的实现类
  static PageRoute _pageRoutes(RouteSettings settings) {
    PageRoute pageRoute;

    switch (settings.name) {
      case RouteName.rootPage:
        pageRoute = MaterialBuilder(HomePage());
        break;
      case RouteName.exercisePage:
        pageRoute = MaterialBuilder(TimerPage(settings.arguments));
        break;
      default:
        pageRoute = null;
    }
    return pageRoute;
  }

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static NavigatorState get navigator => navigatorKey.currentState;

  /// 路由配置
  static Route<dynamic> generateRoute(RouteSettings settings) {
    PageRoute page = _pageRoutes(settings);
    if (page != null) {
      return page;
    } else {
      return MaterialBuilder(Scaffold(
        body: Center(
          child: Text('No route defined for ${page.settings.name}'),
        ),
      ));
    }
  }
}

class MaterialBuilder extends MaterialPageRoute {
  final Widget page;

  MaterialBuilder(this.page) : super(builder: (_) => page);
}
