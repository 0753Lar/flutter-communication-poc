import 'package:flutter/material.dart';

class CustomRouteObserver extends NavigatorObserver {
  final BuildContext context;

  CustomRouteObserver(this.context);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
  }
}
