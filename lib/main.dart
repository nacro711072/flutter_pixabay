
import 'package:flutter/material.dart';
import 'package:flutter_pixabay/page/home/home.dart';
import 'package:flutter_pixabay/search_page.dart';
import 'di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
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

