import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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

  ProductBloc({
    required this.getProducts,
  }) : super(Initial()) {
    on<FetchProductsEvents>(_onFetchProducts);
    on<NavigateToDetailEvent>(_onGoToProductDetail);
  }

  Future<void> _onFetchProducts(FetchProductsEvents event, Emitter<ProductState> emit) async {
    emit(ProductState.loading());

    final failureOrSuccess = await getProducts(GetProductRequestModel(limit: event.limit, offset: event.offset));
    failureOrSuccess.fold((l) => emit(ProductState.error(message: l.message)), (r) => emit(ProductState.loaded(products: r)));

  }

  Future<void> _onGoToProductDetail(NavigateToDetailEvent event, Emitter<ProductState> emit) async {
    emit(ProductState.navigateToDetail(id:event.id));
  }
}
