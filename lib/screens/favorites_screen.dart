import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/product_card.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Product> favorites;
  final void Function(Product) onOpen;
  final void Function(Product) onRemoveFavorite;
  final void Function(Product) onAddToCart;

  const FavoritesScreen({
    super.key,
    required this.favorites,
    required this.onOpen,
    required this.onRemoveFavorite,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty) {
      return const Center(child: Text('No favorites yet'));
    }
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        itemCount: favorites.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.673,
        ),
        itemBuilder: (context, i) {
          final p = favorites[i];
          return ProductCard(
            product: p,
            onOpen: () => onOpen(p),
            onAddToCart: () => onAddToCart(p),
            onToggleFavorite: () => onRemoveFavorite(p),
            isFavorite: true,
          );
        },
      ),
    );
  }
}
