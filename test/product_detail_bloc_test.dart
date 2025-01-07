import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_explore/core/error/exception/failure.dart';
import 'package:product_explore/feature/product/domain/entities/product.dart';
import 'package:product_explore/feature/product/domain/usecases/get_product_details.dart';
import 'package:product_explore/feature/product/presentation/bloc/product_detail/product_detail_bloc.dart';

// Create mock for GetProductDetailsUsecase
class MockGetProductDetailsUsecase extends Mock implements GetProductDetailsUsecase {}

void main() {
  late ProductDetailBloc bloc;
  late MockGetProductDetailsUsecase mockGetProductDetailsUsecase;

  setUp(() {
    mockGetProductDetailsUsecase = MockGetProductDetailsUsecase();

    bloc = ProductDetailBloc(
      getProductDetails: mockGetProductDetailsUsecase,
    );
  });

  group('GetProductDetail', () {
    final productDetail = Product(
      id: 1,
      title: "test",
      price: 9.2,
      rating: 5,
      description: "test test test",
      brand: "nike",
      category: "test1",
      stock: 1,
      thumbnail: "https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/thumbnail.png",
    );

    test(
      'should get data from the get product detail use case',
          () async {
        // arrange
        when(mockGetProductDetailsUsecase(any)).thenAnswer((_) async => Right(productDetail)); // Correctly mock the method

        // act
        bloc.add(FetchProductDetails(productId: 1));
        await untilCalled(mockGetProductDetailsUsecase(any));  // Wait until mock is called

        // assert
        verify(mockGetProductDetailsUsecase(1)); // Verify if the correct productId was passed
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
          () async {
        // arrange
        when(mockGetProductDetailsUsecase(any)).thenAnswer((_) async => Right(productDetail));

        // assert later
        final expected = [
          Loading(),
          Loaded(productDetail: productDetail),
        ];
        expectLater(bloc, emitsInOrder(expected));

        // act
        bloc.add(FetchProductDetails(productId: 1));
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
          () async {
        // arrange
        when(mockGetProductDetailsUsecase(any)).thenAnswer((_) async => Left(ServerFailure("error in test")));

        // assert later
        final expected = [
          Loading(),
          Error(message: "error in test"),
        ];
        expectLater(bloc, emitsInOrder(expected));

        // act
        bloc.add(FetchProductDetails(productId: 1));
      },
    );
  });
}
