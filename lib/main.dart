import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_pixabay/logic/picture_paging_logic.dart';
import 'package:flutter_pixabay/page/home/home.dart';
import 'package:flutter_pixabay/repository/picture_repository.dart';
import 'package:flutter_pixabay/search_page.dart';
import 'package:flutter_pixabay/service/pixabay_service.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'di/injection.dart';
import 'entity/vo/image_item_vo.dart';
import 'list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          dividerTheme: const DividerThemeData(
            space: 0,
            thickness: 1,
          ),
          cardTheme: const CardTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          )),
      initialRoute: MyHomePage.routerName,
      onGenerateRoute: (setting) {
        var routes = <String, WidgetBuilder>{
          MyHomePage.routerName: (ctx) => MyHomePage(
              args: setting.arguments as HomeArguments?,
              title: 'Flutter Demo Home Page'),
          "/search": (ctx) => SearchPage(),
        };
        WidgetBuilder builder = routes[setting.name]!;
        return MaterialPageRoute(
            builder: (ctx) => builder(ctx), settings: setting);
      },
    );
  }
}

