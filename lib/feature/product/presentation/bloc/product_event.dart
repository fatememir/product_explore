part of 'product_bloc.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.fetchProducts({required int limit, required int offset}) = FetchProductsEvents;
  const factory ProductEvent.navigateToDetail({required int id}) = NavigateToDetailEvent;
}
