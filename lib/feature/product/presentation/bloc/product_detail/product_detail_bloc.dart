import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/usecases/get_product_details.dart';


part 'product_detail_event.dart';

part 'product_detail_state.dart';

part 'product_detail_bloc.freezed.dart';

@injectable
class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final GetProductDetailsUsecase getProductDetails;

  ProductDetailBloc({
    required this.getProductDetails,
  }) : super(const ProductDetailState.initial()) {
    on<FetchProductDetails>(_onFetchProductDetail);
  }

  Future<void> _onFetchProductDetail(FetchProductDetails event, Emitter<ProductDetailState> emit) async {
    final failureOrSuccess = await getProductDetails(event.productId);
    failureOrSuccess.fold(
            (failure) => emit(ProductDetailState.error(message: failure.message)),
            (products) => emit(ProductDetailState.loaded(productDetail:products ))

    );
  }


}
