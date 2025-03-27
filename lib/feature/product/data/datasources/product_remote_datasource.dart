import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:product_explore/core/data/response/get_model.dart';
import 'package:product_explore/feature/product/data/models/product/product_list_model.dart';

import '../../../../core/data/api_result.dart';
import '../models/product/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ApiResult<ProductListModel>> fetchProducts(int limit, int offset);

  Future<ApiResult<ProductModel>> fetchProductDetails(int id);
}

@Injectable(as: ProductRemoteDataSource)
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio httpClient;

  ProductRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<ApiResult<ProductListModel>> fetchProducts(int limit, int offset) async {
    return await httpClient.safeGet('products?limit=$limit&skip=$offset', (json) => ProductListModel.fromJson(json));
  }

  @override
  Future<ApiResult<ProductModel>> fetchProductDetails(int id) async {
    return await httpClient.safeGet(
      'products/$id',
      (json) => ProductModel.fromJson(json),
    );
  }
}
