part of 'product_bloc.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState.initial() = Initial;
  const factory ProductState.loading() = Loading;
  const factory ProductState.loaded({
    required List<Product> products,
  }) = Loaded;
  const factory ProductState.error({required String message}) = Error;
}
