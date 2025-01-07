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
  final ScrollController _scrollController = ScrollController();
  final int _limit = 10;
  int _offset = 0;
  bool _isLoadingMore = false;
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchInitialProducts();

    _searchController.addListener(_onSearchChanged);

    _scrollController.addListener(() {
      if (_isNearBottom() && !_isLoadingMore) {
        _loadMoreProducts();
      }
    });
  }

  bool _isNearBottom() {
    return _scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100;
  }

  void _fetchInitialProducts() {
    if (context.read<ProductBloc>().state is Initial) {
      context.read<ProductBloc>().add(ProductEvent.fetchProducts(limit: _limit, offset: _offset));
    }
  }

  void _loadMoreProducts() {
    setState(() {
      _isLoadingMore = true;
    });

    _offset += _limit;
    context.read<ProductBloc>().add(ProductEvent.fetchProducts(limit: _limit, offset: _offset));
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });

    context.read<ProductBloc>().add(ProductEvent.searchProducts(query: _searchQuery));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Explorer'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search products by title...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
      ),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is Loaded || state is Error) {
            setState(() {
              _isLoadingMore = false;
            });
          }
        },
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is Loading && _offset == 0) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is Loaded) {
              if (state.products.isNotEmpty) {
                return _buildProductList(state.products);
              } else {
                return const Center(child: Text('No Products Found'));
              }
            } else if (state is Error) {
              return Center(child: Text(state.message));
            }

            return const Center(child: Text('Unexpected state'));
          },
        ),
      ),
    );
  }

  Widget _buildProductList(List<Product> products) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: products.length + (_isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == products.length) {
          return const Center(child: CircularProgressIndicator());
        }
        final product = products[index];
        return ProductListItem(
          product: product,
          onPressed: (id) {
            _searchController.clear();

            context.read<ProductBloc>().add(
              NavigateToDetailEvent(
                context: context,
                id: id,
              ),
            );
          },
        );
      },
    );
  }
}
