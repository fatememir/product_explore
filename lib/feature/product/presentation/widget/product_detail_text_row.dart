import 'package:flutter/material.dart';

class ProductDetailRow extends StatelessWidget {
  final String label;
  final String? value;

  const ProductDetailRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$label: ${value ?? '--'}',
      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.green[700]),
      textAlign: TextAlign.center,
    );
  }
}
