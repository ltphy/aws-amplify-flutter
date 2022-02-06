import 'package:aws_amplify_flutter/screens/entry/entry.dart';
import 'package:flutter/material.dart';

typedef PathWidgetBuilder = Widget Function(
    BuildContext context, RouteSettings settings);

class Path {
  final String route;
  final PathWidgetBuilder builder;

  Path({
    required this.route,
    required this.builder,
  });
}

class RouteConfiguration {
  static final List<Path> paths = [
    Path(
        route: EntryScreen.route,
        builder: (context, settings) {
          return const EntryScreen();
        })
  ];

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    for (Path path in paths) {
      if (path.route == settings.name) {
        return MaterialPageRoute(
          builder: (context) {
            return path.builder(context, settings);
          },
          settings: settings,
        );
      }
    }
    throw Exception('Invalid route ${settings.name}');
  }
}
