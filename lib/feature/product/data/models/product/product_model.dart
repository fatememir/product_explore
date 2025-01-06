import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/product.dart';

part 'product_model.g.dart';

part 'product_model.freezed.dart';

@freezed
class ProductModel with _$ProductModel implements Product {
  const factory ProductModel({
    required int? id,
    required String? title,
    required double? price,
    required double? rating,
    required String? description,
    required String? brand,
    required String? category,
    required int? stock,
    required String? thumbnail,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
}
