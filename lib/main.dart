import 'package:flutter/material.dart';

import 'models/app_user.dart';
import 'models/product.dart';
import 'screens/cart_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/product_screen.dart';
import 'screens/start_screen.dart';
import 'theme/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final List<Product> _products;
  final List<Product> _cart = [];
  final Set<String> _favorites = {};
  final List<AppUser> _users = [];
  int _currentIndex = 0;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _products = [
      Product(
        id: '1',
        title: 'Leather Jacket',
        description: 'High quality leather jacket',
        price: 79.90,
        imageAsset: 'assets/images/product1.png',
      ),
      Product(
        id: '2',
        title: 'Running Shoes',
        description: 'Comfortable running shoes',
        price: 59.50,
        imageAsset: 'assets/images/product2.png',
      ),
      Product(
        id: '3',
        title: 'Smart Watch',
        description: 'Modern smartwatch with features',
        price: 129.00,
        imageAsset: 'assets/images/product3.png',
      ),
      Product(
        id: '4',
        title: 'Backpack',
        description: 'Durable travel backpack',
        price: 39.99,
        imageAsset: 'assets/images/product4.png',
      ),
      Product(
        id: '5',
        title: 'Sunglasses',
        description: 'Stylish UV-protective sunglasses',
        price: 19.99,
        imageAsset: 'assets/images/product5.png',
      ),
      Product(
        id: '6',
        title: 'Hat',
        description: 'Casual everyday hat',
        price: 14.99,
        imageAsset: 'assets/images/product6.png',
      ),
    ];

    // Seed a default user for login-only flow
    _users.add(AppUser(email: 'user@gmail.com', password: 'useruser'));
  }

  void _addToCart(Product p) {
    setState(() => _cart.add(p));
  }

  void _removeFromCart(Product p) {
    setState(() => _cart.remove(p));
  }

  void _toggleFavorite(Product p) {
    setState(() {
      if (_favorites.contains(p.id)) {
        _favorites.remove(p.id);
      } else {
        _favorites.add(p.id);
      }
    });
  }

  bool _attemptLogin(String email, String password) {
    final existing = _users.where((u) => u.email == email).toList();
    if (existing.isEmpty) {
      return false;
    }
    final ok = existing.first.password == password;
    if (ok) {
      setState(() => _started = true);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MAD Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          foregroundColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: !_started
          ? Builder(
              builder: (innerContext) => StartScreen(
                onLogin: () => Navigator.pushNamed(innerContext, '/login'),
              ),
            )
          : Builder(
              builder: (innerContext) {
                final pages = [
                  HomeScreen(
                    products: _products,
                    onOpenProduct: (p) => Navigator.push(
                      innerContext,
                      MaterialPageRoute(
                        builder: (_) =>
                            ProductScreen(product: p, onAddToCart: _addToCart),
                      ),
                    ),
                    onAddToCart: _addToCart,
                    onToggleFavorite: _toggleFavorite,
                    isFavorite: (p) => _favorites.contains(p.id),
                    onOpenCart: () => setState(() => _currentIndex = 2),
                  ),
                  FavoritesScreen(
                    favorites: _products
                        .where((p) => _favorites.contains(p.id))
                        .toList(),
                    onOpen: (p) => Navigator.push(
                      innerContext,
                      MaterialPageRoute(
                        builder: (_) =>
                            ProductScreen(product: p, onAddToCart: _addToCart),
                      ),
                    ),
                    onRemoveFavorite: _toggleFavorite,
                    onAddToCart: _addToCart,
                  ),
                  CartScreen(cart: _cart, onRemove: _removeFromCart),
                ];
                return Scaffold(
                  body: pages[_currentIndex],
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: _currentIndex,
                    onTap: (i) => setState(() => _currentIndex = i),
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.favorite),
                        label: 'Favorites',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.shopping_bag),
                        label: 'Cart',
                      ),
                    ],
                  ),
                );
              },
            ),
      routes: {'/login': (_) => LoginScreen(onSubmit: _attemptLogin)},
    );
  }
}
