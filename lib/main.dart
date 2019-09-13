import 'package:flutter/material.dart';
import 'package:timer/page/home/home_page.dart';
import 'package:timer/page/timer/timer_page.dart';

import 'routers/router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: '运动计时器',
      navigatorKey: Router.navigatorKey,
      initialRoute: RouteName.rootPage,
      onGenerateRoute: Router.generateRoute,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
