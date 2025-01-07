import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:product_explore/feature/product/presentation/screens/product_page.dart';

import '../../feature/product/presentation/bloc/product_detail/product_detail_bloc.dart';
import '../../feature/product/presentation/screens/product_details_page.dart';
import '../../feature/splash/preesentation/screens/splash_screen.dart';
import '../di/injection_container.dart';

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
          routes: [
            GoRoute(
              path: 'productDetail',
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  child: BlocProvider(
                    create: (_) => getIt<ProductDetailBloc>(),
                    child: ProductDetailsPage(productId: state.extra as int),
                  ),
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
