import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/product.dart';
import '../../domain/model/get_produt_request_model.dart';
import '../../domain/usecases/get_products.dart';

part 'product_event.dart';

part 'product_state.dart';

part 'product_bloc.freezed.dart';

@injectable
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUsecase getProducts;
  List<Product> _allProducts = [];

  ProductBloc({
    required this.getProducts,
  }) : super(ProductState.initial()) {
    on<FetchProductsEvents>(_onFetchProducts);
    on<NavigateToDetailEvent>(_onGoToProductDetail);
    on<SearchProductsEvent>(_onSearchProducts);
  }

  Future<void> _onFetchProducts(FetchProductsEvents event, Emitter<ProductState> emit) async {
    if (event.offset == 0) {
      emit(ProductState.loading());
    }

    final failureOrSuccess = await getProducts(
        GetProductRequestModel(limit: event.limit, offset: event.offset));

    failureOrSuccess.fold(
          (failure) => emit(ProductState.error(message: failure.message)),
          (newProducts) {
        if (event.offset == 0) {
          _allProducts = newProducts;
        } else {
          _allProducts.addAll(newProducts);
        }
        emit(ProductState.loaded(products: List.from(_allProducts)));
      },
    );
  }

  void _onGoToProductDetail(NavigateToDetailEvent event, Emitter<ProductState> emit) {
    event.context.go(
      "/product/productDetail",
      extra: event.id,
    );
  }

  Future<void> _onSearchProducts(SearchProductsEvent event, Emitter<ProductState> emit) async {
    if (_allProducts.isNotEmpty) {
      final filteredProducts = _allProducts.where((product) {
        return product.title!.toLowerCase().startsWith(event.query.toLowerCase());
      }).toList();

      if (filteredProducts.isEmpty) {
        emit(ProductState.loaded(products: _allProducts));
      } else {
        emit(ProductState.loaded(products: filteredProducts));
      }
    }
  }
}
