// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductListModelImpl _$$ProductListModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductListModelImpl(
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProductListModelImplToJson(
        _$ProductListModelImpl instance) =>
    <String, dynamic>{
      'products': instance.products,
    };
