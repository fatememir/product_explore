import 'package:injectable/injectable.dart';
import 'package:product_explore/feature/product/domain/entities/product_list.dart';
import '../../../../core/error/exception/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../model/get_produt_request_model.dart';
import '../repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

@lazySingleton
class GetProductsUsecase implements UseCase<ProductListEntity, GetProductRequestModel> {
  final ProductRepository repository;

  GetProductsUsecase(this.repository);

  @override
  Future<Either<Failure, ProductListEntity>> call(GetProductRequestModel request) async {
    return await repository.getProducts(request.limit, request.offset);
  }
}
