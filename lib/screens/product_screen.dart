import 'package:flutter/material.dart';

import '../models/product.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class ProductScreen extends StatelessWidget {
  final Product product;
  final void Function(Product) onAddToCart;

  const ProductScreen({super.key, required this.product, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(backgroundColor: AppColors.primary, title: Text(product.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          AspectRatio(aspectRatio: 1.6, child: ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset(product.imageAsset, fit: BoxFit.cover))),
          const SizedBox(height: 12),
          Text(product.title, style: AppTextStyles.title.copyWith(fontSize: 22)),
          const SizedBox(height: 8),
          Text(product.description, style: AppTextStyles.subtitle),
          const SizedBox(height: 12),
          Text('\$${product.price.toStringAsFixed(2)}', style: AppTextStyles.price.copyWith(fontSize: 20)),
          const SizedBox(height: 18),
          ElevatedButton.icon(
            onPressed: () {
              onAddToCart(product);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart')));
            },
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('Add to cart'),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, minimumSize: const Size.fromHeight(48)),
          ),
        ]),
      ),
    );
  }
}


