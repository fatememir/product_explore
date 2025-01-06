// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../feature/product/data/datasources/product_remote_datasource.dart'
    as _i315;
import '../../feature/product/data/repositories/product_repository_impl.dart'
    as _i319;
import '../../feature/product/domain/repositories/product_repository.dart'
    as _i879;
import '../../feature/product/domain/usecases/get_product_details.dart' as _i84;
import '../../feature/product/domain/usecases/get_products.dart' as _i484;
import '../../feature/product/presentation/bloc/product_bloc.dart' as _i863;
import '../../feature/product/presentation/bloc/product_detail/product_detail_bloc.dart'
    as _i1044;
import 'network_module.dart' as _i567;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i361.Dio>(() => networkModule.httpClient);
    gh.factory<_i315.ProductRemoteDataSource>(
        () => _i315.ProductRemoteDataSourceImpl(httpClient: gh<_i361.Dio>()));
    gh.lazySingleton<_i879.ProductRepository>(
        () => _i319.ProductRepositoryImpl(gh<_i315.ProductRemoteDataSource>()));
    gh.lazySingleton<_i484.GetProductsUsecase>(
        () => _i484.GetProductsUsecase(gh<_i879.ProductRepository>()));
    gh.lazySingleton<_i84.GetProductDetailsUsecase>(
        () => _i84.GetProductDetailsUsecase(gh<_i879.ProductRepository>()));
    gh.factory<_i1044.ProductDetailBloc>(() => _i1044.ProductDetailBloc(
        getProductDetails: gh<_i84.GetProductDetailsUsecase>()));
    gh.factory<_i863.ProductBloc>(
        () => _i863.ProductBloc(getProducts: gh<_i484.GetProductsUsecase>()));
    return this;
  }
}

class _$NetworkModule extends _i567.NetworkModule {}
