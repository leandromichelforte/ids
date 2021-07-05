import 'package:flutter/material.dart';
import 'package:ids/models/constants_model.dart';
import 'package:ids/views/create_edit_view.dart';
import 'package:ids/views/home_view.dart';
import 'package:ids/views/splashscreen_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (RouteSettings settings) {
        var routes = <String, WidgetBuilder>{
          Routes.homeRoute: (context) => HomeView(),
          Routes.createEditRoute: (context) => CreateEditView(),
        };
        WidgetBuilder builder = routes[settings.name]!;
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
      title: 'IDS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: {
        Routes.homeRoute: (context) => HomeView(),
        Routes.createEditRoute: (context) => CreateEditView(),
      },
    );
  }
}
