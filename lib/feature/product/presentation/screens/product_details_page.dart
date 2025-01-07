import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/images.dart';
import '../bloc/product_detail/product_detail_bloc.dart';

class ProductDetailsPage extends StatelessWidget {
  final int productId;

  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    context.read<ProductDetailBloc>().add(ProductDetailEvent.fetchProductDetails(productId: productId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is Loaded) {
            final product = state.productDetail;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: product.thumbnail != null
                        ? cashImage(
                            product.thumbnail,
                            height: 250,
                          )
                        : const Placeholder(fallbackHeight: 250, fallbackWidth: double.infinity),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product.title ?? "No Title",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Price: \$${product.price?.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.green[700]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Brand: ${product.brand}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.green[700]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.category, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        '${product.category}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Text(
                    'Stock: ${product.stock?.toString()}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.green[700]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      product.description ?? "No description available.",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            );
          } else if (state is Error) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No details available'));
        },
      ),
    );
  }
}
