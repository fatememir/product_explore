import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';
import '../widget/product_list_item.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final int _limit = 10;
  int _offset = 0;

  @override
  void initState() {
    super.initState();
    _fetchInitialProducts();
  }

  void _fetchInitialProducts() {
    if (context
        .read<ProductBloc>()
        .state is Initial) {
      context.read<ProductBloc>().add(ProductEvent.fetchProducts(limit: _limit, offset: _offset));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Explorer'),
      ),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is NavigateToDetail) {}
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is Initial || (state is Loading && _offset == 0)) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is Loaded) {
              return _buildProductList(state.products);
            } else if (state is Error) {
              return Center(child: Text(state.message));
            }

            return const Center(child: Text('No Products Found'));
          },
        ),
      ),
    );
  }

  Widget _buildProductList(List<Product> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductListItem(
          product: products[index],
          onPressed: (id) {},
        );
      },
    );
  }
}
