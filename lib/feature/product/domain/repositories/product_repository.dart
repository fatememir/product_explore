import '../../../../core/error/exception/failure.dart';
import '../entities/product.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts(int limit, int offset);
}
