import 'package:dashboard/src/modals/counter.dart';
import 'package:dashboard/src/screens/dashboard.dart';
import 'package:dashboard/src/widgets/custom_router_observer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      // MultiProvider(
      //     providers: [
      //       ChangeNotifierProvider(create: (_) => Counter()),
      //     ],
      //     child: MaterialApp.router(
      //       routerConfig: router,
      //     )),
      MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Counter()),
    ],
    builder: (context, child) {
      return MaterialApp(
        home: const Dashboard(),
        navigatorObservers: [CustomRouteObserver(context)],
      );
    },
  ));
}
