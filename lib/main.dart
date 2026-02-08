import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:aum_order/src/rust/frb_generated.dart';
import 'package:aum_order/src/core/routing/app_router.dart';

Future<void> main() async {
  await RustLib.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        routerConfig: appRouter,
        title: 'Foodie Express',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
