import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/products.dart';
import '../../widgets/products/product_item.dart';

class CategoryProductsScreen extends StatelessWidget {
  static const routeName = '/category-products';

  const CategoryProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryName = ModalRoute.of(context)!.settings.arguments as String;
    final productsData = Provider.of<Products>(context);
    final categoryProducts = productsData.findByCategory(categoryName);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 1200
        ? 5
        : (screenWidth > 900 ? 4 : (screenWidth > 600 ? 3 : 2));

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF020617) : const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          categoryName.toUpperCase(),
          style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
        centerTitle: true,
      ),
      body: categoryProducts.isEmpty
          ? Center(
              child: Text(
                'No products in this category.',
                style: TextStyle(color: isDark ? Colors.white38 : Colors.grey),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: categoryProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: screenWidth > 600 ? 0.7 : 0.55,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (ctx, i) => Provider.value(
                value: categoryProducts[i],
                child: const ProductItem(),
              ),
            ),
    );
  }
}
