import 'package:injectable/injectable.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product.dart';
import '../model/get_produt_request_model.dart';
import '../repositories/product_repository.dart';

@lazySingleton
class GetProductsUsecase implements UseCase<List<Product>, GetProductRequestModel> {
  final ProductRepository repository;

  GetProductsUsecase(this.repository);

  @override
  Future<List<Product>> call(GetProductRequestModel request) async {
    return await repository.getProducts(request.limit, request.offset);
  }
}
