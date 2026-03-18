import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../../providers/cart.dart';
import '../../providers/settings_provider.dart';
import '../../providers/favorites_provider.dart';
import '../../screens/products/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final settings = Provider.of<SettingsProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double cardWidth = constraints.maxWidth;
        final double titleFontSize = cardWidth * 0.085;

        return Container(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              if (!isDark)
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image Section - Increased flex to give more room to image
                    Expanded(
                      flex: 7,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            ProductDetailScreen.routeName,
                            arguments: product.id,
                          );
                        },
                        child: Hero(
                          tag: product.id,
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.all(cardWidth * 0.04),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: NetworkImage(product.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Details Section
                    Expanded(
                      flex: 3, // Reduced flex to make text area compact
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: cardWidth * 0.08),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start, // Changed to start to remove large gaps
                          children: [
                            Text(
                              product.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: titleFontSize.clamp(12.0, 15.0),
                                color: isDark ? Colors.white : const Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 2),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star_rounded,
                                    color: Colors.amber,
                                    size: (titleFontSize * 0.8).clamp(12, 14),
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    product.rating.toString(),
                                    style: TextStyle(
                                      fontSize: (titleFontSize * 0.7).clamp(10, 12),
                                      fontWeight: FontWeight.bold,
                                      color: isDark ? Colors.white70 : Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '(${product.reviewsCount})',
                                    style: TextStyle(
                                      fontSize: (titleFontSize * 0.6).clamp(9, 11),
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              product.category,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: (titleFontSize * 0.65).clamp(9.0, 11.0),
                                color: isDark ? Colors.white60 : Colors.grey.shade500,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(), // Pushes the price row to the bottom of the details area
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: FittedBox(
                                    alignment: Alignment.centerLeft,
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      settings.formatPrice(product.price),
                                      style: const TextStyle(
                                        color: Color(0xFF3B82F6),
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    cart.addItem(
                                      product.id,
                                      product.price,
                                      product.title,
                                      product.imageUrl,
                                    );
                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('${product.title} added!'),
                                        duration: const Duration(seconds: 1),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: isDark ? const Color(0xFF3B82F6) : const Color(0xFF1E293B),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.add_shopping_cart_rounded,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: cardWidth * 0.05), // Small padding at the very bottom
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: cardWidth * 0.06,
                  right: cardWidth * 0.06,
                  child: Consumer<FavoritesProvider>(
                    builder: (ctx, favorites, _) {
                      final isFavorite = favorites.isFavorite(product.id);
                      return GestureDetector(
                        onTap: () => favorites.toggleFavorite(product.id),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : const Color(0xFF1E293B),
                            size: 16,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
