import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/products.dart';
import '../../providers/favorites_provider.dart';
import '../../widgets/products/product_item.dart';

class FavoritesScreen extends StatelessWidget {
  static const routeName = '/favorites';

  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final favoritesData = Provider.of<FavoritesProvider>(context);
    
    final favoriteProducts = productsData.getFavoriteItems(favoritesData.favoriteProductIds);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 1200
        ? 5
        : (screenWidth > 900 ? 4 : (screenWidth > 600 ? 3 : 2));

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF020617) : const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          'Your Wishlist',
          style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: favoriteProducts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border_rounded,
                    size: 80,
                    color: isDark ? Colors.white10 : Colors.grey.shade300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your wishlist is empty',
                    style: TextStyle(
                      fontSize: 18,
                      color: isDark ? Colors.white38 : Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          : GridView.builder(
              key: ValueKey(favoriteProducts.length), // Updates the grid when count changes
              padding: const EdgeInsets.all(16),
              itemCount: favoriteProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: screenWidth > 600 ? 0.7 : 0.52,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (ctx, i) => Provider.value(
                key: ValueKey(favoriteProducts[i].id), // Unique key for each product
                value: favoriteProducts[i],
                child: const ProductItem(),
              ),
            ),
    );
  }
}
