import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:product_explore/feature/product/data/models/product/product_list_model.dart';

import '../../../../core/data/api_result.dart';
import '../../../../core/error/exception/failure.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';
import '../models/product/product_model.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ProductListModel>> getProducts(int limit, int offset) async {
    final result = await remoteDataSource.fetchProducts(limit, offset);

    if (result is Success<ProductListModel>) {
      return Right(result.data!);
    } else {
      return Left(ServerFailure("Failed to load product list"));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductDetails(int productId) async {
    final result = await remoteDataSource.fetchProductDetails(productId);

    if (result is Success<ProductModel>) {
      return Right(result.data!);
    } else {
      return Left(ServerFailure("Failed to load product details"));
    }
  }
}
