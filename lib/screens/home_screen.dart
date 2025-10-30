import 'package:flutter/material.dart';

import '../models/product.dart';
import '../theme/colors.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  final List<Product> products;
  final void Function(Product) onOpenProduct;
  final void Function(Product) onAddToCart;
  final void Function(Product)? onToggleFavorite;
  final bool Function(Product)? isFavorite;
  final VoidCallback onOpenCart;

  const HomeScreen({
    super.key,
    required this.products,
    required this.onOpenProduct,
    required this.onAddToCart,
    this.onToggleFavorite,
    this.isFavorite,
    required this.onOpenCart,
  });

  int _crossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 900) return 4;
    if (width >= 600) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            onPressed: onOpenCart,
            icon: const Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _crossAxisCount(context),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.673,
            ),
            itemBuilder: (context, i) {
              final p = products[i];
              return ProductCard(
                product: p,
                onOpen: () => onOpenProduct(p),
                onAddToCart: () => onAddToCart(p),
                onToggleFavorite: onToggleFavorite != null ? () => onToggleFavorite!(p) : null,
                isFavorite: isFavorite != null ? isFavorite!(p) : false,
              );
            },
          ),
        ),
      ),
    );
  }
}
