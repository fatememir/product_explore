import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/images.dart';
import '../bloc/product_detail/product_detail_bloc.dart';
import '../widget/product_detail_text_row.dart';

class ProductDetailsPage extends StatelessWidget {
  final int productId;

  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    context.read<ProductDetailBloc>().add(
          ProductDetailEvent.fetchProductDetails(productId: productId),
        );

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
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  ProductDetailRow(
                    label: 'Price',
                    value: '\$${product.price?.toStringAsFixed(2) ?? "--"}',
                  ),
                  const SizedBox(height: 8),
                  ProductDetailRow(
                    label: 'Brand',
                    value: product.brand ?? "--",
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.category, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        product.category ?? "--",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ProductDetailRow(
                    label: 'Stock',
                    value: product.stock?.toString() ?? "--",
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
