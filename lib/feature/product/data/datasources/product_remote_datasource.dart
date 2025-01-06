import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:product_explore/core/data/response/get_model.dart';

import '../models/product/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> fetchProducts(int limit, int offset);

  Future<ProductModel> fetchProductDetails(int id);
}

@Injectable(as: ProductRemoteDataSource)
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio httpClient;

  ProductRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<List<ProductModel>> fetchProducts(int limit, int offset) async {
    return await httpClient.safeGet<List<ProductModel>>(
      'products?limit=$limit&skip=$offset',
      (json) {
        final productsList = json['products'] as List<dynamic>;

        return productsList.map((item) => ProductModel.fromJson(item)).toList();
      },
    );
  }

  @override
  Future<ProductModel> fetchProductDetails(int id) async {
    final response = await httpClient.safeGet<ProductModel>(
      'products/$id',
      (json) => ProductModel.fromJson(json),
    );
    return response;
  }
}
