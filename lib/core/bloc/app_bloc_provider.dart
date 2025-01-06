import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_explore/feature/product/presentation/screens/product_page.dart';

import '../../feature/product/presentation/bloc/product_bloc.dart';
import '../../feature/splash/preesentation/bloc/splash_bloc.dart';
import '../di/injection_container.dart';

class AppBlocProviders {
  static Future<List<BlocProvider>> getProviders() async {
    return [
      BlocProvider<SplashBloc>(
        create: (context) => SplashBloc(),
      ),
      BlocProvider<ProductBloc>(
        create: (_) => getIt(),
        child: const ProductPage(),
      )
    ];
  }
}
