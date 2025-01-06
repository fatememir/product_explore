part of 'product_detail_bloc.dart';

@freezed
class ProductDetailState with _$ProductDetailState {

  const factory ProductDetailState.initial() = Initial;

  const factory ProductDetailState.loading() = Loading;

  const factory ProductDetailState.loaded ({
    required Product productDetail,
  }) = Loaded;

  const factory ProductDetailState.error({
    required String message,
  }) = Error;


}

