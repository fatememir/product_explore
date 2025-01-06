// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductModelImpl _$$ProductModelImplFromJson(Map<String, dynamic> json) =>
    _$ProductModelImpl(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble(),
      description: json['description'] as String?,
      brand: json['brand'] as String?,
      category: json['category'] as String?,
      stock: (json['stock'] as num?)?.toInt(),
      thumbnail: json['thumbnail'] as String?,
    );

Map<String, dynamic> _$$ProductModelImplToJson(_$ProductModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'rating': instance.rating,
      'description': instance.description,
      'brand': instance.brand,
      'category': instance.category,
      'stock': instance.stock,
      'thumbnail': instance.thumbnail,
    };
