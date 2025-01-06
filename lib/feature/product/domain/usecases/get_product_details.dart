import 'package:injectable/injectable.dart';
import '../../../../core/error/exception/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

@lazySingleton
class GetProductDetailsUsecase implements UseCase<Product, int> {
  final ProductRepository repository;

  GetProductDetailsUsecase(this.repository);

  @override
  Future<Either<Failure, Product>> call(int productId) async {
    return await repository.getProductDetails(productId);
  }
}
