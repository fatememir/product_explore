import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:product_explore/feature/product/data/models/product/product_model.dart';
import '../../../domain/entities/product_list.dart';

part 'product_list_model.g.dart';

part 'product_list_model.freezed.dart';

@freezed
class ProductListModel with _$ProductListModel implements ProductListEntity {
  const factory ProductListModel({
    required List<ProductModel> products,
  }) = _ProductListModel;

  factory ProductListModel.fromJson(Map<String, dynamic> json) => _$ProductListModelFromJson(json);
}
