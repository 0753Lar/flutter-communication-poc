import 'package:dashboard/src/config/router.dart';
import 'package:dashboard/src/modals/counter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Counter()),
        ],
        child: MaterialApp.router(
          routerConfig: router,
        )),
  );
}
