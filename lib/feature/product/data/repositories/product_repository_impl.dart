import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exception/failure.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Product>>> getProducts(int limit, int offset) async {
    var result = await remoteDataSource.fetchProducts(limit, offset);

    if (!result.contains("error")) {
      return Right(result);
    } else {
      return Left(ServerFailure("error"));
    }
  }
}
