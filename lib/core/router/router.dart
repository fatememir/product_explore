import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:product_explore/feature/product/presentation/screens/product_page.dart';

import '../../feature/splash/preesentation/screens/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static late GoRouter _router;

  static GoRouter get router => _router;

  static Future<void> initializeRouter() async {
    _router = GoRouter(
      initialLocation: '/splash',
      navigatorKey: navigatorKey,
      routes: [
        GoRoute(
          path: '/splash',
          builder: (context, state) => SplashScreen(),
        ),
        GoRoute(
          path: '/product',
          routes: [],
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: ProductPage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            );
          },
        ),
      ],
    );
  }
}
