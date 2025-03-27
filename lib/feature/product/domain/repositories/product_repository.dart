import 'package:product_explore/feature/product/domain/entities/product_list.dart';

import '../../../../core/error/exception/failure.dart';
import '../entities/product.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductListEntity>> getProducts(int limit, int offset);

  Future<Either<Failure, Product>> getProductDetails(int productId);
}
