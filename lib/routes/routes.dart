import 'package:xianliao/pages/movie.dart';
import 'package:xianliao/pages/tabs/tab.dart';
import 'package:xianliao/pages/topic/detail.dart';
import 'package:xianliao/pages/user/login.dart';
import 'package:flutter/material.dart';
import 'package:xianliao/pages/home.dart';
import 'package:xianliao/pages/movie.dart';
import '../pages/home.dart';
import '../pages/movie.dart';
import 'package:xianliao/routes/router.dart';
import 'package:xianliao/models/movie.dart';

final routerRoot = "/";

final routes = {
  '/': (context, {arguments}) => TabsPage(arguments: arguments),
  '/user/login': (context) => LoginScreen(),
  '/movie': (context, {arguments}) => MoviePage(arguments: arguments),
  '/topic/detail': (context, {arguments}) =>
      TopicDetailProvider(arguments: arguments),
};

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  } else {
    return MaterialPageRoute(builder: (context) => NoFound());
  }
  ;
}

class NoFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBar(
      title: Text('路由不存在！'),
    );
  }
}

class Routes {
  static String root = '/';
  static String detail = '/movie/{id}';

  static configureRoutes() {
    Routers.register(root, (BuildContext context, Map urlParams, {Map params}) {
      return Home();
    });

    Routers.register(detail, (BuildContext context, Map urlParams,
        {Map params}) {
      MovieParams arguments;
      arguments.movieID = urlParams['id'];
      arguments.movie =
          params != null && params['movie'] != null ? params['movie'] : null;
      return MoviePage(
        arguments: arguments,
      );
    });
  }
}
