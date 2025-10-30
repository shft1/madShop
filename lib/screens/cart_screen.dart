import 'package:flutter/material.dart';

import '../models/product.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class CartScreen extends StatefulWidget {
  final List<Product> cart;
  final void Function(Product) onRemove;

  const CartScreen({super.key, required this.cart, required this.onRemove});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final Map<String, int> _quantities = {};

  @override
  void initState() {
    super.initState();
    for (var p in widget.cart) {
      _quantities[p.id] = 1;
    }
  }

  void _increase(Product p) {
    setState(() => _quantities[p.id] = (_quantities[p.id] ?? 1) + 1);
  }

  void _decrease(Product p) {
    setState(() {
      if ((_quantities[p.id] ?? 1) > 1) {
        _quantities[p.id] = _quantities[p.id]! - 1;
      } else {
        widget.onRemove(p);
        _quantities.remove(p.id);
      }
    });
  }

  double get total => widget.cart.fold(
    0.0,
    (sum, p) => sum + p.price * (_quantities[p.id] ?? 1),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      body: SafeArea(
        child: widget.cart.isEmpty
            ? const Center(child: Text('Cart is empty'))
            : Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: widget.cart.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, i) {
                          final p = widget.cart[i];
                          final qty = _quantities[p.id] ?? 1;

                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  p.imageAsset,
                                  width: 121.18,
                                  height: 101.64,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      p.title,
                                      style: AppTextStyles.title.copyWith(
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '\$${p.price.toStringAsFixed(2)}',
                                      style: AppTextStyles.subtitle,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () => _decrease(p),
                                          icon: const Icon(
                                            Icons.remove,
                                            size: 18,
                                          ),
                                          color: Color(0xFF004CFF),
                                          splashRadius: 16,
                                        ),
                                        Text(
                                          qty.toString(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () => _increase(p),
                                          icon: const Icon(Icons.add, size: 18),
                                          color: Color(0xFF004CFF),
                                          splashRadius: 16,
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.delete_outline,
                                          ),
                                          onPressed: () {
                                            widget.onRemove(p);
                                            setState(
                                              () => _quantities.remove(p.id),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Total: \$${total.toStringAsFixed(2)}',
                            style: AppTextStyles.title.copyWith(fontSize: 18),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Order placed (demo)'),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            minimumSize: const Size(140, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Checkout',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
